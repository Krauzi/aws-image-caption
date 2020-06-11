import 'package:awsimagecaption/datasource/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'polly_get.g.dart';

@JsonSerializable()
class PollyGet {
  @JsonKey(name: 'reponse')
  Response response;

  PollyGet({this.response});

  factory PollyGet.fromJson(Map<String, dynamic> json) => _$PollyGetFromJson(json);
  Map<String, dynamic> toJson() => _$PollyGetToJson(this);
}