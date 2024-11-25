import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class ExperienceScreenDTO {
  final String title;

  @JsonKey(name: 'download-button')
  final String downloadButton;

  @JsonKey(name: 'experience')
  final List<ExperienceDTO> list;

  ExperienceScreenDTO({
    required this.title,
    required this.downloadButton,
    required this.list,
  });

  factory ExperienceScreenDTO.fromJson(Map<String, dynamic> json) =>
      _$ExperienceScreenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceScreenDTOToJson(this);
}

@JsonSerializable()
class ExperienceDTO {
  final String period;

  final String title;

  final List<ProjectDTO> projects;

  ExperienceDTO({
    required this.period,
    required this.title,
    required this.projects,
  });

  factory ExperienceDTO.fromJson(Map<String, dynamic> json) => _$ExperienceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceDTOToJson(this);
}

@JsonSerializable()
class ProjectDTO {
  final String period;

  @JsonKey(name: 'project-description')
  final String projectDescription;

  final String role;
  final String responsibilities;

  @JsonKey(name: 'team-size')
  final String teamSize;
  final String tools;

  ProjectDTO({
    required this.period,
    required this.projectDescription,
    required this.role,
    required this.responsibilities,
    required this.teamSize,
    required this.tools,
  });

  factory ProjectDTO.fromJson(Map<String, dynamic> json) => _$ProjectDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDTOToJson(this);
}
