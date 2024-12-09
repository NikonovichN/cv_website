import 'package:flutter/material.dart';

import 'src.dart';

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  static const _titleApp = 'Mikita Nikanovich';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _titleApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const CvAppDarkColorsScheme(),
        fontFamily: CvAppFonts.robotoFontFamily,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
