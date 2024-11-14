import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'paths.dart';
import 'state_provider.dart';
import 'package:cv_website/src/ui_kit/molecules/text_button.dart';

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {
    final goRouterState = GoRouterStateProvider.of(context).state;

    return Row(
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
    );
  }
}
