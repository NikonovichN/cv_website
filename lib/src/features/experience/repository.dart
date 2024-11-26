import 'package:firebase_database/firebase_database.dart';

import 'dto.dart';
import '../../common/errors.dart';

abstract class ExperienceRepository {
  Future<ExperienceScreenDTO> loadData(String language);
}

class ExperienceRepositoryImpl implements ExperienceRepository {
  final FirebaseDatabase _remoteDB;

  const ExperienceRepositoryImpl({required FirebaseDatabase remoteDB}) : _remoteDB = remoteDB;

  static const _path = 'experience-screen';
  static const _errorEmptyData = 'No data loaded!';

  @override
  Future<ExperienceScreenDTO> loadData(String language) async {
    final data = await _remoteDB.ref(_path).child(language).get();

    if (data.exists) {
      return ExperienceScreenDTO.fromJson(Map<String, dynamic>.from(data.value as Map));
    }

    throw const RepositoryError(message: '$_path: $_errorEmptyData');
  }
}
