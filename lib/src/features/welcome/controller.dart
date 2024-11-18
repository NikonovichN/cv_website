import 'dart:async';

import 'package:equatable/equatable.dart';

import 'repository.dart';

class RepositoryError extends Equatable {
  final String message;

  const RepositoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ScreenData extends Equatable {
  final String? title;
  final String? description;

  const ScreenData({this.title, this.description});

  @override
  List<Object?> get props => [title, description];
}

class WelcomeScreenState extends Equatable {
  final bool isLoading;
  final ScreenData? state;
  final RepositoryError? error;

  const WelcomeScreenState({required this.isLoading, this.state, this.error});

  @override
  List<Object?> get props => [isLoading, state, error];

  WelcomeScreenState copyWith({required bool isLoading, ScreenData? state, RepositoryError? error}) {
    return WelcomeScreenState(isLoading: isLoading, state: state, error: error);
  }
}

abstract class WelcomeScreenController {
  Future<void> loadData();
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
  Future<void> loadData() async {
    if (value.isLoading) {
      return;
    }

    emit(_state.copyWith(isLoading: true, state: null, error: null));

    try {
      final state = await _repository.loadData('en');

      emit(_state.copyWith(isLoading: false, state: state));
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
