import 'package:json_annotation/json_annotation.dart';

part 'ec2_caption.g.dart';

@JsonSerializable()
class Ec2Caption {
  @JsonKey(name: 'caption')
  String caption;

  Ec2Caption({this.caption});

  factory Ec2Caption.fromJson(Map<String, dynamic> json) => _$Ec2CaptionFromJson(json);
  Map<String, dynamic> toJson() => _$Ec2CaptionToJson(this);
}