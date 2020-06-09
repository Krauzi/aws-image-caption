import 'package:json_annotation/json_annotation.dart';

part 'ec2_image.g.dart';

@JsonSerializable()
class Ec2Image {
  @JsonKey(name: 'img')
  String img;

  Ec2Image({this.img});

  factory Ec2Image.fromJson(Map<String, dynamic> json) => _$Ec2ImageFromJson(json);
  Map<String, dynamic> toJson() => _$Ec2ImageToJson(this);
}