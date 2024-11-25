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
      list: (json['experience'] as List<dynamic>)
          .map((e) => ExperienceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      projects: (json['projects'] as List<dynamic>)
          .map((e) => ProjectDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      role: json['role'] as String,
      responsibilities: json['responsibilities'] as String,
      teamSize: json['team-size'] as String,
      tools: json['tools'] as String,
    );

Map<String, dynamic> _$ProjectDTOToJson(ProjectDTO instance) =>
    <String, dynamic>{
      'period': instance.period,
      'project-description': instance.projectDescription,
      'role': instance.role,
      'responsibilities': instance.responsibilities,
      'team-size': instance.teamSize,
      'tools': instance.tools,
    };
