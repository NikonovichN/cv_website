import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/src.dart';
import 'src/cv_app.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    usePathUrlStrategy();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await DependencyInjections.registerDependencies();

    injector<FirebaseAnalytics>().logAppOpen(
      parameters: const LogEventBaseParameters().toMap(),
    );

    FlutterError.onError = (FlutterErrorDetails details) {
      catchUnhandledExceptions(details.exception, details.stack);
    };

    runApp(const CvApp());
  }, catchUnhandledExceptions);
}

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  final errorEvent = ErrorEventParameters(message: error.toString());
  injector<FirebaseAnalytics>().logEvent(name: errorEvent.name, parameters: errorEvent.toMap());
}
