// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  int get delay => throw _privateConstructorUsedError;
  FieldRegex get regex => throw _privateConstructorUsedError;
  List<String> get countries => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call({int delay, FieldRegex regex, List<String> countries});

  $FieldRegexCopyWith<$Res> get regex;
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delay = null,
    Object? regex = null,
    Object? countries = null,
  }) {
    return _then(_value.copyWith(
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as int,
      regex: null == regex
          ? _value.regex
          : regex // ignore: cast_nullable_to_non_nullable
              as FieldRegex,
      countries: null == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldRegexCopyWith<$Res> get regex {
    return $FieldRegexCopyWith<$Res>(_value.regex, (value) {
      return _then(_value.copyWith(regex: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConfigImplCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$ConfigImplCopyWith(
          _$ConfigImpl value, $Res Function(_$ConfigImpl) then) =
      __$$ConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int delay, FieldRegex regex, List<String> countries});

  @override
  $FieldRegexCopyWith<$Res> get regex;
}

/// @nodoc
class __$$ConfigImplCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$ConfigImpl>
    implements _$$ConfigImplCopyWith<$Res> {
  __$$ConfigImplCopyWithImpl(
      _$ConfigImpl _value, $Res Function(_$ConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delay = null,
    Object? regex = null,
    Object? countries = null,
  }) {
    return _then(_$ConfigImpl(
      delay: null == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as int,
      regex: null == regex
          ? _value.regex
          : regex // ignore: cast_nullable_to_non_nullable
              as FieldRegex,
      countries: null == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigImpl implements _Config {
  const _$ConfigImpl(
      {required this.delay,
      required this.regex,
      required final List<String> countries})
      : _countries = countries;

  factory _$ConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigImplFromJson(json);

  @override
  final int delay;
  @override
  final FieldRegex regex;
  final List<String> _countries;
  @override
  List<String> get countries {
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  @override
  String toString() {
    return 'Config(delay: $delay, regex: $regex, countries: $countries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigImpl &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.regex, regex) || other.regex == regex) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, delay, regex,
      const DeepCollectionEquality().hash(_countries));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      __$$ConfigImplCopyWithImpl<_$ConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigImplToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  const factory _Config(
      {required final int delay,
      required final FieldRegex regex,
      required final List<String> countries}) = _$ConfigImpl;

  factory _Config.fromJson(Map<String, dynamic> json) = _$ConfigImpl.fromJson;

  @override
  int get delay;
  @override
  FieldRegex get regex;
  @override
  List<String> get countries;
  @override
  @JsonKey(ignore: true)
  _$$ConfigImplCopyWith<_$ConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldRegex _$FieldRegexFromJson(Map<String, dynamic> json) {
  return _FieldRegex.fromJson(json);
}

/// @nodoc
mixin _$FieldRegex {
  List<RegexInfo> get mobile => throw _privateConstructorUsedError;
  List<RegexInfo> get password => throw _privateConstructorUsedError;
  List<RegexInfo> get fullName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldRegexCopyWith<FieldRegex> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldRegexCopyWith<$Res> {
  factory $FieldRegexCopyWith(
          FieldRegex value, $Res Function(FieldRegex) then) =
      _$FieldRegexCopyWithImpl<$Res, FieldRegex>;
  @useResult
  $Res call(
      {List<RegexInfo> mobile,
      List<RegexInfo> password,
      List<RegexInfo> fullName});
}

/// @nodoc
class _$FieldRegexCopyWithImpl<$Res, $Val extends FieldRegex>
    implements $FieldRegexCopyWith<$Res> {
  _$FieldRegexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobile = null,
    Object? password = null,
    Object? fullName = null,
  }) {
    return _then(_value.copyWith(
      mobile: null == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as List<RegexInfo>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as List<RegexInfo>,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as List<RegexInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldRegexImplCopyWith<$Res>
    implements $FieldRegexCopyWith<$Res> {
  factory _$$FieldRegexImplCopyWith(
          _$FieldRegexImpl value, $Res Function(_$FieldRegexImpl) then) =
      __$$FieldRegexImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RegexInfo> mobile,
      List<RegexInfo> password,
      List<RegexInfo> fullName});
}

/// @nodoc
class __$$FieldRegexImplCopyWithImpl<$Res>
    extends _$FieldRegexCopyWithImpl<$Res, _$FieldRegexImpl>
    implements _$$FieldRegexImplCopyWith<$Res> {
  __$$FieldRegexImplCopyWithImpl(
      _$FieldRegexImpl _value, $Res Function(_$FieldRegexImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobile = null,
    Object? password = null,
    Object? fullName = null,
  }) {
    return _then(_$FieldRegexImpl(
      mobile: null == mobile
          ? _value._mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as List<RegexInfo>,
      password: null == password
          ? _value._password
          : password // ignore: cast_nullable_to_non_nullable
              as List<RegexInfo>,
      fullName: null == fullName
          ? _value._fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as List<RegexInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldRegexImpl implements _FieldRegex {
  const _$FieldRegexImpl(
      {required final List<RegexInfo> mobile,
      required final List<RegexInfo> password,
      required final List<RegexInfo> fullName})
      : _mobile = mobile,
        _password = password,
        _fullName = fullName;

  factory _$FieldRegexImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldRegexImplFromJson(json);

  final List<RegexInfo> _mobile;
  @override
  List<RegexInfo> get mobile {
    if (_mobile is EqualUnmodifiableListView) return _mobile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mobile);
  }

  final List<RegexInfo> _password;
  @override
  List<RegexInfo> get password {
    if (_password is EqualUnmodifiableListView) return _password;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_password);
  }

  final List<RegexInfo> _fullName;
  @override
  List<RegexInfo> get fullName {
    if (_fullName is EqualUnmodifiableListView) return _fullName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fullName);
  }

  @override
  String toString() {
    return 'FieldRegex(mobile: $mobile, password: $password, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldRegexImpl &&
            const DeepCollectionEquality().equals(other._mobile, _mobile) &&
            const DeepCollectionEquality().equals(other._password, _password) &&
            const DeepCollectionEquality().equals(other._fullName, _fullName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mobile),
      const DeepCollectionEquality().hash(_password),
      const DeepCollectionEquality().hash(_fullName));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldRegexImplCopyWith<_$FieldRegexImpl> get copyWith =>
      __$$FieldRegexImplCopyWithImpl<_$FieldRegexImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldRegexImplToJson(
      this,
    );
  }
}

abstract class _FieldRegex implements FieldRegex {
  const factory _FieldRegex(
      {required final List<RegexInfo> mobile,
      required final List<RegexInfo> password,
      required final List<RegexInfo> fullName}) = _$FieldRegexImpl;

  factory _FieldRegex.fromJson(Map<String, dynamic> json) =
      _$FieldRegexImpl.fromJson;

  @override
  List<RegexInfo> get mobile;
  @override
  List<RegexInfo> get password;
  @override
  List<RegexInfo> get fullName;
  @override
  @JsonKey(ignore: true)
  _$$FieldRegexImplCopyWith<_$FieldRegexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegexInfo _$RegexInfoFromJson(Map<String, dynamic> json) {
  return _RegexInfo.fromJson(json);
}

/// @nodoc
mixin _$RegexInfo {
  String get ar => throw _privateConstructorUsedError;
  String get en => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegexInfoCopyWith<RegexInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegexInfoCopyWith<$Res> {
  factory $RegexInfoCopyWith(RegexInfo value, $Res Function(RegexInfo) then) =
      _$RegexInfoCopyWithImpl<$Res, RegexInfo>;
  @useResult
  $Res call({String ar, String en, String value});
}

/// @nodoc
class _$RegexInfoCopyWithImpl<$Res, $Val extends RegexInfo>
    implements $RegexInfoCopyWith<$Res> {
  _$RegexInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ar = null,
    Object? en = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      ar: null == ar
          ? _value.ar
          : ar // ignore: cast_nullable_to_non_nullable
              as String,
      en: null == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegexInfoImplCopyWith<$Res>
    implements $RegexInfoCopyWith<$Res> {
  factory _$$RegexInfoImplCopyWith(
          _$RegexInfoImpl value, $Res Function(_$RegexInfoImpl) then) =
      __$$RegexInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ar, String en, String value});
}

/// @nodoc
class __$$RegexInfoImplCopyWithImpl<$Res>
    extends _$RegexInfoCopyWithImpl<$Res, _$RegexInfoImpl>
    implements _$$RegexInfoImplCopyWith<$Res> {
  __$$RegexInfoImplCopyWithImpl(
      _$RegexInfoImpl _value, $Res Function(_$RegexInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ar = null,
    Object? en = null,
    Object? value = null,
  }) {
    return _then(_$RegexInfoImpl(
      ar: null == ar
          ? _value.ar
          : ar // ignore: cast_nullable_to_non_nullable
              as String,
      en: null == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegexInfoImpl implements _RegexInfo {
  const _$RegexInfoImpl(
      {required this.ar, required this.en, required this.value});

  factory _$RegexInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegexInfoImplFromJson(json);

  @override
  final String ar;
  @override
  final String en;
  @override
  final String value;

  @override
  String toString() {
    return 'RegexInfo(ar: $ar, en: $en, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegexInfoImpl &&
            (identical(other.ar, ar) || other.ar == ar) &&
            (identical(other.en, en) || other.en == en) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ar, en, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegexInfoImplCopyWith<_$RegexInfoImpl> get copyWith =>
      __$$RegexInfoImplCopyWithImpl<_$RegexInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegexInfoImplToJson(
      this,
    );
  }
}

abstract class _RegexInfo implements RegexInfo {
  const factory _RegexInfo(
      {required final String ar,
      required final String en,
      required final String value}) = _$RegexInfoImpl;

  factory _RegexInfo.fromJson(Map<String, dynamic> json) =
      _$RegexInfoImpl.fromJson;

  @override
  String get ar;
  @override
  String get en;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$RegexInfoImplCopyWith<_$RegexInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
