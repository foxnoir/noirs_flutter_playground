// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchState {

 bool get isSearching; bool get hasSearched; List<User> get matches;
/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchStateCopyWith<UserSearchState> get copyWith => _$UserSearchStateCopyWithImpl<UserSearchState>(this as UserSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchState&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.hasSearched, hasSearched) || other.hasSearched == hasSearched)&&const DeepCollectionEquality().equals(other.matches, matches));
}


@override
int get hashCode => Object.hash(runtimeType,isSearching,hasSearched,const DeepCollectionEquality().hash(matches));

@override
String toString() {
  return 'UserSearchState(isSearching: $isSearching, hasSearched: $hasSearched, matches: $matches)';
}


}

/// @nodoc
abstract mixin class $UserSearchStateCopyWith<$Res>  {
  factory $UserSearchStateCopyWith(UserSearchState value, $Res Function(UserSearchState) _then) = _$UserSearchStateCopyWithImpl;
@useResult
$Res call({
 bool isSearching, bool hasSearched, List<User> matches
});




}
/// @nodoc
class _$UserSearchStateCopyWithImpl<$Res>
    implements $UserSearchStateCopyWith<$Res> {
  _$UserSearchStateCopyWithImpl(this._self, this._then);

  final UserSearchState _self;
  final $Res Function(UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSearching = null,Object? hasSearched = null,Object? matches = null,}) {
  return _then(UserSearchState(
isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,hasSearched: null == hasSearched ? _self.hasSearched : hasSearched // ignore: cast_nullable_to_non_nullable
as bool,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchState].
extension UserSearchStatePatterns on UserSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchState value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSearching,  bool hasSearched,  List<User> matches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.isSearching,_that.hasSearched,_that.matches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSearching,  bool hasSearched,  List<User> matches)  $default,) {final _that = this;
switch (_that) {
case _UserSearchState():
return $default(_that.isSearching,_that.hasSearched,_that.matches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSearching,  bool hasSearched,  List<User> matches)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.isSearching,_that.hasSearched,_that.matches);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchState implements UserSearchState {
  const _UserSearchState({this.isSearching = false, this.hasSearched = false,  List<User> matches = const <User>[]}): _matches = matches;
  

@override@JsonKey() final  bool isSearching;
@override@JsonKey() final  bool hasSearched;
 final  List<User> _matches;
@override@JsonKey() List<User> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}


/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchStateCopyWith<_UserSearchState> get copyWith => __$UserSearchStateCopyWithImpl<_UserSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchState&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.hasSearched, hasSearched) || other.hasSearched == hasSearched)&&const DeepCollectionEquality().equals(other._matches, _matches));
}


@override
int get hashCode => Object.hash(runtimeType,isSearching,hasSearched,const DeepCollectionEquality().hash(_matches));

@override
String toString() {
  return 'UserSearchState(isSearching: $isSearching, hasSearched: $hasSearched, matches: $matches)';
}


}

/// @nodoc
abstract mixin class _$UserSearchStateCopyWith<$Res> implements $UserSearchStateCopyWith<$Res> {
  factory _$UserSearchStateCopyWith(_UserSearchState value, $Res Function(_UserSearchState) _then) = __$UserSearchStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSearching, bool hasSearched, List<User> matches
});




}
/// @nodoc
class __$UserSearchStateCopyWithImpl<$Res>
    implements _$UserSearchStateCopyWith<$Res> {
  __$UserSearchStateCopyWithImpl(this._self, this._then);

  final _UserSearchState _self;
  final $Res Function(_UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSearching = null,Object? hasSearched = null,Object? matches = null,}) {
  return _then(_UserSearchState(
isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,hasSearched: null == hasSearched ? _self.hasSearched : hasSearched // ignore: cast_nullable_to_non_nullable
as bool,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}


}

// dart format on
