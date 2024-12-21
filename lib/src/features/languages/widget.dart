import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'controller.dart';
import '../../di/injections.dart';
import '../../ui_kit/ui_kit.dart';
import '../../managers/firebase_analytics.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  static const _ru = 'ru';
  static const _en = 'en';

  static const _constraintsLinkButton = BoxConstraints(
    maxWidth: 24.0,
    minHeight: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CvAppLanguageState>(
      stream: injector<CvAppLanguageController>().stream,
      builder: (context, snapshot) {
        final lang = injector<CvAppLanguageController>().value.cvAppLanguage.code;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: _constraintsLinkButton,
              child: SvAppTextButton.link(
                isActive: _en == lang,
                onPressed: () {
                  const logButton =
                      LogEventButtonParameters(type: LogButtonsType.language, value: _en);
                  injector<FirebaseAnalytics>()
                      .logEvent(name: logButton.name, parameters: logButton.toMap());

                  injector<CvAppLanguageController>().save(_en);
                },
                child: const Text(_en),
              ),
            ),
            const SizedBox(width: 4.0),
            ConstrainedBox(
              constraints: _constraintsLinkButton,
              child: SvAppTextButton.link(
                isActive: _ru == lang,
                onPressed: () {
                  const logButton =
                      LogEventButtonParameters(type: LogButtonsType.language, value: _ru);
                  injector<FirebaseAnalytics>()
                      .logEvent(name: logButton.name, parameters: logButton.toMap());

                  injector<CvAppLanguageController>().save(_ru);
                },
                child: const Text(_ru),
              ),
            ),
          ],
        );
      },
    );
  }
}
