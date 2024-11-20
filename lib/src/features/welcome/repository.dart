import 'package:firebase_database/firebase_database.dart';

import 'dto.dart';
import '../../common/errors.dart';

abstract class WelcomeRepository {
  Future<WelcomeScreenDTO> loadData(String language);
}

class WelcomeRepositoryImpl implements WelcomeRepository {
  final FirebaseDatabase _remoteDB;

  const WelcomeRepositoryImpl({required FirebaseDatabase remoteDB}) : _remoteDB = remoteDB;

  static const _path = 'welcome-screen';
  static const _errorEmptyData = 'No data loaded!';

  @override
  Future<WelcomeScreenDTO> loadData(String language) async {
    final data = await _remoteDB.ref(_path).child(language).get();

    if (data.exists) {
      return WelcomeScreenDTO.fromJson(Map<String, dynamic>.from(data.value as Map));
    }

    throw const RepositoryError(message: '$_path: $_errorEmptyData');
  }
}
