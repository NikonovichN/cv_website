// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

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

  static const _descriptionTextPadding = EdgeInsets.symmetric(horizontal: 136.0);

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
              Padding(
                padding: _descriptionTextPadding,
                child: Text(
                  state.description,
                  style: CvAppFonts.robotoRegular,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 76.0),
              Assets.images.avatar.image(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PhoneText(phone: state.phone1),
                      const SizedBox(height: 8.0),
                      _PhoneText(phone: state.phone2),
                      const SizedBox(height: 20.0),
                      const _Socials()
                    ],
                  ),
                  SvgPicture.asset(
                    Assets.icons.svg.heart,
                    colorFilter: const ColorFilter.mode(
                      CvAppBasicColors.buttercup,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              )
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
