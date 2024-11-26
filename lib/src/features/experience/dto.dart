import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class ExperienceScreenDTO {
  final String title;

  @JsonKey(name: 'download-button')
  final String downloadButton;

  @JsonKey(name: 'try-again-button')
  final String tryAgainButton;

  @JsonKey(name: 'experience', fromJson: _convertExperienceFromJson)
  final List<ExperienceDTO> list;

  ExperienceScreenDTO({
    required this.title,
    required this.downloadButton,
    required this.tryAgainButton,
    required this.list,
  });

  static _convertExperienceFromJson(List<dynamic> json) => json
      .map((e) => _$ExperienceDTOFromJson(
            Map<String, dynamic>.from(e as Map),
          ))
      .toList();

  factory ExperienceScreenDTO.fromJson(Map<String, dynamic> json) =>
      _$ExperienceScreenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceScreenDTOToJson(this);
}

@JsonSerializable()
class ExperienceDTO {
  final String period;

  final String title;

  @JsonKey(fromJson: _convertProjectFromJson)
  final List<ProjectDTO> projects;

  ExperienceDTO({
    required this.period,
    required this.title,
    required this.projects,
  });

  static _convertProjectFromJson(List<dynamic> json) => json
      .map((e) => _$ProjectDTOFromJson(
            Map<String, dynamic>.from(e as Map),
          ))
      .toList();

  factory ExperienceDTO.fromJson(Map<String, dynamic> json) => _$ExperienceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceDTOToJson(this);
}

@JsonSerializable()
class ProjectDTO {
  final String period;

  @JsonKey(name: 'project-description')
  final String projectDescription;

  @JsonKey(name: 'project-description-title')
  final String projectDescriptionTitle;

  final String role;

  final String responsibilities;

  @JsonKey(name: 'responsibilities-title')
  final String responsibilitiesTitle;

  @JsonKey(name: 'team-size')
  final String teamSize;

  @JsonKey(name: 'team-size-title')
  final String teamSizeTitle;

  final String tools;

  @JsonKey(name: 'tools-title')
  final String toolsTitle;

  ProjectDTO({
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

  factory ProjectDTO.fromJson(Map<String, dynamic> json) => _$ProjectDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDTOToJson(this);
}
