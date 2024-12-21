// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:cv_website/src/assets/assets.gen.dart';

import 'controller.dart';
import '../languages/controller.dart';
import '../../di/injections.dart';
import '../../ui_kit/ui_kit.dart';
import '../../providers/app_provider.dart';
import '../../managers/firebase_analytics.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  static const _emptyWidget = SizedBox.shrink();
  static const _emptySpace = SizedBox(height: 62.0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ExperienceScreenState>(
      stream: injector(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || (snapshot.data?.isLoading != null && snapshot.data!.isLoading)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data?.error != null) {
          return const _Error();
        }

        final state = snapshot.data!.screenData!;
        final appProviderValue = AppProvider.of(context).value;
        const downloadWidget = _Download();

        return ScrollScreenConfiguration(
          child: Padding(
            padding: appProviderValue.padding.copyWith(bottom: 16.0),
            child: Column(
              children: [
                ScreenHeader(text: Text(state.title)),
                _emptySpace,
                if (appProviderValue.isSmallScreen) _emptyWidget else downloadWidget,
                const _AccordionSection(),
                if (appProviderValue.isSmallScreen) ...[_emptySpace, downloadWidget],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Download extends StatelessWidget {
  const _Download();

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    final state = injector<ExperienceScreenController>().state.screenData;
    final languageController = injector<CvAppLanguageController>();
    final fileToDownload =
        languageController.value.cvAppLanguage.code == CvAppLanguage.defaultLanguage
            ? Assets.files.a00CVNikonovichEn
            : Assets.files.a00CVNikonovichRu;

    if (state == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment:
          appProviderValue.isSmallScreen ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        CvAppButton.secondary(
          onPressed: () {
            try {
              final anchor = html.AnchorElement(href: 'assets/$fileToDownload');
              anchor.download = fileToDownload.split('/').last;
              anchor.click();
            } catch (error) {
              final errorEvent = ErrorEventParameters(message: error.toString());
              injector<FirebaseAnalytics>()
                  .logEvent(name: errorEvent.name, parameters: errorEvent.toMap());
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.downloadLabel),
              const SizedBox(width: 15.0),
              SvgPicture.asset(
                Assets.icons.svg.downloadMinimalistic,
                colorFilter: const ColorFilter.mode(
                  CvAppBasicColors.buttercup,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _AccordionSection extends StatelessWidget {
  const _AccordionSection();

  @override
  Widget build(BuildContext context) {
    final state = injector<ExperienceScreenController>().state.screenData;

    if (state == null) {
      return const SizedBox.shrink();
    }

    return AccordionContainer<int>(
      sections: state.list
          .map(
            (el) => AccordionSection<int>(
              uniqueId: ValueKey(el.title).hashCode,
              header: Text(el.period, style: CvAppFonts.oswaldMedium),
              title: Text(
                el.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CvAppFonts.oswaldMedium.copyWith(
                  fontSize: 26.0,
                  color: CvAppBasicColors.softGrey,
                ),
              ),
              content: Column(
                children: el.projects
                    .map(
                      (pr) => _SectionContent(
                        period: pr.period,
                        role: pr.role,
                        projectDescription: pr.projectDescription,
                        projectDescriptionTitle: pr.projectDescriptionTitle,
                        responsibilities: pr.responsibilities,
                        responsibilitiesTitle: pr.responsibilitiesTitle,
                        teamSize: pr.teamSize,
                        teamSizeTitle: pr.teamSizeTitle,
                        tools: pr.tools,
                        toolsTitle: pr.toolsTitle,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SectionContent extends StatelessWidget {
  final String period;
  final String role;
  final String projectDescription;
  final String projectDescriptionTitle;
  final String responsibilities;
  final String responsibilitiesTitle;
  final String teamSize;
  final String teamSizeTitle;
  final String tools;
  final String toolsTitle;

  const _SectionContent({
    required this.period,
    required this.role,
    required this.projectDescription,
    required this.projectDescriptionTitle,
    required this.responsibilities,
    required this.responsibilitiesTitle,
    required this.teamSize,
    required this.teamSizeTitle,
    required this.tools,
    required this.toolsTitle,
  });

  static const _padding = EdgeInsets.all(40.0);
  static const _paddingSmallScreen = EdgeInsets.symmetric(vertical: 16);
  static const _innerPadding = EdgeInsets.only(left: 50.0);
  static const _emptySpaceS = SizedBox(height: 8.0);
  static const _emptySpaceXS = SizedBox(height: 5.0);
  static const _emptySpaceL = SizedBox(height: 22.0);

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    return Padding(
      padding: appProviderValue.isSmallScreen ? _paddingSmallScreen : _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(role, style: CvAppFonts.oswaldRegular),
          _emptySpaceS,
          Text(period, style: CvAppFonts.oswaldSmallRegular),
          _emptySpaceL,
          Padding(
            padding: _innerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(projectDescriptionTitle,
                    style: CvAppFonts.oswaldRegular.copyWith(
                      color: CvAppBasicColors.acid,
                    )),
                _emptySpaceXS,
                Text(projectDescription,
                    style: CvAppFonts.robotoRegular.copyWith(
                      fontSize: 16,
                    )),
                _emptySpaceL,
                Text(responsibilitiesTitle,
                    style: CvAppFonts.oswaldRegular.copyWith(
                      color: CvAppBasicColors.acid,
                    )),
                _emptySpaceXS,
                Text(responsibilities,
                    style: CvAppFonts.robotoRegular.copyWith(
                      fontSize: 16,
                    )),
                _emptySpaceL,
                Text(teamSizeTitle,
                    style: CvAppFonts.oswaldRegular.copyWith(
                      color: CvAppBasicColors.acid,
                    )),
                _emptySpaceXS,
                Text(teamSize,
                    style: CvAppFonts.robotoRegular.copyWith(
                      fontSize: 16,
                    )),
                _emptySpaceL,
                Text(toolsTitle,
                    style: CvAppFonts.oswaldRegular.copyWith(
                      color: CvAppBasicColors.acid,
                    )),
                _emptySpaceXS,
                Text(tools,
                    style: CvAppFonts.robotoRegular.copyWith(
                      fontSize: 16,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    final experienceScreenController = injector<ExperienceScreenController>();
    final experienceScreenData = experienceScreenController.state.screenData;
    final experienceScreenError = experienceScreenController.state.error;

    final languageController = injector<CvAppLanguageController>();

    return ErrorPlaceholder(
      message: experienceScreenError != null ? Text(experienceScreenError.message) : null,
      onPressed: () {
        if (kIsWeb) {
          html.window.location.reload();
        } else {
          experienceScreenController.loadData(
            languageController.value.cvAppLanguage.code,
          );
        }
      },
      childButton:
          Text(experienceScreenData?.tryAgainLabel ?? ExperienceScreenData.defaultTryAgainLabel),
    );
  }
}
