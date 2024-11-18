import 'package:firebase_database/firebase_database.dart';

abstract class WelcomeRepository {
  Future<dynamic> loadData(String language);
}

class WelcomeRepositoryImpl implements WelcomeRepository {
  final FirebaseDatabase _remoteDB;

  const WelcomeRepositoryImpl({required FirebaseDatabase remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<dynamic> loadData(String language) async {
    final data = await _remoteDB.ref('welcome_screen').child('/en').get();

    return Future.value(data);
  }
}
