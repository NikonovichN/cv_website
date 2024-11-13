import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'paths.dart';
import 'state_provider.dart';

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {
    final goRouterState = GoRouterStateProvider.of(context).state;

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
