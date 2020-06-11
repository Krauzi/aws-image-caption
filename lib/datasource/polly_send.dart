import 'package:json_annotation/json_annotation.dart';

part 'polly_send.g.dart';

@JsonSerializable()
class PollySend {
  @JsonKey(name: 'textToSpeech')
  String textToSpeech;

  PollySend({this.textToSpeech});

  factory PollySend.fromJson(Map<String, dynamic> json) => _$PollySendFromJson(json);
  Map<String, dynamic> toJson() => _$PollySendToJson(this);
}