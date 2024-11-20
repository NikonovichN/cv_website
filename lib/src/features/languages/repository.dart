import 'package:cv_website/src/managers/shared_preferences.dart';

abstract class CvAppLanguageRepository {
  String? read();
  Future<void> save(String language);
}

class CvAppLanguageRepositoryImpl implements CvAppLanguageRepository {
  final SharedPreferencesManager _prefs;

  const CvAppLanguageRepositoryImpl({required SharedPreferencesManager prefs}) : _prefs = prefs;

  static const String _key = 'cv_app_language';

  @override
  String? read() => _prefs.readString(_key);

  @override
  Future<void> save(String language) async {
    await _prefs.setString(_key, language);
  }
}
