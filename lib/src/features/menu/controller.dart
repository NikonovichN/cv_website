import 'dart:async';

import 'package:equatable/equatable.dart';

import 'dto.dart';
import 'repository.dart';
import '../../common/errors.dart';

class MenuItems extends Equatable {
  static const defaultWelcome = 'Welcome';
  static const defaultSkills = 'Skills';
  static const defaultExperience = 'Experience';

  final String welcome;
  final String skills;
  final String experience;

  const MenuItems({
    this.welcome = defaultWelcome,
    this.skills = defaultSkills,
    this.experience = defaultExperience,
  });

  @override
  List<Object?> get props => [welcome, skills, experience];
}

class CvAppMenuState extends Equatable {
  final bool isLoading;
  final MenuItems items;
  final RepositoryError? error;

  const CvAppMenuState({
    this.isLoading = false,
    this.items = const MenuItems(),
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, items, error];

  CvAppMenuState copyWith({
    required bool isLoading,
    MenuItems? items,
    RepositoryError? error,
  }) {
    return CvAppMenuState(
      isLoading: isLoading,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }
}

abstract class CvAppMenuController {
  Future<void> loadItems(String language);
  Stream<CvAppMenuState> get stream;
  CvAppMenuState get value;
}

class CvAppMenuControllerImpl implements CvAppMenuController {
  final StreamController<CvAppMenuState> _controller = StreamController<CvAppMenuState>.broadcast();

  CvAppMenuState _state = const CvAppMenuState();

  final MenuRepository _repository;

  CvAppMenuControllerImpl({required MenuRepository repository}) : _repository = repository;

  @override
  Stream<CvAppMenuState> get stream => _controller.stream;

  @override
  CvAppMenuState get value => _state;

  void emit(CvAppMenuState newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  Future<void> loadItems(String language) async {
    if (value.isLoading) {
      return;
    }

    emit(_state.copyWith(isLoading: true, items: null, error: null));

    try {
      final repositoryData = await _repository.loadItems(language);

      emit(
        _state.copyWith(
          isLoading: false,
          items: repositoryData.toMenuItems(),
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

extension on MenuDTO {
  MenuItems toMenuItems() => MenuItems(
        welcome: welcome,
        skills: skills,
        experience: experience,
      );
}
