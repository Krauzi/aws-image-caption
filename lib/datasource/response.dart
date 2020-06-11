import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class Response {
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'data')
  List<int> data;

  Response({this.type, this.data});

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}