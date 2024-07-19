import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/user.freezed.dart';
part '../generated/models/user.g.dart';

enum Gender { male, female }

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String name,
    required String phoneNumber,
    required int age,
    required Gender gender,
    required String country,
    required String passwordHash,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
