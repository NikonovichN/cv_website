// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuDTO _$MenuDTOFromJson(Map<String, dynamic> json) => MenuDTO(
      welcome: json['welcome'] as String,
      skills: json['skills'] as String,
      experience: json['experience'] as String,
    );

Map<String, dynamic> _$MenuDTOToJson(MenuDTO instance) => <String, dynamic>{
      'welcome': instance.welcome,
      'skills': instance.skills,
      'experience': instance.experience,
    };
