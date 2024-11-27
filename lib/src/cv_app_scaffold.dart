import 'package:flutter/material.dart';

import 'src.dart';
import 'features/features.dart';

class ScaffoldCvApp extends StatelessWidget {
  final Widget child;
  final Function(String language)? loadDataScreen;

  const ScaffoldCvApp({
    super.key,
    required this.child,
    required this.loadDataScreen,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CvAppLanguageState>(
      stream: injector<CvAppLanguageController>().stream,
      builder: (context, snapshot) {
        final lang =
            snapshot.data?.cvAppLanguage.code ?? injector<CvAppLanguageState>().cvAppLanguage.code;
        injector<CvAppMenuController>().loadItems(lang);
        loadDataScreen?.call(lang);

        return Container(
          alignment: Alignment.center,
          color: CvAppBasicColors.gloomy,
          padding: appPadding,
          child: ConstrainedBox(
            constraints: appConstraints,
            child: Scaffold(
              appBar: const CvAppBar(),
              body: child,
            ),
          ),
        );
      },
    );
  }
}
