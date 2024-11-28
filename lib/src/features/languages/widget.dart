import 'package:flutter/material.dart';

import 'package:cv_website/src/src.dart';

import 'controller.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  static const _ru = 'ru';
  static const _en = 'en';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CvAppLanguageState>(
      stream: injector<CvAppLanguageController>().stream,
      builder: (context, snapshot) {
        final lang = injector<CvAppLanguageController>().value.cvAppLanguage.code;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvAppTextButton.link(
              isActive: _en == lang,
              onPressed: () => injector<CvAppLanguageController>().save(_en),
              child: const Text(_en),
            ),
            const SizedBox(width: 4.0),
            SvAppTextButton.link(
              isActive: _ru == lang,
              onPressed: () => injector<CvAppLanguageController>().save(_ru),
              child: const Text(_ru),
            ),
          ],
        );
      },
    );
  }
}
