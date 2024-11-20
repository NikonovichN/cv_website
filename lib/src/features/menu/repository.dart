import 'package:firebase_database/firebase_database.dart';

import 'dto.dart';
import '../../common/errors.dart';

abstract class MenuRepository {
  Future<MenuDTO> loadItems(String language);
}

class MenuRepositoryImpl implements MenuRepository {
  final FirebaseDatabase _remoteDB;

  const MenuRepositoryImpl({required FirebaseDatabase remoteDB}) : _remoteDB = remoteDB;

  static const _path = 'menu';
  static const _errorEmptyData = 'No data loaded!';

  @override
  Future<MenuDTO> loadItems(String language) async {
    final data = await _remoteDB.ref(_path).child(language).get();

    if (data.exists) {
      return MenuDTO.fromJson(Map<String, dynamic>.from(data.value as Map));
    }

    throw const RepositoryError(message: '$_path: $_errorEmptyData');
  }
}
