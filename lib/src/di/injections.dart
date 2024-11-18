import 'package:get_it/get_it.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:cv_website/src/features/features.dart';

import '../managers/firebase_database.dart';

final GetIt injector = GetIt.instance;

class DependencyInjections {
  const DependencyInjections._();

  static Future<void> registerDependencies() async {
    injector.registerSingleton<FirebaseDatabase>(initializeFirebaseDatabase());

    injector.registerSingleton<WelcomeRepository>(WelcomeRepositoryImpl(remoteDB: injector()));
    injector.registerSingleton<WelcomeScreenController>(
      WelcomeScreenControllerImpl(repository: injector())..loadData(),
    );
    injector.registerSingleton<Stream<WelcomeScreenState>>(
      injector<WelcomeScreenController>().stream,
    );
  }
}
