// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Course {

 String get id; String get description; String get longDescription; String get url; int get seqNo; int get lessonsCount; int get price; List<String> get categories; String get icon; Tutor get tutor;
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseCopyWith<Course> get copyWith => _$CourseCopyWithImpl<Course>(this as Course, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Course;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Course&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.longDescription, _this.longDescription) || other.longDescription == _this.longDescription)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.seqNo, _this.seqNo) || other.seqNo == _this.seqNo)&&(identical(other.lessonsCount, _this.lessonsCount) || other.lessonsCount == _this.lessonsCount)&&(identical(other.price, _this.price) || other.price == _this.price)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.tutor, _this.tutor) || other.tutor == _this.tutor));
}


@override
int get hashCode {
  final _this = this as Course;
  return Object.hash(runtimeType,_this.id,_this.description,_this.longDescription,_this.url,_this.seqNo,_this.lessonsCount,_this.price,const DeepCollectionEquality().hash(_this.categories),_this.icon,_this.tutor);
}

@override
String toString() {
  final _this = this as Course;
  return 'Course(id: ${_this.id}, description: ${_this.description}, longDescription: ${_this.longDescription}, url: ${_this.url}, seqNo: ${_this.seqNo}, lessonsCount: ${_this.lessonsCount}, price: ${_this.price}, categories: ${_this.categories}, icon: ${_this.icon}, tutor: ${_this.tutor})';
}


}

/// @nodoc
abstract mixin class $CourseCopyWith<$Res>  {
  factory $CourseCopyWith(Course value, $Res Function(Course) _then) = _$CourseCopyWithImpl;
@useResult
$Res call({
 String id, String description, String longDescription, String url, int seqNo, int lessonsCount, int price, List<String> categories, String icon, Tutor tutor
});


$TutorCopyWith<$Res> get tutor;

}
/// @nodoc
class _$CourseCopyWithImpl<$Res>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._self, this._then);

  final Course _self;
  final $Res Function(Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? longDescription = null,Object? url = null,Object? seqNo = null,Object? lessonsCount = null,Object? price = null,Object? categories = null,Object? icon = null,Object? tutor = null,}) {
  return _then(Course(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,longDescription: null == longDescription ? _self.longDescription : longDescription // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,seqNo: null == seqNo ? _self.seqNo : seqNo // ignore: cast_nullable_to_non_nullable
as int,lessonsCount: null == lessonsCount ? _self.lessonsCount : lessonsCount // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tutor: null == tutor ? _self.tutor : tutor // ignore: cast_nullable_to_non_nullable
as Tutor,
  ));
}
/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TutorCopyWith<$Res> get tutor {
  
  return $TutorCopyWith<$Res>(_self.tutor, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}
}


/// Adds pattern-matching-related methods to [Course].
extension CoursePatterns on Course {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Course value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Course value)  $default,){
final _that = this;
switch (_that) {
case _Course():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Course value)?  $default,){
final _that = this;
switch (_that) {
case _Course() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  String longDescription,  String url,  int seqNo,  int lessonsCount,  int price,  List<String> categories,  String icon,  Tutor tutor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.id,_that.description,_that.longDescription,_that.url,_that.seqNo,_that.lessonsCount,_that.price,_that.categories,_that.icon,_that.tutor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  String longDescription,  String url,  int seqNo,  int lessonsCount,  int price,  List<String> categories,  String icon,  Tutor tutor)  $default,) {final _that = this;
switch (_that) {
case _Course():
return $default(_that.id,_that.description,_that.longDescription,_that.url,_that.seqNo,_that.lessonsCount,_that.price,_that.categories,_that.icon,_that.tutor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  String longDescription,  String url,  int seqNo,  int lessonsCount,  int price,  List<String> categories,  String icon,  Tutor tutor)?  $default,) {final _that = this;
switch (_that) {
case _Course() when $default != null:
return $default(_that.id,_that.description,_that.longDescription,_that.url,_that.seqNo,_that.lessonsCount,_that.price,_that.categories,_that.icon,_that.tutor);case _:
  return null;

}
}

}

/// @nodoc


class _Course implements Course {
  const _Course({required this.id, required this.description, required this.longDescription, required this.url, required this.seqNo, required this.lessonsCount, required this.price, required  List<String> categories, required this.icon, required this.tutor}): _categories = categories;
  

@override final  String id;
@override final  String description;
@override final  String longDescription;
@override final  String url;
@override final  int seqNo;
@override final  int lessonsCount;
@override final  int price;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String icon;
@override final  Tutor tutor;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseCopyWith<_Course> get copyWith => __$CourseCopyWithImpl<_Course>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Course&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.longDescription, longDescription) || other.longDescription == longDescription)&&(identical(other.url, url) || other.url == url)&&(identical(other.seqNo, seqNo) || other.seqNo == seqNo)&&(identical(other.lessonsCount, lessonsCount) || other.lessonsCount == lessonsCount)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other.categories, _categories)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.tutor, tutor) || other.tutor == tutor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,description,longDescription,url,seqNo,lessonsCount,price,const DeepCollectionEquality().hash(_categories),icon,tutor);
}

@override
String toString() {
    return 'Course(id: $id, description: $description, longDescription: $longDescription, url: $url, seqNo: $seqNo, lessonsCount: $lessonsCount, price: $price, categories: $categories, icon: $icon, tutor: $tutor)';
}


}

/// @nodoc
abstract mixin class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) _then) = __$CourseCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, String longDescription, String url, int seqNo, int lessonsCount, int price, List<String> categories, String icon, Tutor tutor
});


@override $TutorCopyWith<$Res> get tutor;

}
/// @nodoc
class __$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(this._self, this._then);

  final _Course _self;
  final $Res Function(_Course) _then;

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? longDescription = null,Object? url = null,Object? seqNo = null,Object? lessonsCount = null,Object? price = null,Object? categories = null,Object? icon = null,Object? tutor = null,}) {
  return _then(_Course(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,longDescription: null == longDescription ? _self.longDescription : longDescription // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,seqNo: null == seqNo ? _self.seqNo : seqNo // ignore: cast_nullable_to_non_nullable
as int,lessonsCount: null == lessonsCount ? _self.lessonsCount : lessonsCount // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,tutor: null == tutor ? _self.tutor : tutor // ignore: cast_nullable_to_non_nullable
as Tutor,
  ));
}

/// Create a copy of Course
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TutorCopyWith<$Res> get tutor {
  
  return $TutorCopyWith<$Res>(_self.tutor, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}
}

// dart format on
