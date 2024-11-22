import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class SkillsScreenDTO {
  final String title;

  final String education;

  @JsonKey(name: 'education-list')
  final List<String> educationList;

  @JsonKey(name: 'left-rate')
  final String leftRate;

  @JsonKey(name: 'right-rate')
  final String rightRate;

  @JsonKey(name: 'rate-list')
  final List<String> rateList;

  @JsonKey(name: 'try-again-button')
  final String tryAgainLabel;

  SkillsScreenDTO({
    required this.title,
    required this.education,
    required this.educationList,
    required this.leftRate,
    required this.rightRate,
    required this.rateList,
    required this.tryAgainLabel,
  });

  factory SkillsScreenDTO.fromJson(Map<String, dynamic> json) => _$SkillsScreenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SkillsScreenDTOToJson(this);
}
