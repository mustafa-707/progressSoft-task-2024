import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/config.freezed.dart';
part '../generated/models/config.g.dart';

@freezed
class Config with _$Config {
  const factory Config({
    required int delay,
    required FieldRegex regex,
    required List<String> countries,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}

@freezed
class FieldRegex with _$FieldRegex {
  const factory FieldRegex({
    required List<RegexInfo> mobile,
    required List<RegexInfo> password,
    required List<RegexInfo> fullName,
  }) = _FieldRegex;

  factory FieldRegex.fromJson(Map<String, dynamic> json) => _$FieldRegexFromJson(json);
}

@freezed
class RegexInfo with _$RegexInfo {
  const factory RegexInfo({
    required String ar,
    required String en,
    required String value,
  }) = _RegexInfo;

  factory RegexInfo.fromJson(Map<String, dynamic> json) => _$RegexInfoFromJson(json);
}
