import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

class ScreenState extends Equatable {
  final double widthScreen;
  final bool isSmallScreen;
  final EdgeInsets appPadding;

  const ScreenState({
    required this.widthScreen,
    required this.isSmallScreen,
    required this.appPadding,
  });

  @override
  List<Object?> get props => [widthScreen, isSmallScreen, appPadding];
}

class ScreenProvider extends InheritedWidget {
  const ScreenProvider({
    super.key,
    required this.state,
    required super.child,
  });

  final ScreenState state;

  static ScreenProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenProvider>();
  }

  static ScreenProvider of(BuildContext context) {
    final ScreenProvider? result = maybeOf(context);
    assert(result != null, 'Screen state not found!');
    return result!;
  }

  @override
  bool updateShouldNotify(ScreenProvider oldWidget) => state != oldWidget.state;
}
