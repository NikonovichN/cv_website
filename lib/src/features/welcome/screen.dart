import 'dart:async';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:math';

import 'package:cv_website/src/ui_kit/ui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../src.dart';
import 'controller.dart';
import '../languages/controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WelcomeScreenState>(
      stream: injector(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || (snapshot.data?.isLoading != null && snapshot.data!.isLoading)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data?.error != null) {
          return const _Error();
        }

        final state = snapshot.data!.screenData!;

        return ScrollScreenConfiguration(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.title, style: CvAppFonts.header),
              const SizedBox(height: 62.0),
              const _Body(),
            ],
          ),
        );
      },
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    final welcomeScreenController = injector<WelcomeScreenController>();
    final welcomeScreenData = welcomeScreenController.state.screenData;
    final welcomeScreenError = welcomeScreenController.state.error;

    final languageController = injector<CvAppLanguageController>();

    return ErrorPlaceholder(
      message: welcomeScreenError != null ? Text(welcomeScreenError.message) : null,
      onPressed: () {
        if (kIsWeb) {
          html.window.location.reload();
        } else {
          welcomeScreenController.loadData(
            languageController.value.cvAppLanguage.code,
          );
        }
      },
      childButton: Text(welcomeScreenData?.tryAgainLabel ?? WelcomeScreenData.defaultTryAgainLabel),
    );
  }
}

class _Body extends StatelessWidget {
  static const _descriptionTextPadding = EdgeInsets.symmetric(horizontal: 136.0);

  const _Body();

  @override
  Widget build(BuildContext context) {
    final welcomeScreenController = injector<WelcomeScreenController>();
    final welcomeScreenData = welcomeScreenController.state.screenData;

    if (welcomeScreenData == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: _descriptionTextPadding,
              child: Text(
                welcomeScreenData.description,
                style: CvAppFonts.robotoRegular,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 74.0),
            Assets.images.avatar.image(),
            const SizedBox(height: 100.0),
          ],
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _PhoneText(phone: welcomeScreenData.phone1),
              const SizedBox(height: 8.0),
              _PhoneText(phone: welcomeScreenData.phone2),
              const SizedBox(height: 20.0),
              const _Socials()
            ],
          ),
        ),
        const Positioned(
          bottom: 0.0,
          right: 0.0,
          child: _Heart(),
        )
      ],
    );
  }
}

class _FloatingHeart extends StatefulWidget {
  final Color color;
  final Duration durationLife;

  const _FloatingHeart({super.key, required this.durationLife, required this.color});

  @override
  State<_FloatingHeart> createState() => __FloatingHeartState();
}

class __FloatingHeartState extends State<_FloatingHeart> with SingleTickerProviderStateMixin {
  static const _durationAnimation = Duration(milliseconds: 1800);
  static const sizeHeart = 8.0;

