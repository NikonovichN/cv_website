import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/src.dart';
import 'src/cv_app.dart';

import 'firebase_options.dart';

void main() async {
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DependencyInjections.registerDependencies();

  runApp(const CvApp());
}
