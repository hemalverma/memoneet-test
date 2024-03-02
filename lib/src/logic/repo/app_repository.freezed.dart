// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppRepositoryState {
  UserModel? get userModel => throw _privateConstructorUsedError;
  AppState get appStatus => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppRepositoryStateCopyWith<AppRepositoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppRepositoryStateCopyWith<$Res> {
  factory $AppRepositoryStateCopyWith(
          AppRepositoryState value, $Res Function(AppRepositoryState) then) =
      _$AppRepositoryStateCopyWithImpl<$Res, AppRepositoryState>;
  @useResult
  $Res call({UserModel? userModel, AppState appStatus, String? errorMessage});
}

/// @nodoc
class _$AppRepositoryStateCopyWithImpl<$Res, $Val extends AppRepositoryState>
    implements $AppRepositoryStateCopyWith<$Res> {
  _$AppRepositoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userModel = freezed,
    Object? appStatus = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      userModel: freezed == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      appStatus: null == appStatus
          ? _value.appStatus
          : appStatus // ignore: cast_nullable_to_non_nullable
              as AppState,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppRepositoryStateImplCopyWith<$Res>
    implements $AppRepositoryStateCopyWith<$Res> {
  factory _$$AppRepositoryStateImplCopyWith(_$AppRepositoryStateImpl value,
          $Res Function(_$AppRepositoryStateImpl) then) =
      __$$AppRepositoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel? userModel, AppState appStatus, String? errorMessage});
}

/// @nodoc
class __$$AppRepositoryStateImplCopyWithImpl<$Res>
    extends _$AppRepositoryStateCopyWithImpl<$Res, _$AppRepositoryStateImpl>
    implements _$$AppRepositoryStateImplCopyWith<$Res> {
  __$$AppRepositoryStateImplCopyWithImpl(_$AppRepositoryStateImpl _value,
      $Res Function(_$AppRepositoryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userModel = freezed,
    Object? appStatus = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AppRepositoryStateImpl(
      userModel: freezed == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      appStatus: null == appStatus
          ? _value.appStatus
          : appStatus // ignore: cast_nullable_to_non_nullable
              as AppState,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AppRepositoryStateImpl implements _AppRepositoryState {
  _$AppRepositoryStateImpl(
      {this.userModel,
      this.appStatus = AppState.authenticating,
      this.errorMessage});

  @override
  final UserModel? userModel;
  @override
  @JsonKey()
  final AppState appStatus;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AppRepositoryState(userModel: $userModel, appStatus: $appStatus, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppRepositoryStateImpl &&
            (identical(other.userModel, userModel) ||
                other.userModel == userModel) &&
            (identical(other.appStatus, appStatus) ||
                other.appStatus == appStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userModel, appStatus, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppRepositoryStateImplCopyWith<_$AppRepositoryStateImpl> get copyWith =>
      __$$AppRepositoryStateImplCopyWithImpl<_$AppRepositoryStateImpl>(
          this, _$identity);
}

abstract class _AppRepositoryState implements AppRepositoryState {
  factory _AppRepositoryState(
      {final UserModel? userModel,
      final AppState appStatus,
      final String? errorMessage}) = _$AppRepositoryStateImpl;

  @override
  UserModel? get userModel;
  @override
  AppState get appStatus;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AppRepositoryStateImplCopyWith<_$AppRepositoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
