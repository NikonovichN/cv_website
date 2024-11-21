// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillsScreenDTO _$SkillsScreenDTOFromJson(Map<String, dynamic> json) =>
    SkillsScreenDTO(
      education: json['education'] as String,
      educationList: json['education-list'] as String,
      leftRate: json['left-rate'] as String,
      rightRate: json['right-rate'] as String,
      rateList: json['rate-list'] as String,
    );

Map<String, dynamic> _$SkillsScreenDTOToJson(SkillsScreenDTO instance) =>
    <String, dynamic>{
      'education': instance.education,
      'education-list': instance.educationList,
      'left-rate': instance.leftRate,
      'right-rate': instance.rightRate,
      'rate-list': instance.rateList,
    };
