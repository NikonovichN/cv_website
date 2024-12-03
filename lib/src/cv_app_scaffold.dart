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
      builder: (context, lnSnap) {
        final widthScreen = MediaQuery.of(context).size.width;
        final cvAppPadding =
            widthScreen > appConstraints.maxWidth ? appPadding : appPaddingSmallScreen;

        final menuController = injector<CvAppMenuController>();
        final languageState = injector<CvAppLanguageState>();
        final lang = lnSnap.data?.cvAppLanguage.code ?? languageState.cvAppLanguage.code;

        menuController.loadItems(lang);
        loadDataScreen?.call(lang);

        return Container(
          alignment: Alignment.center,
          color: CvAppBasicColors.gloomy,
          padding: cvAppPadding,
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
