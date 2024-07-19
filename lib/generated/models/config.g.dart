// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigImpl _$$ConfigImplFromJson(Map<String, dynamic> json) => _$ConfigImpl(
      delay: (json['delay'] as num).toInt(),
      regex: FieldRegex.fromJson(json['regex'] as Map<String, dynamic>),
      countries:
          (json['countries'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ConfigImplToJson(_$ConfigImpl instance) =>
    <String, dynamic>{
      'delay': instance.delay,
      'regex': instance.regex.toJson(),
      'countries': instance.countries,
    };

_$FieldRegexImpl _$$FieldRegexImplFromJson(Map<String, dynamic> json) =>
    _$FieldRegexImpl(
      mobile: (json['mobile'] as List<dynamic>)
          .map((e) => RegexInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      password: (json['password'] as List<dynamic>)
          .map((e) => RegexInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      fullName: (json['fullName'] as List<dynamic>)
          .map((e) => RegexInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FieldRegexImplToJson(_$FieldRegexImpl instance) =>
    <String, dynamic>{
      'mobile': instance.mobile.map((e) => e.toJson()).toList(),
      'password': instance.password.map((e) => e.toJson()).toList(),
      'fullName': instance.fullName.map((e) => e.toJson()).toList(),
    };

_$RegexInfoImpl _$$RegexInfoImplFromJson(Map<String, dynamic> json) =>
    _$RegexInfoImpl(
      ar: json['ar'] as String,
      en: json['en'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$RegexInfoImplToJson(_$RegexInfoImpl instance) =>
    <String, dynamic>{
      'ar': instance.ar,
      'en': instance.en,
      'value': instance.value,
    };
