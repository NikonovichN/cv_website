// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import '../../di/injections.dart';
import '../../common/errors.dart';
import '../../ui_kit/ui_kit.dart';
import '../languages/controller.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SkillsScreenState>(
      stream: injector(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || (snapshot.data?.isLoading != null && snapshot.data!.isLoading)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data?.error != null) {
          return _Error(
            screenData: snapshot.data!.screenData,
            error: snapshot.data!.error!,
          );
        }

        final state = snapshot.data!.screenData!;

        return Column(
          children: [
            Text(state.leftRate),
            Text(state.rightRate),
            ...state.rates.map((el) => Text(el.title)),
            Text(state.educationTitle),
            ...state.educationList.map((el) => Text(el)),
          ],
        );
      },
    );
  }
}

class _Error extends StatelessWidget {
  final SkillsScreenData? screenData;
  final RepositoryError error;

  const _Error({this.screenData, required this.error});

  @override
  Widget build(BuildContext context) {
    final skillsScreenController = injector<SkillsScreenController>();
    final languageController = injector<CvAppLanguageController>();

    return ErrorPlaceholder(
      message: Text(error.message),
      onPressed: () {
        if (kIsWeb) {
          html.window.location.reload();
        } else {
          skillsScreenController.loadData(
            languageController.value.cvAppLanguage.code,
          );
        }
      },
      childButton: Text(screenData?.tryAgainLabel ?? SkillsScreenData.defaultTryAgainLabel),
    );
  }
}
