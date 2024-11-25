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
    /// Stuff
    injector.registerSingleton<FirebaseDatabase>(initializeFirebaseDatabase());
    injector.registerSingleton<SharedPreferencesManager>(
      SharedPreferencesManagerImpl(prefs: await SharedPreferences.getInstance()),
    );

    /// Repositories
    injector.registerSingleton<MenuRepository>(MenuRepositoryImpl(remoteDB: injector()));
    injector.registerSingleton<WelcomeRepository>(WelcomeRepositoryImpl(remoteDB: injector()));
    injector
        .registerSingleton<CvAppLanguageRepository>(CvAppLanguageRepositoryImpl(prefs: injector()));
    injector.registerSingleton<SkillsRepository>(SkillsRepositoryImpl(remoteDB: injector()));
    injector
        .registerSingleton<ExperienceRepository>(ExperienceRepositoryImpl(remoteDB: injector()));

    /// Controllers
    injector
        .registerSingleton<CvAppMenuController>(CvAppMenuControllerImpl(repository: injector()));
    injector.registerSingleton<WelcomeScreenController>(
      WelcomeScreenControllerImpl(repository: injector()),
    );
    injector.registerSingleton<CvAppLanguageController>(
      CvAppLanguageControllerImpl(repository: injector()),
    );
    injector.registerSingleton<SkillsScreenController>(
      SkillsScreenControllerImpl(repository: injector()),
    );

    /// Other
    injector.registerSingleton<Stream<CvAppLanguageState>>(
      injector<CvAppLanguageController>().stream,
    );
    injector.registerSingleton<CvAppLanguageState>(
      injector<CvAppLanguageController>().value,
    );
    injector.registerSingleton<Stream<WelcomeScreenState>>(
      injector<WelcomeScreenController>().stream,
    );
    injector.registerSingleton<Stream<CvAppMenuState>>(
      injector<CvAppMenuController>().stream,
    );
    injector.registerSingleton<Stream<SkillsScreenState>>(
      injector<SkillsScreenController>().stream,
    );
  }
}
