// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import '../../di/injections.dart';
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
          return const _Error();
        }

        final state = snapshot.data!.screenData!;

        return ScrollScreenConfiguration(
          child: Column(
            children: [
              const _RatesKnowledge(),
              Text(state.educationTitle),
              ...state.educationList.map((el) => Text(el)),
            ],
          ),
        );
      },
    );
  }
}

class _RatesKnowledge extends StatelessWidget {
  const _RatesKnowledge();

  @override
  Widget build(BuildContext context) {
    final skillsScreenController = injector<SkillsScreenController>();
    final skillsScreenData = skillsScreenController.state.screenData;

    return skillsScreenData == null
        ? const SizedBox.shrink()
        : Stack(
            children: [
              Container(),
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
