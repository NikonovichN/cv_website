import 'dart:async';

import 'package:equatable/equatable.dart';

class AccordionState<T> extends Equatable {
  final Set<T> activeSections;

  const AccordionState(this.activeSections);

  AccordionState copyWith({Set<T>? activeSections}) =>
      AccordionState(activeSections ?? this.activeSections);

  @override
  List<Object?> get props => [activeSections];
}

abstract class AccordionController<T> {
  void addActiveSection(T id);
  void removeActiveSection(T id);
  Stream<AccordionState<T>> get stream;
  AccordionState<T> get state;
}

class AccordionControllerImpl<T> implements AccordionController<T> {
  final StreamController<AccordionState<T>> _controller = StreamController<AccordionState<T>>();

  AccordionState<T> _state = AccordionState(Set<T>.from({}));

  AccordionControllerImpl();

  @override
  Stream<AccordionState<T>> get stream => _controller.stream;

  @override
  AccordionState<T> get state => _state;

  void emit(AccordionState<T> newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  void addActiveSection(id) {
    _state.activeSections.add(id);
    emit(_state);
  }

  @override
  void removeActiveSection(id) {
    _state.activeSections.remove(id);
    emit(_state);
  }
}
