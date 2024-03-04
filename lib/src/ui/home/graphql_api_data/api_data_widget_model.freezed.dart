// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_data_widget_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiDataWidgetState {
  List<SingleEpisode>? get episodes => throw _privateConstructorUsedError;
  ApiDataStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ApiDataWidgetStateCopyWith<ApiDataWidgetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiDataWidgetStateCopyWith<$Res> {
  factory $ApiDataWidgetStateCopyWith(
          ApiDataWidgetState value, $Res Function(ApiDataWidgetState) then) =
      _$ApiDataWidgetStateCopyWithImpl<$Res, ApiDataWidgetState>;
  @useResult
  $Res call(
      {List<SingleEpisode>? episodes,
      ApiDataStatus status,
      String? errorMessage});
}

/// @nodoc
class _$ApiDataWidgetStateCopyWithImpl<$Res, $Val extends ApiDataWidgetState>
    implements $ApiDataWidgetStateCopyWith<$Res> {
  _$ApiDataWidgetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? episodes = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      episodes: freezed == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<SingleEpisode>?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApiDataStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiDataWidgetStateImplCopyWith<$Res>
    implements $ApiDataWidgetStateCopyWith<$Res> {
  factory _$$ApiDataWidgetStateImplCopyWith(_$ApiDataWidgetStateImpl value,
          $Res Function(_$ApiDataWidgetStateImpl) then) =
      __$$ApiDataWidgetStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SingleEpisode>? episodes,
      ApiDataStatus status,
      String? errorMessage});
}

/// @nodoc
class __$$ApiDataWidgetStateImplCopyWithImpl<$Res>
    extends _$ApiDataWidgetStateCopyWithImpl<$Res, _$ApiDataWidgetStateImpl>
    implements _$$ApiDataWidgetStateImplCopyWith<$Res> {
  __$$ApiDataWidgetStateImplCopyWithImpl(_$ApiDataWidgetStateImpl _value,
      $Res Function(_$ApiDataWidgetStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? episodes = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ApiDataWidgetStateImpl(
      episodes: freezed == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<SingleEpisode>?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApiDataStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ApiDataWidgetStateImpl implements _ApiDataWidgetState {
  const _$ApiDataWidgetStateImpl(
      {final List<SingleEpisode>? episodes,
      this.status = ApiDataStatus.loading,
      this.errorMessage})
      : _episodes = episodes;

  final List<SingleEpisode>? _episodes;
  @override
  List<SingleEpisode>? get episodes {
    final value = _episodes;
    if (value == null) return null;
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final ApiDataStatus status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ApiDataWidgetState(episodes: $episodes, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiDataWidgetStateImpl &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_episodes), status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiDataWidgetStateImplCopyWith<_$ApiDataWidgetStateImpl> get copyWith =>
      __$$ApiDataWidgetStateImplCopyWithImpl<_$ApiDataWidgetStateImpl>(
          this, _$identity);
}

abstract class _ApiDataWidgetState implements ApiDataWidgetState {
  const factory _ApiDataWidgetState(
      {final List<SingleEpisode>? episodes,
      final ApiDataStatus status,
      final String? errorMessage}) = _$ApiDataWidgetStateImpl;

  @override
  List<SingleEpisode>? get episodes;
  @override
  ApiDataStatus get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$ApiDataWidgetStateImplCopyWith<_$ApiDataWidgetStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
