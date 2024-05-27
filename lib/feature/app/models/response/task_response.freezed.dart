// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) {
  return _TaskResponse.fromJson(json);
}

/// @nodoc
mixin _$TaskResponse {
  int get revision => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Task get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskResponseCopyWith<TaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskResponseCopyWith<$Res> {
  factory $TaskResponseCopyWith(
          TaskResponse value, $Res Function(TaskResponse) then) =
      _$TaskResponseCopyWithImpl<$Res>;
  $Res call({int revision, String status, Task element});

  $TaskCopyWith<$Res> get element;
}

/// @nodoc
class _$TaskResponseCopyWithImpl<$Res> implements $TaskResponseCopyWith<$Res> {
  _$TaskResponseCopyWithImpl(this._value, this._then);

  final TaskResponse _value;
  // ignore: unused_field
  final $Res Function(TaskResponse) _then;

  @override
  $Res call({
    Object? revision = freezed,
    Object? status = freezed,
    Object? element = freezed,
  }) {
    return _then(_value.copyWith(
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }

  @override
  $TaskCopyWith<$Res> get element {
    return $TaskCopyWith<$Res>(_value.element, (value) {
      return _then(_value.copyWith(element: value));
    });
  }
}

/// @nodoc
abstract class _$$_TaskResponseCopyWith<$Res>
    implements $TaskResponseCopyWith<$Res> {
  factory _$$_TaskResponseCopyWith(
          _$_TaskResponse value, $Res Function(_$_TaskResponse) then) =
      __$$_TaskResponseCopyWithImpl<$Res>;
  @override
  $Res call({int revision, String status, Task element});

  @override
  $TaskCopyWith<$Res> get element;
}

/// @nodoc
class __$$_TaskResponseCopyWithImpl<$Res>
    extends _$TaskResponseCopyWithImpl<$Res>
    implements _$$_TaskResponseCopyWith<$Res> {
  __$$_TaskResponseCopyWithImpl(
      _$_TaskResponse _value, $Res Function(_$_TaskResponse) _then)
      : super(_value, (v) => _then(v as _$_TaskResponse));

  @override
  _$_TaskResponse get _value => super._value as _$_TaskResponse;

  @override
  $Res call({
    Object? revision = freezed,
    Object? status = freezed,
    Object? element = freezed,
  }) {
    return _then(_$_TaskResponse(
      revision: revision == freezed
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskResponse implements _TaskResponse {
  const _$_TaskResponse(
      {required this.revision, required this.status, required this.element});

  factory _$_TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$$_TaskResponseFromJson(json);

  @override
  final int revision;
  @override
  final String status;
  @override
  final Task element;

  @override
  String toString() {
    return 'TaskResponse(revision: $revision, status: $status, element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskResponse &&
            const DeepCollectionEquality().equals(other.revision, revision) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.element, element));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(revision),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(element));

  @JsonKey(ignore: true)
  @override
  _$$_TaskResponseCopyWith<_$_TaskResponse> get copyWith =>
      __$$_TaskResponseCopyWithImpl<_$_TaskResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskResponseToJson(
      this,
    );
  }
}

abstract class _TaskResponse implements TaskResponse {
  const factory _TaskResponse(
      {required final int revision,
      required final String status,
      required final Task element}) = _$_TaskResponse;

  factory _TaskResponse.fromJson(Map<String, dynamic> json) =
      _$_TaskResponse.fromJson;

  @override
  int get revision;
  @override
  String get status;
  @override
  Task get element;
  @override
  @JsonKey(ignore: true)
  _$$_TaskResponseCopyWith<_$_TaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
