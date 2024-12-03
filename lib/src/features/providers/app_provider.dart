import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

class ProviderValue extends Equatable {
  final double widthScreen;
  final bool isSmallScreen;
  final EdgeInsets padding;

  const ProviderValue({
    required this.widthScreen,
    required this.isSmallScreen,
    required this.padding,
  });

  @override
  List<Object?> get props => [widthScreen, isSmallScreen, padding];
}

class AppProvider extends InheritedWidget {
  const AppProvider({
    super.key,
    required this.value,
    required super.child,
  });

  final ProviderValue value;

  static AppProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }

  static AppProvider of(BuildContext context) {
    final AppProvider? result = maybeOf(context);
    assert(result != null, 'Screen state not found!');
    return result!;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) => value != oldWidget.value;
}
