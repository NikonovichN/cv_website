import 'package:flutter/foundation.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics initializeFirebaseAnalytics() => FirebaseAnalytics.instance;

abstract class LogEventParameters {
  String get name;

  Map<String, Object> toMap();
}

class LogEventBaseParameters implements LogEventParameters {
  final bool isDebugMode;

  const LogEventBaseParameters({this.isDebugMode = kDebugMode});

  @override
  String get name => 'event';

  @override
  Map<String, Object> toMap() => {
        'event': name,
        'isDebugMode': isDebugMode.toString(),
      };
}

enum LogButtonsType { language, menu, action, social }

class LogEventButtonParameters implements LogEventParameters {
  final bool isDebugMode;
  final LogButtonsType type;
  final String? value;

  const LogEventButtonParameters({this.isDebugMode = kDebugMode, required this.type, this.value});

  @override
  String get name => 'event';

  @override
  Map<String, Object> toMap() => {
        'event': name,
        'isDebugMode': isDebugMode.toString(),
        'type': type.name,
        'value': value.toString(),
      };
}

class ErrorEventParameters implements LogEventParameters, Error {
  final bool isDebugMode;
  final String message;

  const ErrorEventParameters({this.isDebugMode = kDebugMode, required this.message});

  @override
  String get name => 'error';

  @override
  Map<String, Object> toMap() => {
        'error': name,
        'isDebugMode': isDebugMode.toString(),
        'stackTrace': stackTrace.toString(),
      };

  @override
  StackTrace? get stackTrace => StackTrace.fromString(message);
}
