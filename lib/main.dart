import 'package:flutter/material.dart';

import 'src/src.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const CvAppDarkColorsScheme(),
        fontFamily: CvAppFonts.robotoFontFamily,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Test')),
      ),
    );
  }
}
