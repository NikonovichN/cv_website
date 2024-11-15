import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'paths.dart';
import 'state_provider.dart';
import '../ui_kit/molecules/molecules.dart';

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100);

  static const _padding = EdgeInsets.only(top: 40, bottom: 20);

  @override
  Widget build(BuildContext context) {
    final goRouterState = GoRouterStateProvider.of(context).state;

    return Padding(
      padding: _padding,
      child: Row(
        children: [
          // TODO: do something with text
          SvAppTextButton.menu(
            onPressed: () => context.go(RouterPath.welcome.path),
            isActive: goRouterState.fullPath == RouterPath.welcome.path,
            child: const Text('Welcome'),
          ),
          const Spacer(),
          SvAppTextButton.menu(
            onPressed: () => context.go(RouterPath.skills.path),
            isActive: goRouterState.fullPath == RouterPath.skills.path,
            child: const Text('Skills'),
          ),
          SvAppTextButton.menu(
            onPressed: () => context.go(RouterPath.experience.path),
            isActive: goRouterState.fullPath == RouterPath.experience.path,
            child: const Text('Experience'),
          ),
        ],
      ),
    );
  }
}
