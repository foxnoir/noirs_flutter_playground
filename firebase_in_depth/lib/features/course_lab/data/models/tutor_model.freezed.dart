// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TutorModel {

 String get name; List<int> get employedSince;
/// Create a copy of TutorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorModelCopyWith<TutorModel> get copyWith => _$TutorModelCopyWithImpl<TutorModel>(this as TutorModel, _$identity);

  /// Serializes this TutorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TutorModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorModel&&(identical(other.name, _this.name) || other.name == _this.name)&&const DeepCollectionEquality().equals(other.employedSince, _this.employedSince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TutorModel;
  return Object.hash(runtimeType,_this.name,const DeepCollectionEquality().hash(_this.employedSince));
}

@override
String toString() {
  final _this = this as TutorModel;
  return 'TutorModel(name: ${_this.name}, employedSince: ${_this.employedSince})';
}


}

/// @nodoc
abstract mixin class $TutorModelCopyWith<$Res>  {
  factory $TutorModelCopyWith(TutorModel value, $Res Function(TutorModel) _then) = _$TutorModelCopyWithImpl;
@useResult
$Res call({
 String name, List<int> employedSince
});




}
/// @nodoc
class _$TutorModelCopyWithImpl<$Res>
    implements $TutorModelCopyWith<$Res> {
  _$TutorModelCopyWithImpl(this._self, this._then);

  final TutorModel _self;
  final $Res Function(TutorModel) _then;

/// Create a copy of TutorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employedSince = null,}) {
  return _then(TutorModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employedSince: null == employedSince ? _self.employedSince : employedSince // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [TutorModel].
extension TutorModelPatterns on TutorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TutorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TutorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TutorModel value)  $default,){
final _that = this;
switch (_that) {
case _TutorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TutorModel value)?  $default,){
final _that = this;
switch (_that) {
case _TutorModel() when $default != null:
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
case _TutorModel() when $default != null:
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
case _TutorModel():
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
case _TutorModel() when $default != null:
return $default(_that.name,_that.employedSince);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TutorModel implements TutorModel {
  const _TutorModel({required this.name, required  List<int> employedSince}): _employedSince = employedSince;
  factory _TutorModel.fromJson(Map<String, dynamic> json) => _$TutorModelFromJson(json);

@override final  String name;
 final  List<int> _employedSince;
@override List<int> get employedSince {
  if (_employedSince is EqualUnmodifiableListView) return _employedSince;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employedSince);
}


/// Create a copy of TutorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorModelCopyWith<_TutorModel> get copyWith => __$TutorModelCopyWithImpl<_TutorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TutorModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TutorModel&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.employedSince, _employedSince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_employedSince));
}

@override
String toString() {
    return 'TutorModel(name: $name, employedSince: $employedSince)';
}


}

/// @nodoc
abstract mixin class _$TutorModelCopyWith<$Res> implements $TutorModelCopyWith<$Res> {
  factory _$TutorModelCopyWith(_TutorModel value, $Res Function(_TutorModel) _then) = __$TutorModelCopyWithImpl;
@override @useResult
$Res call({
 String name, List<int> employedSince
});




}
/// @nodoc
class __$TutorModelCopyWithImpl<$Res>
    implements _$TutorModelCopyWith<$Res> {
  __$TutorModelCopyWithImpl(this._self, this._then);

  final _TutorModel _self;
  final $Res Function(_TutorModel) _then;

/// Create a copy of TutorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employedSince = null,}) {
  return _then(_TutorModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employedSince: null == employedSince ? _self._employedSince : employedSince // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
