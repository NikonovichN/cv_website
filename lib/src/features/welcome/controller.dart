import 'dart:async';

import 'package:equatable/equatable.dart';

import 'dto.dart';
import 'repository.dart';
import '../../common/errors.dart';

class SocialLinks extends Equatable {
  static const defaultTelegram = 'https://t.me/Nikita_Nikonovich';
  static const defaultLinkedIn = 'https://www.linkedin.com/in/nikita-nikonovich-970828a1';
  static const defaultGmail = 'mailto:nikonovichnd@gmail.com?subject=Mikita\'s%20site%20subject';
  static const defaultGitHub = 'https://github.com/NikonovichN?tab=repositories';

  final String telegram;
  final String linkedIn;
  final String gmail;
  final String gitHub;

  const SocialLinks({
    this.telegram = defaultTelegram,
    this.linkedIn = defaultLinkedIn,
    this.gmail = defaultGmail,
    this.gitHub = defaultGitHub,
  });

  @override
  List<Object?> get props => [telegram];
}

class WelcomeScreenData extends Equatable {
  static const defaultTryAgainLabel = 'Try again!';

  final String title;
  final String description;
  final String tryAgainLabel;
  final String phone1;
  final String phone2;
  final SocialLinks socialLinks;

  const WelcomeScreenData({
    required this.title,
    required this.description,
    this.tryAgainLabel = defaultTryAgainLabel,
    required this.phone1,
    required this.phone2,
    required this.socialLinks,
  });

  @override
  List<Object?> get props => [title, description, tryAgainLabel, phone1, phone2];
}

class WelcomeScreenState extends Equatable {
  final bool isLoading;
  final WelcomeScreenData? screenData;
  final RepositoryError? error;

  const WelcomeScreenState({required this.isLoading, this.screenData, this.error});

  @override
  List<Object?> get props => [isLoading, screenData, error];

  WelcomeScreenState copyWith({
    required bool isLoading,
    WelcomeScreenData? screenData,
    RepositoryError? error,
  }) {
    return WelcomeScreenState(
      isLoading: isLoading,
      screenData: screenData ?? this.screenData,
      error: error ?? this.error,
    );
  }
}

abstract class WelcomeScreenController {
  Future<void> loadData(String language);
  Stream<WelcomeScreenState> get stream;
  WelcomeScreenState get state;
}

class WelcomeScreenControllerImpl implements WelcomeScreenController {
  final StreamController<WelcomeScreenState> _controller =
      StreamController<WelcomeScreenState>.broadcast();

  WelcomeScreenState _state = const WelcomeScreenState(isLoading: false);

  final WelcomeRepository _repository;

  WelcomeScreenControllerImpl({
    required WelcomeRepository repository,
  }) : _repository = repository;

  @override
  Stream<WelcomeScreenState> get stream => _controller.stream;

  @override
  WelcomeScreenState get state => _state;

  void emit(WelcomeScreenState newState) {
    _state = newState;
    _controller.add(newState);
  }

  @override
  Future<void> loadData(String language) async {
    if (state.isLoading) {
      return;
    }

    emit(_state.copyWith(isLoading: true, screenData: null, error: null));

    try {
      final repositoryData = await _repository.loadData(language);

      emit(
        _state.copyWith(
          isLoading: false,
          screenData: repositoryData.toScreenData(),
        ),
      );
    } catch (error) {
      emit(_state.copyWith(
        isLoading: false,
        error: RepositoryError(
          message: error.toString(),
        ),
      ));
    }
  }
}

extension on WelcomeScreenDTO {
  WelcomeScreenData toScreenData() => WelcomeScreenData(
        description: description,
        title: title,
        tryAgainLabel: tryAgainLabel,
        phone1: phone1,
        phone2: phone2,
        socialLinks: SocialLinks(
          telegram: socials.telegram,
          gitHub: socials.git,
          linkedIn: socials.linkedIn,
          gmail: socials.gmail,
        ),
      );
}
