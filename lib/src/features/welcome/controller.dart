import 'dart:async';

import 'package:equatable/equatable.dart';

import 'dto.dart';
import 'repository.dart';
import '../../common/errors.dart';

class ScreenData extends Equatable {
  final String title;
  final String description;
  final String tryAgainLabel;
  final String phone1;
  final String phone2;

  const ScreenData({
    required this.title,
    required this.description,
    required this.tryAgainLabel,
    required this.phone1,
    required this.phone2,
  });

  @override
  List<Object?> get props => [title, description, tryAgainLabel, phone1, phone2];
}

class WelcomeScreenState extends Equatable {
  final bool isLoading;
  final ScreenData? value;
  final RepositoryError? error;

  const WelcomeScreenState({required this.isLoading, this.value, this.error});

  @override
  List<Object?> get props => [isLoading, value, error];

  WelcomeScreenState copyWith({
    required bool isLoading,
    ScreenData? value,
    RepositoryError? error,
  }) {
    return WelcomeScreenState(
      isLoading: isLoading,
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}

abstract class WelcomeScreenController {
  Future<void> loadData(String language);
  Stream<WelcomeScreenState> get stream;
  WelcomeScreenState get value;
}

class WelcomeScreenControllerImpl implements WelcomeScreenController {
  final StreamController<WelcomeScreenState> _controller =
      StreamController<WelcomeScreenState>.broadcast();

  WelcomeScreenState _state = const WelcomeScreenState(isLoading: false);

  final WelcomeRepository _repository;

  WelcomeScreenControllerImpl({
    required WelcomeRepository repository,
  }) : _repository = repository;

  @override
  Stream<WelcomeScreenState> get stream => _controller.stream;

  @override
  WelcomeScreenState get value => _state;

  void emit(WelcomeScreenState newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  Future<void> loadData(String language) async {
    if (value.isLoading) {
      return;
    }

    emit(_state.copyWith(isLoading: true, value: null, error: null));

    try {
      final repositoryData = await _repository.loadData(language);

      emit(
        _state.copyWith(
          isLoading: false,
          value: repositoryData.toScreenData(),
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

extension on WelcomeScreenDTO {
  ScreenData toScreenData() => ScreenData(
        description: description,
        title: title,
        tryAgainLabel: tryAgainLabel,
        phone1: phone1,
        phone2: phone2,
      );
}
