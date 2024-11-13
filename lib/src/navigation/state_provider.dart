import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class GoRouterStateProvider extends InheritedWidget {
  const GoRouterStateProvider({
    super.key,
    required this.state,
    required super.child,
  });

  final GoRouterState state;

  static GoRouterStateProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GoRouterStateProvider>();
  }

  static GoRouterStateProvider of(BuildContext context) {
    final GoRouterStateProvider? result = maybeOf(context);
    assert(result != null, 'Go router state not founded!');
    return result!;
  }

  @override
  bool updateShouldNotify(GoRouterStateProvider oldWidget) => state != oldWidget.state;
}
