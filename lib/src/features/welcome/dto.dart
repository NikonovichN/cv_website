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

  WelcomeScreenDTO({
    required this.title,
    required this.description,
    required this.tryAgainLabel,
    required this.phone1,
    required this.phone2,
  });

  factory WelcomeScreenDTO.fromJson(Map<String, dynamic> json) => _$WelcomeScreenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomeScreenDTOToJson(this);
}
