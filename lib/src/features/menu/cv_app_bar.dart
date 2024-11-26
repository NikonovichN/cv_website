import 'package:cv_website/src/di/injections.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../features.dart';
import '../../navigation/paths.dart';
import '../../navigation/state_provider.dart';
import '../../ui_kit/molecules/molecules.dart';

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100.0);

  static const _padding = EdgeInsets.only(top: 14.0, bottom: 16.0);

  @override
  Widget build(BuildContext context) {
    final goRouterState = GoRouterStateProvider.of(context).state;

    return StreamBuilder<CvAppMenuState>(
      stream: injector(),
      builder: (context, snapshot) {
        final items = snapshot.data?.items ?? const MenuItems();
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
                  SvAppTextButton.menu(
                    onPressed: () => context.go(RouterPath.welcome.path),
                    isActive: goRouterState.fullPath == RouterPath.welcome.path,
                    child: Text(items.welcome),
                  ),
                  const Spacer(),
                  SvAppTextButton.menu(
                    onPressed: () => context.go(RouterPath.skills.path),
                    isActive: goRouterState.fullPath == RouterPath.skills.path,
                    child: Text(items.skills),
                  ),
                  const SizedBox(width: 36.0),
                  SvAppTextButton.menu(
                    onPressed: () => context.go(RouterPath.experience.path),
                    isActive: goRouterState.fullPath == RouterPath.experience.path,
                    child: Text(items.experience),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
