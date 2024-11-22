import 'package:firebase_database/firebase_database.dart';

import 'dto.dart';
import '../../common/errors.dart';

abstract class SkillsRepository {
  Future<SkillsScreenDTO> loadData(String language);
}

class SkillsRepositoryImpl implements SkillsRepository {
  final FirebaseDatabase _remoteDB;

  const SkillsRepositoryImpl({required FirebaseDatabase remoteDB}) : _remoteDB = remoteDB;

  static const _path = 'skills';
  static const _errorEmptyData = 'No data loaded!';

  @override
  Future<SkillsScreenDTO> loadData(String language) async {
    final data = await _remoteDB.ref(_path).child(language).get();

    if (data.exists) {
      return SkillsScreenDTO.fromJson(Map<String, dynamic>.from(data.value as Map));
    }

    throw const RepositoryError(message: '$_path: $_errorEmptyData');
  }
}
