// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Tutor {

 String get name; List<int> get employedSince;
/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorCopyWith<Tutor> get copyWith => _$TutorCopyWithImpl<Tutor>(this as Tutor, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Tutor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tutor&&(identical(other.name, _this.name) || other.name == _this.name)&&const DeepCollectionEquality().equals(other.employedSince, _this.employedSince));
}


@override
int get hashCode {
  final _this = this as Tutor;
  return Object.hash(runtimeType,_this.name,const DeepCollectionEquality().hash(_this.employedSince));
}

@override
String toString() {
  final _this = this as Tutor;
  return 'Tutor(name: ${_this.name}, employedSince: ${_this.employedSince})';
}


}

/// @nodoc
abstract mixin class $TutorCopyWith<$Res>  {
  factory $TutorCopyWith(Tutor value, $Res Function(Tutor) _then) = _$TutorCopyWithImpl;
@useResult
$Res call({
 String name, List<int> employedSince
});




}
/// @nodoc
class _$TutorCopyWithImpl<$Res>
    implements $TutorCopyWith<$Res> {
  _$TutorCopyWithImpl(this._self, this._then);

  final Tutor _self;
  final $Res Function(Tutor) _then;

/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employedSince = null,}) {
  return _then(Tutor(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employedSince: null == employedSince ? _self.employedSince : employedSince // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [Tutor].
extension TutorPatterns on Tutor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tutor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tutor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tutor value)  $default,){
final _that = this;
switch (_that) {
case _Tutor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tutor value)?  $default,){
final _that = this;
switch (_that) {
case _Tutor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<int> employedSince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tutor() when $default != null:
return $default(_that.name,_that.employedSince);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<int> employedSince)  $default,) {final _that = this;
switch (_that) {
case _Tutor():
return $default(_that.name,_that.employedSince);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<int> employedSince)?  $default,) {final _that = this;
switch (_that) {
case _Tutor() when $default != null:
return $default(_that.name,_that.employedSince);case _:
  return null;

}
}

}

/// @nodoc


class _Tutor implements Tutor {
  const _Tutor({required this.name, required  List<int> employedSince}): _employedSince = employedSince;
  

@override final  String name;
 final  List<int> _employedSince;
@override List<int> get employedSince {
  if (_employedSince is EqualUnmodifiableListView) return _employedSince;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employedSince);
}


/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorCopyWith<_Tutor> get copyWith => __$TutorCopyWithImpl<_Tutor>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tutor&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.employedSince, _employedSince));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_employedSince));
}

@override
String toString() {
    return 'Tutor(name: $name, employedSince: $employedSince)';
}


}

/// @nodoc
abstract mixin class _$TutorCopyWith<$Res> implements $TutorCopyWith<$Res> {
  factory _$TutorCopyWith(_Tutor value, $Res Function(_Tutor) _then) = __$TutorCopyWithImpl;
@override @useResult
$Res call({
 String name, List<int> employedSince
});




}
/// @nodoc
class __$TutorCopyWithImpl<$Res>
    implements _$TutorCopyWith<$Res> {
  __$TutorCopyWithImpl(this._self, this._then);

  final _Tutor _self;
  final $Res Function(_Tutor) _then;

/// Create a copy of Tutor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employedSince = null,}) {
  return _then(_Tutor(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employedSince: null == employedSince ? _self._employedSince : employedSince // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
