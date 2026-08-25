// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserListState {

 bool get isLoading; String? get error; List<User> get users;
/// Create a copy of UserListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserListStateCopyWith<UserListState> get copyWith => _$UserListStateCopyWithImpl<UserListState>(this as UserListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.users, users));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,const DeepCollectionEquality().hash(users));

@override
String toString() {
  return 'UserListState(isLoading: $isLoading, error: $error, users: $users)';
}


}

/// @nodoc
abstract mixin class $UserListStateCopyWith<$Res>  {
  factory $UserListStateCopyWith(UserListState value, $Res Function(UserListState) _then) = _$UserListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? error, List<User> users
});




}
/// @nodoc
class _$UserListStateCopyWithImpl<$Res>
    implements $UserListStateCopyWith<$Res> {
  _$UserListStateCopyWithImpl(this._self, this._then);

  final UserListState _self;
  final $Res Function(UserListState) _then;

/// Create a copy of UserListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = freezed,Object? users = null,}) {
  return _then(UserListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserListState].
extension UserListStatePatterns on UserListState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserListState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserListState value)  $default,){
final _that = this;
switch (_that) {
case _UserListState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserListState value)?  $default,){
final _that = this;
switch (_that) {
case _UserListState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  List<User> users)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserListState() when $default != null:
return $default(_that.isLoading,_that.error,_that.users);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? error,  List<User> users)  $default,) {final _that = this;
switch (_that) {
case _UserListState():
return $default(_that.isLoading,_that.error,_that.users);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? error,  List<User> users)?  $default,) {final _that = this;
switch (_that) {
case _UserListState() when $default != null:
return $default(_that.isLoading,_that.error,_that.users);case _:
  return null;

}
}

}

/// @nodoc


class _UserListState implements UserListState {
  const _UserListState({this.isLoading = false, this.error,  List<User> users = const <User>[]}): _users = users;
  

@override@JsonKey() final  bool isLoading;
@override final  String? error;
 final  List<User> _users;
@override@JsonKey() List<User> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of UserListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserListStateCopyWith<_UserListState> get copyWith => __$UserListStateCopyWithImpl<_UserListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._users, _users));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'UserListState(isLoading: $isLoading, error: $error, users: $users)';
}


}

/// @nodoc
abstract mixin class _$UserListStateCopyWith<$Res> implements $UserListStateCopyWith<$Res> {
  factory _$UserListStateCopyWith(_UserListState value, $Res Function(_UserListState) _then) = __$UserListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? error, List<User> users
});




}
/// @nodoc
class __$UserListStateCopyWithImpl<$Res>
    implements _$UserListStateCopyWith<$Res> {
  __$UserListStateCopyWithImpl(this._self, this._then);

  final _UserListState _self;
  final $Res Function(_UserListState) _then;

/// Create a copy of UserListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = freezed,Object? users = null,}) {
  return _then(_UserListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}


}

// dart format on
