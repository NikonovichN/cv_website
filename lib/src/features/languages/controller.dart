import 'dart:async';

import 'package:equatable/equatable.dart';

import 'repository.dart';

class CvAppLanguage extends Equatable {
  final String code;

  const CvAppLanguage({required this.code});

  @override
  List<Object?> get props => [code];
}

class CvAppLanguageState extends Equatable {
  static const _defaultAppLanguage = CvAppLanguage(code: 'en');

  final CvAppLanguage cvAppLanguage;

  const CvAppLanguageState({this.cvAppLanguage = _defaultAppLanguage});

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

class CvAppLanguageControllerImpl implements CvAppLanguageController {
  final StreamController<CvAppLanguageState> _controller = StreamController<CvAppLanguageState>();

  CvAppLanguageState _state = const CvAppLanguageState();

  final CvAppLanguageRepository _repository;

  CvAppLanguageControllerImpl({
    required CvAppLanguageRepository repository,
  }) : _repository = repository;

  @override
  Stream<CvAppLanguageState> get stream => _controller.stream;

  @override
  CvAppLanguageState get value => _state;

  void emit(CvAppLanguageState newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  void read() => emit(
        _state.copyWith(
          cvAppLanguage: CvAppLanguage(
            code: _repository.read(),
          ),
        ),
      );

  @override
  Future<void> save(String languageCode) async {
    try {
      await _repository.save(languageCode);
      read();
      // TODO: to think about handle this case
      // ignore: empty_catches
    } catch (_) {}
  }
}
