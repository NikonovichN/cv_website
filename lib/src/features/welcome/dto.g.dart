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
      socials: WelcomeScreenDTO._convertFromJson(json['socials']),
    );

Map<String, dynamic> _$WelcomeScreenDTOToJson(WelcomeScreenDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'try-again-button': instance.tryAgainLabel,
      'phone-1': instance.phone1,
      'phone-2': instance.phone2,
      'socials': instance.socials,
    };

SocialsDTO _$SocialsDTOFromJson(Map<String, dynamic> json) => SocialsDTO(
      git: json['git'] as String,
      gmail: json['gmail'] as String,
      linkedIn: json['linkedIn'] as String,
      telegram: json['telegram'] as String,
    );

Map<String, dynamic> _$SocialsDTOToJson(SocialsDTO instance) =>
    <String, dynamic>{
      'git': instance.git,
      'gmail': instance.gmail,
      'linkedIn': instance.linkedIn,
      'telegram': instance.telegram,
    };
