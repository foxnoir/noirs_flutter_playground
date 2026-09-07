// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_fundamentals_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FirebaseFundamentalsState {

 AsyncValue<Course>? get document; AsyncValue<List<Course>>? get collection; AsyncValue<List<Course>>? get validQuery; AsyncValue<List<Course>>? get invalidQuery; AsyncValue<List<Course>>? get compositeQuery; AsyncValue<List<Course>>? get missingIndexQuery; AsyncValue<List<Lesson>>? get nestedLessons; AsyncValue<List<Lesson>>? get collectionGroupLessons; AsyncValue<CoursesSnapshot>? get realtime; bool get listening; AsyncValue<void>? get increment;
/// Create a copy of FirebaseFundamentalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirebaseFundamentalsStateCopyWith<FirebaseFundamentalsState> get copyWith => _$FirebaseFundamentalsStateCopyWithImpl<FirebaseFundamentalsState>(this as FirebaseFundamentalsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FirebaseFundamentalsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirebaseFundamentalsState&&(identical(other.document, _this.document) || other.document == _this.document)&&(identical(other.collection, _this.collection) || other.collection == _this.collection)&&(identical(other.validQuery, _this.validQuery) || other.validQuery == _this.validQuery)&&(identical(other.invalidQuery, _this.invalidQuery) || other.invalidQuery == _this.invalidQuery)&&(identical(other.compositeQuery, _this.compositeQuery) || other.compositeQuery == _this.compositeQuery)&&(identical(other.missingIndexQuery, _this.missingIndexQuery) || other.missingIndexQuery == _this.missingIndexQuery)&&(identical(other.nestedLessons, _this.nestedLessons) || other.nestedLessons == _this.nestedLessons)&&(identical(other.collectionGroupLessons, _this.collectionGroupLessons) || other.collectionGroupLessons == _this.collectionGroupLessons)&&(identical(other.realtime, _this.realtime) || other.realtime == _this.realtime)&&(identical(other.listening, _this.listening) || other.listening == _this.listening)&&(identical(other.increment, _this.increment) || other.increment == _this.increment));
}


@override
int get hashCode {
  final _this = this as FirebaseFundamentalsState;
  return Object.hash(runtimeType,_this.document,_this.collection,_this.validQuery,_this.invalidQuery,_this.compositeQuery,_this.missingIndexQuery,_this.nestedLessons,_this.collectionGroupLessons,_this.realtime,_this.listening,_this.increment);
}

@override
String toString() {
  final _this = this as FirebaseFundamentalsState;
  return 'FirebaseFundamentalsState(document: ${_this.document}, collection: ${_this.collection}, validQuery: ${_this.validQuery}, invalidQuery: ${_this.invalidQuery}, compositeQuery: ${_this.compositeQuery}, missingIndexQuery: ${_this.missingIndexQuery}, nestedLessons: ${_this.nestedLessons}, collectionGroupLessons: ${_this.collectionGroupLessons}, realtime: ${_this.realtime}, listening: ${_this.listening}, increment: ${_this.increment})';
}


}

