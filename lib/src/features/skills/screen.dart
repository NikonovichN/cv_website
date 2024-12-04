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
              _emptySpace,
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

  static const _padding = EdgeInsets.symmetric(horizontal: 60.0);
  static const _paddingSmallScreen = EdgeInsets.symmetric(horizontal: 16.0);
  static const _spaceBtwTextRate = SizedBox(width: 16.0);
  static const _spaceBtwTableRates = SizedBox(height: 16.0);

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    final skillsScreenController = injector<SkillsScreenController>();
    final skillsScreenData = skillsScreenController.state.screenData;

    final padding = appProviderValue.isSmallScreen ? _paddingSmallScreen : _padding;

    final rightPart = appProviderValue.widthScreen * _rightPart;
    final leftPart = appProviderValue.widthScreen -
        rightPart -
        _spaceBtwTextRate.width! -
        padding.left -
        padding.right;

    return skillsScreenData == null
        ? const SizedBox.shrink()
        : Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: rightPart,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: CvAppBasicColors.acid),
                    ),
                  ),
                  child: const _TableTitle(),
                ),
                _spaceBtwTableRates,
                ...skillsScreenData.rates.map(
                  (el) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: leftPart,
                            child: _SkillTitle(value: el.title),
                          ),
                        ),
                        _spaceBtwTextRate,
                        _Rate(width: rightPart, value: rightPart * el.value / 100.0),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
  }
}

class _TableTitle extends StatelessWidget {
  const _TableTitle();

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    final skillsScreenController = injector<SkillsScreenController>();
    final skillsScreenData = skillsScreenController.state.screenData;

    final fontSize = appProviderValue.isSmallScreen ? 14.0 : CvAppFonts.robotoMediumM.fontSize;
    final textStyle = CvAppFonts.robotoMediumM
        .copyWith(color: CvAppBasicColors.greenLight)
        .copyWith(fontSize: fontSize);

    return skillsScreenData == null
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: Text(skillsScreenData.leftRate, style: textStyle)),
              Flexible(child: Text(skillsScreenData.rightRate, style: textStyle)),
            ],
          );
  }
}

class _SkillTitle extends StatelessWidget {
  final String value;

  const _SkillTitle({required this.value});

  static const _padding = EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    return Padding(
      padding: _padding,
      child: Text(
        value.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: appProviderValue.isSmallScreen
            ? CvAppFonts.oswaldSubTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )
            : CvAppFonts.oswaldSubTitle,
      ),
    );
  }
}

class _Rate extends StatelessWidget {
  final double width;
  final double value;

  const _Rate({required this.width, required this.value});

  @override
  Widget build(BuildContext context) {
    final appProviderValue = AppProvider.of(context).value;
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: value,
        height: appProviderValue.isSmallScreen ? 24.0 : 30.0,
        color: CvAppBasicColors.greenLight,
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
