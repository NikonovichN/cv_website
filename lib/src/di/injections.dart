import 'package:get_it/get_it.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cv_website/src/features/features.dart';

import '../managers/firebase_database.dart';
import '../managers/shared_preferences.dart';

final GetIt injector = GetIt.instance;

class DependencyInjections {
  const DependencyInjections._();

  static Future<void> registerDependencies() async {
    injector.registerSingleton<FirebaseDatabase>(initializeFirebaseDatabase());
    injector.registerSingleton<SharedPreferencesManager>(
      SharedPreferencesManagerImpl(prefs: await SharedPreferences.getInstance()),
    );

    injector.registerSingleton<WelcomeRepository>(WelcomeRepositoryImpl(remoteDB: injector()));
    injector.registerSingleton<WelcomeScreenController>(
      WelcomeScreenControllerImpl(repository: injector())..loadData(),
    );
    injector.registerSingleton<Stream<WelcomeScreenState>>(
      injector<WelcomeScreenController>().stream,
    );

    injector.registerSingleton<CvAppLanguageRepository>(
      CvAppLanguageRepositoryImpl(prefs: injector()),
    );
    injector.registerSingleton<CvAppLanguageController>(
      CvAppLanguageControllerImpl(repository: injector())..read(),
    );
  }
}
