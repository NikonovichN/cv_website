import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'paths.dart';
import 'state_provider.dart';
import '../features/features.dart';
import '../ui_kit/molecules/molecules.dart';

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100.0);

  static const _padding = EdgeInsets.only(top: 14.0, bottom: 16.0);

  @override
  Widget build(BuildContext context) {
    final goRouterState = GoRouterStateProvider.of(context).state;

    return Padding(
      padding: _padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChooseLanguage(),
          const SizedBox(height: 6.0),
          Row(
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
              const SizedBox(width: 36.0),
              SvAppTextButton.menu(
                onPressed: () => context.go(RouterPath.experience.path),
                isActive: goRouterState.fullPath == RouterPath.experience.path,
                child: const Text('Experience'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
