// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceScreenDTO _$ExperienceScreenDTOFromJson(Map<String, dynamic> json) =>
    ExperienceScreenDTO(
      title: json['title'] as String,
      downloadButton: json['download-button'] as String,
      tryAgainButton: json['try-again-button'] as String,
      list: ExperienceScreenDTO._convertExperienceFromJson(
          json['experience'] as List),
    );

Map<String, dynamic> _$ExperienceScreenDTOToJson(
        ExperienceScreenDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'download-button': instance.downloadButton,
      'try-again-button': instance.tryAgainButton,
      'experience': instance.list,
    };

ExperienceDTO _$ExperienceDTOFromJson(Map<String, dynamic> json) =>
    ExperienceDTO(
      period: json['period'] as String,
      title: json['title'] as String,
      projects: ExperienceDTO._convertProjectFromJson(json['projects'] as List),
    );

Map<String, dynamic> _$ExperienceDTOToJson(ExperienceDTO instance) =>
    <String, dynamic>{
      'period': instance.period,
      'title': instance.title,
      'projects': instance.projects,
    };

ProjectDTO _$ProjectDTOFromJson(Map<String, dynamic> json) => ProjectDTO(
      period: json['period'] as String,
      projectDescription: json['project-description'] as String,
      projectDescriptionTitle: json['project-description-title'] as String,
      role: json['role'] as String,
      responsibilities: json['responsibilities'] as String,
      responsibilitiesTitle: json['responsibilities-title'] as String,
      teamSize: json['team-size'] as String,
      teamSizeTitle: json['team-size-title'] as String,
      tools: json['tools'] as String,
      toolsTitle: json['tools-title'] as String,
    );

Map<String, dynamic> _$ProjectDTOToJson(ProjectDTO instance) =>
    <String, dynamic>{
      'period': instance.period,
      'project-description': instance.projectDescription,
      'project-description-title': instance.projectDescriptionTitle,
      'role': instance.role,
      'responsibilities': instance.responsibilities,
      'responsibilities-title': instance.responsibilitiesTitle,
      'team-size': instance.teamSize,
      'team-size-title': instance.teamSizeTitle,
      'tools': instance.tools,
      'tools-title': instance.toolsTitle,
    };
