import 'dart:async';

import 'package:equatable/equatable.dart';

import 'repository.dart';
import 'dto.dart';

import '../../common/common.dart';

class Project extends Equatable {
  final String period;
  final String projectDescription;
  final String projectDescriptionTitle;
  final String role;
  final String responsibilities;
  final String responsibilitiesTitle;
  final String teamSize;
  final String teamSizeTitle;
  final String tools;
  final String toolsTitle;

  const Project({
    required this.period,
    required this.projectDescription,
    required this.projectDescriptionTitle,
    required this.role,
    required this.responsibilities,
    required this.responsibilitiesTitle,
    required this.teamSize,
    required this.teamSizeTitle,
    required this.tools,
    required this.toolsTitle,
  });

  @override
  List<Object?> get props => [period, projectDescription, role, responsibilities, teamSize, tools];
}

class Experience extends Equatable {
  final String period;
  final String title;
  final List<Project> projects;

  const Experience({
    required this.period,
    required this.title,
    required this.projects,
  });

  @override
  List<Object?> get props => [period, title, projects];
}

class ExperienceScreenData extends Equatable {
  static const defaultTryAgainLabel = "Try again!";

  final String title;
  final String downloadLabel;
  final String tryAgainLabel;
  final List<Experience> list;

  const ExperienceScreenData({
    required this.title,
    required this.downloadLabel,
    required this.tryAgainLabel,
    required this.list,
  });

  @override
  List<Object?> get props => [title, downloadLabel, tryAgainLabel, list];
}

class ExperienceScreenState extends Equatable {
  final bool isLoading;
  final ExperienceScreenData? screenData;
  final RepositoryError? error;

  const ExperienceScreenState({required this.isLoading, this.screenData, this.error});

  @override
  List<Object?> get props => [isLoading, screenData, error];

  ExperienceScreenState copyWith({
    required bool isLoading,
    ExperienceScreenData? screenData,
    RepositoryError? error,
  }) {
    return ExperienceScreenState(
      isLoading: isLoading,
      screenData: screenData ?? this.screenData,
      error: error ?? this.error,
    );
  }
}

abstract class ExperienceScreenController {
  Future<void> loadData(String language);
  Stream<ExperienceScreenState> get stream;
  ExperienceScreenState get state;
}

class ExperienceScreenControllerImpl with CvWebLogger implements ExperienceScreenController {
  final StreamController<ExperienceScreenState> _controller =
      StreamController<ExperienceScreenState>.broadcast();

  ExperienceScreenState _state = const ExperienceScreenState(isLoading: false);

  final ExperienceRepository _repository;

  ExperienceScreenControllerImpl({
    required ExperienceRepository repository,
  }) : _repository = repository;

  @override
  Stream<ExperienceScreenState> get stream => _controller.stream;

  @override
  ExperienceScreenState get state => _state;

  void emit(ExperienceScreenState newState) {
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
          screenData: repositoryData.toScreenData,
        ),
      );
    } catch (e) {
      final errorString = e.toString();

      error(errorString);
      emit(_state.copyWith(
        isLoading: false,
        error: RepositoryError(message: errorString),
      ));
    }
  }
}

extension on ExperienceScreenDTO {
  ExperienceScreenData get toScreenData => ExperienceScreenData(
        title: title,
        downloadLabel: downloadButton,
        tryAgainLabel: tryAgainButton,
        list: list
            .map(
              (place) => Experience(
                period: place.period,
                title: place.title,
                projects: place.projects
                    .map(
                      (project) => Project(
                        period: project.period,
                        projectDescription: project.projectDescription,
                        projectDescriptionTitle: project.projectDescriptionTitle,
                        role: project.role,
                        responsibilities: project.responsibilities,
                        responsibilitiesTitle: project.responsibilitiesTitle,
                        teamSize: project.teamSize,
                        teamSizeTitle: project.teamSizeTitle,
                        tools: project.tools,
                        toolsTitle: project.toolsTitle,
                      ),
                    )
                    .toList()
                    .reversed
                    .toList(),
              ),
            )
            .toList()
            .reversed
            .toList(),
      );
}
