import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class WelcomeScreenDTO {
  final String title;

  final String description;

  @JsonKey(name: 'try-again-button')
  final String tryAgainLabel;

  @JsonKey(name: 'phone-1')
  final String phone1;

  @JsonKey(name: 'phone-2')
  final String phone2;

  @JsonKey(fromJson: _convertFromJson)
  final SocialsDTO socials;

  static _convertFromJson(socials) =>
      _$SocialsDTOFromJson(Map<String, dynamic>.from(socials as Map));

  WelcomeScreenDTO({
    required this.title,
    required this.description,
    required this.tryAgainLabel,
    required this.phone1,
    required this.phone2,
    required this.socials,
  });

  factory WelcomeScreenDTO.fromJson(Map<String, dynamic> json) => _$WelcomeScreenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomeScreenDTOToJson(this);
}

@JsonSerializable()
class SocialsDTO {
  final String git;
  final String gmail;
  final String linkedIn;
  final String telegram;

  SocialsDTO({
    required this.git,
    required this.gmail,
    required this.linkedIn,
    required this.telegram,
  });

  factory SocialsDTO.fromJson(Map<String, dynamic> json) => _$SocialsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SocialsDTOToJson(this);
}
