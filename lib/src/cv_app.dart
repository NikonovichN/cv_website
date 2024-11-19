import 'package:flutter/material.dart';

import 'src.dart';

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mikita Nikanovich',
      theme: ThemeData(
        colorScheme: const CvAppDarkColorsScheme(),
        fontFamily: CvAppFonts.robotoFontFamily,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
