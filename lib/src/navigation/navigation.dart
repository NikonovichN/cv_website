import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'paths.dart';
import 'state_provider.dart';
import '../cv_app_scaffold.dart';
import '../features/features.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouterPath.welcome.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return GoRouterStateProvider(
          state: state,
          child: ScaffoldCvApp(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: RouterPath.welcome.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: WelcomeScreen(),
          ),
        ),
        GoRoute(
          path: RouterPath.skills.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SkillsScreen(),
          ),
        ),
        GoRoute(
          path: RouterPath.experience.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ExperienceScreen(),
          ),
        ),
      ],
    ),
  ],
);
