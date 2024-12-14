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
    injector
      ..registerSingleton<FirebaseDatabase>(initializeFirebaseDatabase())
      ..registerSingleton<SharedPreferencesManager>(
          SharedPreferencesManagerImpl(prefs: await SharedPreferences.getInstance()));

    /// Repositories
    injector
      ..registerSingleton<CvAppLanguageRepository>(CvAppLanguageRepositoryImpl(prefs: injector()))
      ..registerSingleton<MenuRepository>(MenuRepositoryImpl(remoteDB: injector()))
      ..registerSingleton<WelcomeRepository>(WelcomeRepositoryImpl(remoteDB: injector()))
      ..registerSingleton<SkillsRepository>(SkillsRepositoryImpl(remoteDB: injector()))
      ..registerSingleton<ExperienceRepository>(ExperienceRepositoryImpl(remoteDB: injector()));

    /// Controllers
    injector
      ..registerSingleton<CvAppLanguageController>(
          CvAppLanguageControllerImpl(repository: injector()))
      ..registerSingleton<CvAppMenuController>(CvAppMenuControllerImpl(repository: injector()))
      ..registerSingleton<WelcomeScreenController>(
          WelcomeScreenControllerImpl(repository: injector()))
      ..registerSingleton<SkillsScreenController>(
          SkillsScreenControllerImpl(repository: injector()))
      ..registerSingleton<ExperienceScreenController>(
          ExperienceScreenControllerImpl(repository: injector()));

    /// Other
    injector
      ..registerSingleton<Stream<CvAppLanguageState>>(injector<CvAppLanguageController>().stream)
      ..registerSingleton<CvAppLanguageState>(injector<CvAppLanguageController>().value)
      ..registerSingleton<Stream<WelcomeScreenState>>(injector<WelcomeScreenController>().stream)
      ..registerSingleton<Stream<CvAppMenuState>>(injector<CvAppMenuController>().stream)
      ..registerSingleton<Stream<SkillsScreenState>>(injector<SkillsScreenController>().stream)
      ..registerSingleton<Stream<ExperienceScreenState>>(
          injector<ExperienceScreenController>().stream);
  }
}