/// @nodoc
abstract mixin class $FirebaseFundamentalsStateCopyWith<$Res>  {
  factory $FirebaseFundamentalsStateCopyWith(FirebaseFundamentalsState value, $Res Function(FirebaseFundamentalsState) _then) = _$FirebaseFundamentalsStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<Course>? document, AsyncValue<List<Course>>? collection, AsyncValue<List<Course>>? validQuery, AsyncValue<List<Course>>? invalidQuery, AsyncValue<List<Course>>? compositeQuery, AsyncValue<List<Course>>? missingIndexQuery, AsyncValue<List<Lesson>>? nestedLessons, AsyncValue<List<Lesson>>? collectionGroupLessons, AsyncValue<CoursesSnapshot>? realtime, bool listening, AsyncValue<void>? increment
});




}
/// @nodoc
class _$FirebaseFundamentalsStateCopyWithImpl<$Res>
    implements $FirebaseFundamentalsStateCopyWith<$Res> {
  _$FirebaseFundamentalsStateCopyWithImpl(this._self, this._then);

  final FirebaseFundamentalsState _self;
  final $Res Function(FirebaseFundamentalsState) _then;

/// Create a copy of FirebaseFundamentalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? document = freezed,Object? collection = freezed,Object? validQuery = freezed,Object? invalidQuery = freezed,Object? compositeQuery = freezed,Object? missingIndexQuery = freezed,Object? nestedLessons = freezed,Object? collectionGroupLessons = freezed,Object? realtime = freezed,Object? listening = null,Object? increment = freezed,}) {
  return _then(FirebaseFundamentalsState(
document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as AsyncValue<Course>?,collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,validQuery: freezed == validQuery ? _self.validQuery : validQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,invalidQuery: freezed == invalidQuery ? _self.invalidQuery : invalidQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,compositeQuery: freezed == compositeQuery ? _self.compositeQuery : compositeQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,missingIndexQuery: freezed == missingIndexQuery ? _self.missingIndexQuery : missingIndexQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,nestedLessons: freezed == nestedLessons ? _self.nestedLessons : nestedLessons // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Lesson>>?,collectionGroupLessons: freezed == collectionGroupLessons ? _self.collectionGroupLessons : collectionGroupLessons // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Lesson>>?,realtime: freezed == realtime ? _self.realtime : realtime // ignore: cast_nullable_to_non_nullable
as AsyncValue<CoursesSnapshot>?,listening: null == listening ? _self.listening : listening // ignore: cast_nullable_to_non_nullable
as bool,increment: freezed == increment ? _self.increment : increment // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FirebaseFundamentalsState].
extension FirebaseFundamentalsStatePatterns on FirebaseFundamentalsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirebaseFundamentalsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirebaseFundamentalsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirebaseFundamentalsState value)  $default,){
final _that = this;
switch (_that) {
case _FirebaseFundamentalsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirebaseFundamentalsState value)?  $default,){
final _that = this;
switch (_that) {
case _FirebaseFundamentalsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<Course>? document,  AsyncValue<List<Course>>? collection,  AsyncValue<List<Course>>? validQuery,  AsyncValue<List<Course>>? invalidQuery,  AsyncValue<List<Course>>? compositeQuery,  AsyncValue<List<Course>>? missingIndexQuery,  AsyncValue<List<Lesson>>? nestedLessons,  AsyncValue<List<Lesson>>? collectionGroupLessons,  AsyncValue<CoursesSnapshot>? realtime,  bool listening,  AsyncValue<void>? increment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirebaseFundamentalsState() when $default != null:
return $default(_that.document,_that.collection,_that.validQuery,_that.invalidQuery,_that.compositeQuery,_that.missingIndexQuery,_that.nestedLessons,_that.collectionGroupLessons,_that.realtime,_that.listening,_that.increment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<Course>? document,  AsyncValue<List<Course>>? collection,  AsyncValue<List<Course>>? validQuery,  AsyncValue<List<Course>>? invalidQuery,  AsyncValue<List<Course>>? compositeQuery,  AsyncValue<List<Course>>? missingIndexQuery,  AsyncValue<List<Lesson>>? nestedLessons,  AsyncValue<List<Lesson>>? collectionGroupLessons,  AsyncValue<CoursesSnapshot>? realtime,  bool listening,  AsyncValue<void>? increment)  $default,) {final _that = this;
switch (_that) {
case _FirebaseFundamentalsState():
return $default(_that.document,_that.collection,_that.validQuery,_that.invalidQuery,_that.compositeQuery,_that.missingIndexQuery,_that.nestedLessons,_that.collectionGroupLessons,_that.realtime,_that.listening,_that.increment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<Course>? document,  AsyncValue<List<Course>>? collection,  AsyncValue<List<Course>>? validQuery,  AsyncValue<List<Course>>? invalidQuery,  AsyncValue<List<Course>>? compositeQuery,  AsyncValue<List<Course>>? missingIndexQuery,  AsyncValue<List<Lesson>>? nestedLessons,  AsyncValue<List<Lesson>>? collectionGroupLessons,  AsyncValue<CoursesSnapshot>? realtime,  bool listening,  AsyncValue<void>? increment)?  $default,) {final _that = this;
switch (_that) {
case _FirebaseFundamentalsState() when $default != null:
return $default(_that.document,_that.collection,_that.validQuery,_that.invalidQuery,_that.compositeQuery,_that.missingIndexQuery,_that.nestedLessons,_that.collectionGroupLessons,_that.realtime,_that.listening,_that.increment);case _:
  return null;

}
}

}

/// @nodoc


class _FirebaseFundamentalsState implements FirebaseFundamentalsState {
  const _FirebaseFundamentalsState({this.document, this.collection, this.validQuery, this.invalidQuery, this.compositeQuery, this.missingIndexQuery, this.nestedLessons, this.collectionGroupLessons, this.realtime, this.listening = false, this.increment});
  

@override final  AsyncValue<Course>? document;
@override final  AsyncValue<List<Course>>? collection;
@override final  AsyncValue<List<Course>>? validQuery;
@override final  AsyncValue<List<Course>>? invalidQuery;
@override final  AsyncValue<List<Course>>? compositeQuery;
@override final  AsyncValue<List<Course>>? missingIndexQuery;
@override final  AsyncValue<List<Lesson>>? nestedLessons;
@override final  AsyncValue<List<Lesson>>? collectionGroupLessons;
@override final  AsyncValue<CoursesSnapshot>? realtime;
@override@JsonKey() final  bool listening;
@override final  AsyncValue<void>? increment;

/// Create a copy of FirebaseFundamentalsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirebaseFundamentalsStateCopyWith<_FirebaseFundamentalsState> get copyWith => __$FirebaseFundamentalsStateCopyWithImpl<_FirebaseFundamentalsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirebaseFundamentalsState&&(identical(other.document, document) || other.document == document)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.validQuery, validQuery) || other.validQuery == validQuery)&&(identical(other.invalidQuery, invalidQuery) || other.invalidQuery == invalidQuery)&&(identical(other.compositeQuery, compositeQuery) || other.compositeQuery == compositeQuery)&&(identical(other.missingIndexQuery, missingIndexQuery) || other.missingIndexQuery == missingIndexQuery)&&(identical(other.nestedLessons, nestedLessons) || other.nestedLessons == nestedLessons)&&(identical(other.collectionGroupLessons, collectionGroupLessons) || other.collectionGroupLessons == collectionGroupLessons)&&(identical(other.realtime, realtime) || other.realtime == realtime)&&(identical(other.listening, listening) || other.listening == listening)&&(identical(other.increment, increment) || other.increment == increment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,document,collection,validQuery,invalidQuery,compositeQuery,missingIndexQuery,nestedLessons,collectionGroupLessons,realtime,listening,increment);
}

@override
String toString() {
    return 'FirebaseFundamentalsState(document: $document, collection: $collection, validQuery: $validQuery, invalidQuery: $invalidQuery, compositeQuery: $compositeQuery, missingIndexQuery: $missingIndexQuery, nestedLessons: $nestedLessons, collectionGroupLessons: $collectionGroupLessons, realtime: $realtime, listening: $listening, increment: $increment)';
}


}

/// @nodoc
abstract mixin class _$FirebaseFundamentalsStateCopyWith<$Res> implements $FirebaseFundamentalsStateCopyWith<$Res> {
  factory _$FirebaseFundamentalsStateCopyWith(_FirebaseFundamentalsState value, $Res Function(_FirebaseFundamentalsState) _then) = __$FirebaseFundamentalsStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<Course>? document, AsyncValue<List<Course>>? collection, AsyncValue<List<Course>>? validQuery, AsyncValue<List<Course>>? invalidQuery, AsyncValue<List<Course>>? compositeQuery, AsyncValue<List<Course>>? missingIndexQuery, AsyncValue<List<Lesson>>? nestedLessons, AsyncValue<List<Lesson>>? collectionGroupLessons, AsyncValue<CoursesSnapshot>? realtime, bool listening, AsyncValue<void>? increment
});




}
/// @nodoc
class __$FirebaseFundamentalsStateCopyWithImpl<$Res>
    implements _$FirebaseFundamentalsStateCopyWith<$Res> {
  __$FirebaseFundamentalsStateCopyWithImpl(this._self, this._then);

  final _FirebaseFundamentalsState _self;
  final $Res Function(_FirebaseFundamentalsState) _then;

/// Create a copy of FirebaseFundamentalsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? document = freezed,Object? collection = freezed,Object? validQuery = freezed,Object? invalidQuery = freezed,Object? compositeQuery = freezed,Object? missingIndexQuery = freezed,Object? nestedLessons = freezed,Object? collectionGroupLessons = freezed,Object? realtime = freezed,Object? listening = null,Object? increment = freezed,}) {
  return _then(_FirebaseFundamentalsState(
document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as AsyncValue<Course>?,collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,validQuery: freezed == validQuery ? _self.validQuery : validQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,invalidQuery: freezed == invalidQuery ? _self.invalidQuery : invalidQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,compositeQuery: freezed == compositeQuery ? _self.compositeQuery : compositeQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,missingIndexQuery: freezed == missingIndexQuery ? _self.missingIndexQuery : missingIndexQuery // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Course>>?,nestedLessons: freezed == nestedLessons ? _self.nestedLessons : nestedLessons // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Lesson>>?,collectionGroupLessons: freezed == collectionGroupLessons ? _self.collectionGroupLessons : collectionGroupLessons // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Lesson>>?,realtime: freezed == realtime ? _self.realtime : realtime // ignore: cast_nullable_to_non_nullable
as AsyncValue<CoursesSnapshot>?,listening: null == listening ? _self.listening : listening // ignore: cast_nullable_to_non_nullable
as bool,increment: freezed == increment ? _self.increment : increment // ignore: cast_nullable_to_non_nullable
as AsyncValue<void>?,
  ));
}


}

// dart format on
