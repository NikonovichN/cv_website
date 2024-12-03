// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import '../../di/injections.dart';
import '../../ui_kit/ui_kit.dart';
import '../languages/controller.dart';
import '../providers/app_provider.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  static const _emptySpace = SizedBox(height: 62.0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SkillsScreenState>(
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

        return ScrollScreenConfiguration(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appProviderValue.isSmallScreen ? _emptySpace : const SizedBox.shrink(),
              Text(state.title, style: CvAppFonts.header),
              _emptySpace,
              const _RatesKnowledge(),
              const SizedBox(height: 100.0),
              const _Education(),
            ],
          ),
        );
      },
    );
  }
}

class _RatesKnowledge extends StatelessWidget {
  const _RatesKnowledge();

  static const _rightPart = .4;
  static const _padding = EdgeInsets.symmetric(horizontal: 50.0);

  @override
  Widget build(BuildContext context) {
    final skillsScreenController = injector<SkillsScreenController>();
    final skillsScreenData = skillsScreenController.state.screenData;
    final size = MediaQuery.of(context).size;

    return skillsScreenData == null
        ? const SizedBox.shrink()
        : Padding(
            padding: _padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70.0),
                    ...skillsScreenData.rates.map((el) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(el.title.toUpperCase(), style: CvAppFonts.oswaldSubTitle),
                      );
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * _rightPart,
                          padding: const EdgeInsets.only(bottom: 16.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: CvAppBasicColors.acid),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                skillsScreenData.leftRate,
                                style: CvAppFonts.robotoMediumM
                                    .copyWith(color: CvAppBasicColors.greenLight),
                              ),
                              Text(
                                skillsScreenData.rightRate,
                                style: CvAppFonts.robotoMediumM
                                    .copyWith(color: CvAppBasicColors.greenLight),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ...skillsScreenData.rates.map((el) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: size.width * _rightPart * el.value / 100.0,
                        height: 30.0,
                        color: CvAppBasicColors.greenLight,
                      );
                    }),
                  ],
                ),
              ],
            ),
          );
  }
}

class _Education extends StatelessWidget {
  const _Education();

  @override
  Widget build(BuildContext context) {
    final skillsScreenController = injector<SkillsScreenController>();
    final skillsScreenData = skillsScreenController.state.screenData;

    return skillsScreenData == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Text(
                skillsScreenData.educationTitle,
                textAlign: TextAlign.center,
                style: CvAppFonts.oswaldSubTitle.copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: skillsScreenData.educationList
                    .map((el) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            el,
                            style: CvAppFonts.robotoMediumM,
                          ),
                        ))
                    .toList(),
              )
            ],
          );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    final skillsScreenController = injector<SkillsScreenController>();
    final skillsScreenData = skillsScreenController.state.screenData;
    final skillsScreenError = skillsScreenController.state.error;
    final languageController = injector<CvAppLanguageController>();

    return ErrorPlaceholder(
      message: skillsScreenError != null ? Text(skillsScreenError.message) : null,
      onPressed: () {
        if (kIsWeb) {
          html.window.location.reload();
        } else {
          skillsScreenController.loadData(
            languageController.value.cvAppLanguage.code,
          );
        }
      },
      childButton: Text(skillsScreenData?.tryAgainLabel ?? SkillsScreenData.defaultTryAgainLabel),
    );
  }
}
