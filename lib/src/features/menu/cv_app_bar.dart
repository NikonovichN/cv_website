import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:go_router/go_router.dart';

import 'controller.dart';
import '../providers/app_provider.dart';
import '../languages/widget.dart';
import '../../di/injections.dart';
import '../../common/values.dart';
import '../../navigation/paths.dart';
import '../providers/go_router_state_provider.dart';
import '../../ui_kit/molecules/molecules.dart';
import '../../ui_kit/atoms/colors.dart';

class CvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CvAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 100.0);

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    final topPadding = appProviderValue.isSmallScreen ? 6.0 : 14.0;

    return StreamBuilder<CvAppMenuState>(
      stream: injector(),
      builder: (context, snapshot) {
        return Padding(
          padding: appProviderValue.padding.copyWith(top: topPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChooseLanguage(),
              appProviderValue.isSmallScreen
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 6.0),
              SizedBox(
                height: 40.0,
                child: _MouseRegion(
                  key: ValueKey(snapshot.data?.items.toString()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MouseRegion extends StatefulWidget {
  const _MouseRegion({super.key});

  @override
  State<_MouseRegion> createState() => __MouseRegionState();
}

class __MouseRegionState extends State<_MouseRegion> {
  static const _animationDurationShort = Duration(milliseconds: 180);
  static const _animationDurationLong = Duration(seconds: 2);
  static const _timerDuration = Duration(seconds: 2);

  final _welcomeKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();

  GlobalKey? _activeMenuKey;

  double _dotPosition = 0.0;
  bool _mouseInter = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_timerDuration, _ticker);

    _activeMenuKey = _welcomeKey;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setCenterDotPosition();
    });
  }

  void _onMouseEnter(PointerEnterEvent _) {
    setState(() => _mouseInter = true);
  }

  void _onMouseExit(PointerExitEvent _) {
    _timer?.cancel();
    _timer = null;
    _timer = Timer.periodic(_timerDuration, _ticker);
    setState(() => _mouseInter = false);
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      _dotPosition = details.position.dx;
    });
  }

  void _setCenterDotPosition() {
    final renderBox = _activeMenuKey?.currentContext?.findRenderObject() as RenderBox?;
    setState(() {
      if (renderBox != null) {
        _dotPosition = renderBox.localToGlobal(Offset.zero).dx + (renderBox.size.width / 2);
      }
    });
  }

  void _ticker(Timer timer) {
    if (!_mouseInter) {
      _setCenterDotPosition();
    }
  }

  void _setActiveMenuKey(GoRouterState routerState) {
    final path =
        RouterPath.values.singleWhere((val) => routerState.fullPath?.contains(val.name) ?? false);

    switch (path) {
      case RouterPath.welcome:
        _activeMenuKey = _welcomeKey;
      case RouterPath.skills:
        _activeMenuKey = _skillsKey;
      case RouterPath.experience:
        _activeMenuKey = _experienceKey;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goRouterState = GoRouterStateProvider.of(context).state;
    final items = injector<CvAppMenuController>().state.items;

    final appProviderValue = AppProvider.of(context).value;

    final leftPadding = appProviderValue.padding.left;
    final offsetX = appProviderValue.isSmallScreen
        ? leftPadding
        : (appProviderValue.widthScreen - appConstraints.maxWidth) / 2 + leftPadding;

    _setActiveMenuKey(goRouterState);

    return MouseRegion(
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      onHover: _updateLocation,
      child: Stack(
        children: [
          Row(
            children: [
              SvAppTextButton.menu(
                key: _welcomeKey,
                onPressed: () => context.go(RouterPath.welcome.path),
                isActive: goRouterState.fullPath == RouterPath.welcome.path,
                child: Text(items.welcome),
              ),
              const Spacer(),
              SvAppTextButton.menu(
                key: _skillsKey,
                onPressed: () => context.go(RouterPath.skills.path),
                isActive: goRouterState.fullPath == RouterPath.skills.path,
                child: Text(items.skills),
              ),
              const SizedBox(width: 36.0),
              SvAppTextButton.menu(
                key: _experienceKey,
                onPressed: () => context.go(RouterPath.experience.path),
                isActive: goRouterState.fullPath == RouterPath.experience.path,
                child: Text(items.experience),
              ),
            ],
          ),
          AnimatedPositioned(
            bottom: 4.0,
            left: _dotPosition - offsetX,
            duration: _mouseInter ? _animationDurationShort : _animationDurationLong,
            curve: _mouseInter ? Curves.linear : Curves.fastEaseInToSlowEaseOut,
            child: const _Dot(),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.0,
      height: 4.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: CvAppBasicColors.buttercup,
      ),
    );
  }
}
