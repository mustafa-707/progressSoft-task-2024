// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppPostImpl _$$AppPostImplFromJson(Map<String, dynamic> json) =>
    _$AppPostImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$$AppPostImplToJson(_$AppPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
    };