  AnimationController? _controller;
  int _animationTick = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)..repeat(period: widget.durationLife);
    _controller?.addListener(_listenAnimationTicker);
  }

  void _listenAnimationTicker() {
    _animationTick++;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.removeListener(_listenAnimationTicker);
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double verticalOffset = 0.0;
    double maxWidthFloatingZone = __HeartState.maxWidthOfFloatingZone;
    double floatingSizeHeart = __FloatingHeartState.sizeHeart;
    double buttonSizeHeart = __HeartState.sizeHeart;

    double right = buttonSizeHeart / 2 - floatingSizeHeart / 2 + verticalOffset / 2;
    double bottom = buttonSizeHeart - floatingSizeHeart * 2 + _animationTick.toDouble();

    if (_animationTick > buttonSizeHeart && _animationTick % 2 == 1) {
      verticalOffset = Random().nextDouble() * maxWidthFloatingZone - floatingSizeHeart;
      verticalOffset = verticalOffset / 2;
      right = Random().nextBool()
          ? floatingSizeHeart + verticalOffset
          : floatingSizeHeart - verticalOffset;
    }

    return AnimatedPositioned(
      duration: _durationAnimation,
      bottom: bottom,
      right: right,
      child: Container(
        width: floatingSizeHeart,
        height: floatingSizeHeart,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _FloatingHeartSettings {
  final String mapKey;
  final Timer timer;
  final Widget heart;

  _FloatingHeartSettings({required this.mapKey, required this.heart, required this.timer});
}

class _Heart extends StatefulWidget {
  const _Heart();

  @override
  State<_Heart> createState() => __HeartState();
}

class __HeartState extends State<_Heart> {
  static const _durationHeartAnimation = Duration(milliseconds: 100);
  static const sizeHeart = 60.0;
  static const _sizeHeartPressed = 52.0;

  bool _isPressed = false;

  final Map<String, _FloatingHeartSettings> _mapHearts = {};

  final List<Color> _heartColors = [
    CvAppBasicColors.buttercup,
    CvAppBasicColors.acid,
    CvAppBasicColors.buttercupLight,
    CvAppBasicColors.green,
    CvAppBasicColors.greenLight,
    CvAppBasicColors.softGrey,
  ];

  static const double maxWidthOfFloatingZone = 200.0;
  double maxHeightOfFloatingZone = 0.0;

  void _addHeart() {
    final duration = Duration(milliseconds: 2000 + Random().nextInt(10000));
    final color = _heartColors[Random().nextInt(_heartColors.length - 1)];
    final key = DateTime.now().millisecondsSinceEpoch.toString();

    final timer = Timer(duration, () {
      _mapHearts.removeWhere((k, _) => k == key);
      if (mounted) {
        setState(() {});
      }
    });

    _mapHearts.addAll({
      key: _FloatingHeartSettings(
        mapKey: key,
        timer: timer,
        heart: _FloatingHeart(
          key: ValueKey(key),
          color: color,
          durationLife: duration,
        ),
      )
    });
    if (mounted) {
      setState(() {});
    }
  }

  void _setIsPressed(bool pressed) => setState(() => _isPressed = pressed);

  @override
  void dispose() {
    _mapHearts.forEach((key, value) {
      value.timer.cancel();
    });
    _mapHearts.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    maxHeightOfFloatingZone = MediaQuery.of(context).size.height * .7;

    return SizedBox(
      width: maxWidthOfFloatingZone,
      height: maxHeightOfFloatingZone,
      child: Stack(
        children: [
          ..._mapHearts.entries.map((e) => e.value.heart),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: _addHeart,
              onTapDown: (_) => _setIsPressed(true),
              onTapUp: (_) => _setIsPressed(false),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: _durationHeartAnimation,
                  width: _isPressed ? _sizeHeartPressed : sizeHeart,
                  height: _isPressed ? _sizeHeartPressed : sizeHeart,
                  child: SvgPicture.asset(
                    Assets.icons.svg.heart,
                    colorFilter: const ColorFilter.mode(
                      CvAppBasicColors.buttercup,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneText extends StatelessWidget {
  final String phone;

  const _PhoneText({required this.phone});

  static const _padding = EdgeInsets.only(left: 6.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await launchUrl(Uri.parse('tel:$phone'));
        } catch (_) {
          // TODO: to think about handle this case
        }
      },
      child: Padding(
        padding: _padding,
        child: Text(
          phone,
          style: CvAppFonts.robotoSmallRegular.copyWith(
            color: CvAppBasicColors.silverWare,
          ),
        ),
      ),
    );
  }
}

class _Socials extends StatelessWidget {
  const _Socials();

  static const _defaultSocialLinks = SocialLinks();

  @override
  Widget build(BuildContext context) {
    final state =
        injector<WelcomeScreenController>().state.screenData?.socialLinks ?? _defaultSocialLinks;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CvAppSvgIconButton.primary(
          iconPath: Assets.icons.svg.gmail,
          onPressed: () async {
            try {
              await launchUrl(Uri.parse(state.gmail));
            } catch (_) {
              // TODO: to think about handle this case
            }
          },
        ),
        CvAppSvgIconButton.primary(
          iconPath: Assets.icons.svg.git,
          onPressed: () async {
            try {
              await launchUrl(Uri.parse(state.gitHub));
            } catch (_) {
              // TODO: to think about handle this case
            }
          },
        ),
        CvAppSvgIconButton.primary(
          iconPath: Assets.icons.svg.linkedIn,
          onPressed: () async {
            try {
              await launchUrl(Uri.parse(state.linkedIn));
            } catch (_) {
              // TODO: to think about handle this case
            }
          },
        ),
        CvAppSvgIconButton.primary(
          iconPath: Assets.icons.svg.telegram,
          onPressed: () async {
            try {
              await launchUrl(Uri.parse(state.telegram));
            } catch (_) {
              // TODO: to think about handle this case
            }
          },
        ),
      ],
    );
  }
}
