import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class MenuDTO {
  final String welcome;
  final String skills;
  final String experience;


  MenuDTO({
    required this.welcome,
    required this.skills,
    required this.experience,
  });

  factory MenuDTO.fromJson(Map<String, dynamic> json) => _$MenuDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MenuDTOToJson(this);
}
