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
        final menuController = injector<CvAppMenuController>();
        final languageState = injector<CvAppLanguageState>();
        final lang = lnSnap.data?.cvAppLanguage.code ?? languageState.cvAppLanguage.code;

        final widthScreen = MediaQuery.of(context).size.width;
        final isSmallScreen = widthScreen < appConstraints.maxWidth;
        final cvAppPadding = isSmallScreen ? appPaddingSmallScreen : appPadding;

        menuController.loadItems(lang);
        loadDataScreen?.call(lang);

        return ScreenProvider(
          state: ScreenState(
            widthScreen: widthScreen,
            isSmallScreen: isSmallScreen,
            appPadding: cvAppPadding,
          ),
          child: Container(
            alignment: Alignment.center,
            color: CvAppBasicColors.gloomy,
            child: ConstrainedBox(
              constraints: appConstraints,
              child: Scaffold(
                appBar: const CvAppBar(),
                body: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
