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
      initialData: injector<CvAppLanguageController>().value,
      stream: injector<CvAppLanguageController>().stream,
      builder: (context, snapshot) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvAppTextButton.link(
              isActive: _en == snapshot.data?.cvAppLanguage.code,
              onPressed: () => injector<CvAppLanguageController>().save(_en),
              child: const Text(_en),
            ),
            const SizedBox(width: 4.0),
            SvAppTextButton.link(
              isActive: _ru == snapshot.data?.cvAppLanguage.code,
              onPressed: () => injector<CvAppLanguageController>().save(_ru),
              child: const Text(_ru),
            ),
          ],
        );
      },
    );
  }
}
