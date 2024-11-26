// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'controller.dart';
import '../languages/controller.dart';
import '../../di/injections.dart';
import '../../ui_kit/ui_kit.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

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

        return ScrollScreenConfiguration(
          child: Column(
            children: [
              Text(state.title, style: CvAppFonts.header),
              const SizedBox(height: 62.0),
              const _AccordionSection(),
            ],
          ),
        );
      },
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
              title: Text(el.title, style: CvAppFonts.oswaldMedium.copyWith(fontSize: 26.0)),
              content: Column(
                children: el.projects
                    .map(
                      (pr) => Column(
                        children: [
                          Text(pr.period),
                          Text(pr.role),
                          Text(pr.projectDescription),
                          Text(pr.responsibilities),
                          Text(pr.teamSize),
                          Text(pr.tools),
                        ],
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
