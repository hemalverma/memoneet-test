// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginPageState {
  String? get email => throw _privateConstructorUsedError;
  bool get emailError => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  bool get passwordError => throw _privateConstructorUsedError;
  LoginStatus get loginStatus => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginPageStateCopyWith<LoginPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginPageStateCopyWith<$Res> {
  factory $LoginPageStateCopyWith(
          LoginPageState value, $Res Function(LoginPageState) then) =
      _$LoginPageStateCopyWithImpl<$Res, LoginPageState>;
  @useResult
  $Res call(
      {String? email,
      bool emailError,
      String? password,
      bool passwordError,
      LoginStatus loginStatus,
      String? errorMessage});
}

/// @nodoc
class _$LoginPageStateCopyWithImpl<$Res, $Val extends LoginPageState>
    implements $LoginPageStateCopyWith<$Res> {
  _$LoginPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? emailError = null,
    Object? password = freezed,
    Object? passwordError = null,
    Object? loginStatus = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      emailError: null == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as bool,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: null == passwordError
          ? _value.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as bool,
      loginStatus: null == loginStatus
          ? _value.loginStatus
          : loginStatus // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginPageStateImplCopyWith<$Res>
    implements $LoginPageStateCopyWith<$Res> {
  factory _$$LoginPageStateImplCopyWith(_$LoginPageStateImpl value,
          $Res Function(_$LoginPageStateImpl) then) =
      __$$LoginPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      bool emailError,
      String? password,
      bool passwordError,
      LoginStatus loginStatus,
      String? errorMessage});
}

/// @nodoc
class __$$LoginPageStateImplCopyWithImpl<$Res>
    extends _$LoginPageStateCopyWithImpl<$Res, _$LoginPageStateImpl>
    implements _$$LoginPageStateImplCopyWith<$Res> {
  __$$LoginPageStateImplCopyWithImpl(
      _$LoginPageStateImpl _value, $Res Function(_$LoginPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? emailError = null,
    Object? password = freezed,
    Object? passwordError = null,
    Object? loginStatus = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$LoginPageStateImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      emailError: null == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as bool,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordError: null == passwordError
          ? _value.passwordError
          : passwordError // ignore: cast_nullable_to_non_nullable
              as bool,
      loginStatus: null == loginStatus
          ? _value.loginStatus
          : loginStatus // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoginPageStateImpl implements _LoginPageState {
  const _$LoginPageStateImpl(
      {this.email,
      this.emailError = false,
      this.password,
      this.passwordError = false,
      this.loginStatus = LoginStatus.initial,
      this.errorMessage});

  @override
  final String? email;
  @override
  @JsonKey()
  final bool emailError;
  @override
  final String? password;
  @override
  @JsonKey()
  final bool passwordError;
  @override
  @JsonKey()
  final LoginStatus loginStatus;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'LoginPageState(email: $email, emailError: $emailError, password: $password, passwordError: $passwordError, loginStatus: $loginStatus, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPageStateImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordError, passwordError) ||
                other.passwordError == passwordError) &&
            (identical(other.loginStatus, loginStatus) ||
                other.loginStatus == loginStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, emailError, password,
      passwordError, loginStatus, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginPageStateImplCopyWith<_$LoginPageStateImpl> get copyWith =>
      __$$LoginPageStateImplCopyWithImpl<_$LoginPageStateImpl>(
          this, _$identity);
}

abstract class _LoginPageState implements LoginPageState {
  const factory _LoginPageState(
      {final String? email,
      final bool emailError,
      final String? password,
      final bool passwordError,
      final LoginStatus loginStatus,
      final String? errorMessage}) = _$LoginPageStateImpl;

  @override
  String? get email;
  @override
  bool get emailError;
  @override
  String? get password;
  @override
  bool get passwordError;
  @override
  LoginStatus get loginStatus;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$LoginPageStateImplCopyWith<_$LoginPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
