import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../common/errors.dart';
import 'repository.dart';
import 'dto.dart';

class Rate extends Equatable {
  final String title;
  final int value;

  const Rate({required this.title, required this.value});

  @override
  List<Object?> get props => [title, value];
}

class ScreenData extends Equatable {
  final String leftRate;
  final String rightRate;
  final List<Rate> rates;
  final String educationTitle;
  final List<String> educationList;

  const ScreenData({
    required this.leftRate,
    required this.rightRate,
    required this.rates,
    required this.educationTitle,
    required this.educationList,
  });

  @override
  List<Object?> get props => [leftRate, rightRate, rates, educationTitle, educationList];
}

class SkillsScreenState extends Equatable {
  final bool isLoading;
  final ScreenData? screenData;
  final RepositoryError? error;

  const SkillsScreenState({required this.isLoading, this.screenData, this.error});

  @override
  List<Object?> get props => [isLoading, screenData, error];

  SkillsScreenState copyWith({
    required bool isLoading,
    ScreenData? screenData,
    RepositoryError? error,
  }) {
    return SkillsScreenState(
      isLoading: isLoading,
      screenData: screenData ?? this.screenData,
      error: error ?? this.error,
    );
  }
}

abstract class SkillsScreenController {
  Future<void> loadData(String language);
  Stream<SkillsScreenState> get stream;
  SkillsScreenState get state;
}

class SkillsScreenControllerImpl implements SkillsScreenController {
  final StreamController<SkillsScreenState> _controller =
      StreamController<SkillsScreenState>.broadcast();

  SkillsScreenState _state = const SkillsScreenState(isLoading: false);

  final SkillsRepository _repository;

  SkillsScreenControllerImpl({
    required SkillsRepository repository,
  }) : _repository = repository;

  @override
  Stream<SkillsScreenState> get stream => _controller.stream;

  @override
  SkillsScreenState get state => _state;

  void emit(SkillsScreenState newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  Future<void> loadData(String language) async {
    if (state.isLoading) {
      return;
    }

    emit(_state.copyWith(isLoading: true, screenData: null, error: null));

    try {
      final repositoryData = await _repository.loadData(language);

      emit(
        _state.copyWith(
          isLoading: false,
          screenData: repositoryData.toScreenData,
        ),
      );
    } catch (error) {
      emit(_state.copyWith(
        isLoading: false,
        error: RepositoryError(
          message: error.toString(),
        ),
      ));
    }
  }
}

extension on SkillsScreenDTO {
  ScreenData get toScreenData => ScreenData(
        leftRate: leftRate,
        rightRate: rightRate,
        educationTitle: education,
        educationList: educationList,
        rates: rateList
            .map((el) => Rate(
                  title: el.split(':')[0],
                  value: int.parse(el.split(':')[1]),
                ))
            .toList(),
      );
}
