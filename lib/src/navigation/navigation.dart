import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:cv_website/src/features/features.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum RouterPath {
  welcome("/welcome"),
  skills("/skills"),
  experience("/experience"),
  ;

  const RouterPath(this.path);

  final String path;
}

final router = GoRouter(
  initialLocation: RouterPath.welcome.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldCvApp(child: child);
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

class ScaffoldCvApp extends StatelessWidget {
  final Widget child;

  const ScaffoldCvApp({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CvAppBar(),
      body: child,
    );
  }
}

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => context.go(RouterPath.welcome.path),
          child: const Text('Welcome'),
        ),
        TextButton(
          onPressed: () => context.go(RouterPath.skills.path),
          child: const Text('Skills'),
        ),
        TextButton(
          onPressed: () => context.go(RouterPath.experience.path),
          child: const Text('Experience'),
        ),
      ],
    );
  }
}
