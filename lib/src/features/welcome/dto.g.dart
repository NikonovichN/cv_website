// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WelcomeScreenDTO _$WelcomeScreenDTOFromJson(Map<String, dynamic> json) =>
    WelcomeScreenDTO(
      title: json['title'] as String,
      description: json['description'] as String,
      tryAgainLabel: json['try-again-button'] as String,
      phone1: json['phone-1'] as String,
      phone2: json['phone-2'] as String,
    );

Map<String, dynamic> _$WelcomeScreenDTOToJson(WelcomeScreenDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'try-again-button': instance.tryAgainLabel,
      'phone-1': instance.phone1,
      'phone-2': instance.phone2,
    };
