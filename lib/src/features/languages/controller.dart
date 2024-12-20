import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../common/common.dart';
import 'repository.dart';

class CvAppLanguage extends Equatable {
  static const String defaultLanguage = 'en';

  final String code;

  const CvAppLanguage({this.code = defaultLanguage});

  @override
  List<Object?> get props => [code];
}

class CvAppLanguageState extends Equatable {
  final CvAppLanguage cvAppLanguage;

  const CvAppLanguageState({this.cvAppLanguage = const CvAppLanguage()});

  @override
  List<Object?> get props => [cvAppLanguage];

  CvAppLanguageState copyWith({
    required CvAppLanguage? cvAppLanguage,
  }) =>
      CvAppLanguageState(cvAppLanguage: cvAppLanguage ?? this.cvAppLanguage);
}

abstract class CvAppLanguageController {
  void read();
  Future<void> save(String languageCode);
  Stream<CvAppLanguageState> get stream;
  CvAppLanguageState get value;
}

class CvAppLanguageControllerImpl with CvWebLogger implements CvAppLanguageController {
  final StreamController<CvAppLanguageState> _controller =
      StreamController<CvAppLanguageState>.broadcast();

  CvAppLanguageState _state = const CvAppLanguageState();

  final CvAppLanguageRepository _repository;

  CvAppLanguageControllerImpl({
    required CvAppLanguageRepository repository,
  }) : _repository = repository {
    read();
  }

  @override
  Stream<CvAppLanguageState> get stream => _controller.stream;

  @override
  CvAppLanguageState get value => _state;

  void emit(CvAppLanguageState newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  void read() {
    final savedCode = _repository.read();
    emit(
      _state.copyWith(
        cvAppLanguage: savedCode != null
            ? CvAppLanguage(
                code: savedCode,
              )
            : null,
      ),
    );
  }

  @override
  Future<void> save(String languageCode) async {
    try {
      await _repository.save(languageCode);
      read();
    } catch (e) {
      error(e.toString());
    }
  }
}
