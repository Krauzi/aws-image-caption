// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polly_get.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollyGet _$PollyGetFromJson(Map<String, dynamic> json) {
  return PollyGet(
    response: json['reponse'] == null
        ? null
        : Response.fromJson(json['reponse'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PollyGetToJson(PollyGet instance) => <String, dynamic>{
      'reponse': instance.response,
    };
