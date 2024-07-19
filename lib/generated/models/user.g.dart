// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      age: (json['age'] as num).toInt(),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      country: json['country'] as String,
      passwordHash: json['passwordHash'] as String,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
      'gender': _$GenderEnumMap[instance.gender]!,
      'country': instance.country,
      'passwordHash': instance.passwordHash,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
