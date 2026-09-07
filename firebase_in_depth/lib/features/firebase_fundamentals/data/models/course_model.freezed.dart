// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseModel {

 String get id; String get description; String get longDescription; String get url; int get seqNo; int get lessonsCount; int get price; List<String> get categories; String get icon; TutorModel get tutor; int get participants;
/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseModelCopyWith<CourseModel> get copyWith => _$CourseModelCopyWithImpl<CourseModel>(this as CourseModel, _$identity);

  /// Serializes this CourseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CourseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.longDescription, _this.longDescription) || other.longDescription == _this.longDescription)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.seqNo, _this.seqNo) || other.seqNo == _this.seqNo)&&(identical(other.lessonsCount, _this.lessonsCount) || other.lessonsCount == _this.lessonsCount)&&(identical(other.price, _this.price) || other.price == _this.price)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.tutor, _this.tutor) || other.tutor == _this.tutor)&&(identical(other.participants, _this.participants) || other.participants == _this.participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CourseModel;
  return Object.hash(runtimeType,_this.id,_this.description,_this.longDescription,_this.url,_this.seqNo,_this.lessonsCount,_this.price,const DeepCollectionEquality().hash(_this.categories),_this.icon,_this.tutor,_this.participants);
}

@override
String toString() {
  final _this = this as CourseModel;
  return 'CourseModel(id: ${_this.id}, description: ${_this.description}, longDescription: ${_this.longDescription}, url: ${_this.url}, seqNo: ${_this.seqNo}, lessonsCount: ${_this.lessonsCount}, price: ${_this.price}, categories: ${_this.categories}, icon: ${_this.icon}, tutor: ${_this.tutor}, participants: ${_this.participants})';
}


}

/// @nodoc
abstract mixin class $CourseModelCopyWith<$Res>  {
  factory $CourseModelCopyWith(CourseModel value, $Res Function(CourseModel) _then) = _$CourseModelCopyWithImpl;
@useResult
$Res call({
 String id, String description, String longDescription, String url, int seqNo, int lessonsCount, int price, List<String> categories, String icon, TutorModel tutor, int participants
});


$TutorModelCopyWith<$Res> get tutor;

}
/// @nodoc
class _$CourseModelCopyWithImpl<$Res>
    implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._self, this._then);

  final CourseModel _self;
  final $Res Function(CourseModel) _then;

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? longDescription = null,Object? url = null,Object? seqNo = null,Object? lessonsCount = null,Object? price = null,Object? categories = null,Object? icon = null,Object? tutor = null,Object? participants = null,}) {
  return _then(CourseModel(
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
as TutorModel,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TutorModelCopyWith<$Res> get tutor {
  
  return $TutorModelCopyWith<$Res>(_self.tutor, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}
}


/// Adds pattern-matching-related methods to [CourseModel].
extension CourseModelPatterns on CourseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseModel value)  $default,){
final _that = this;
switch (_that) {
case _CourseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  String longDescription,  String url,  int seqNo,  int lessonsCount,  int price,  List<String> categories,  String icon,  TutorModel tutor,  int participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
return $default(_that.id,_that.description,_that.longDescription,_that.url,_that.seqNo,_that.lessonsCount,_that.price,_that.categories,_that.icon,_that.tutor,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  String longDescription,  String url,  int seqNo,  int lessonsCount,  int price,  List<String> categories,  String icon,  TutorModel tutor,  int participants)  $default,) {final _that = this;
switch (_that) {
case _CourseModel():
return $default(_that.id,_that.description,_that.longDescription,_that.url,_that.seqNo,_that.lessonsCount,_that.price,_that.categories,_that.icon,_that.tutor,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  String longDescription,  String url,  int seqNo,  int lessonsCount,  int price,  List<String> categories,  String icon,  TutorModel tutor,  int participants)?  $default,) {final _that = this;
switch (_that) {
case _CourseModel() when $default != null:
return $default(_that.id,_that.description,_that.longDescription,_that.url,_that.seqNo,_that.lessonsCount,_that.price,_that.categories,_that.icon,_that.tutor,_that.participants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseModel implements CourseModel {
  const _CourseModel({required this.id, required this.description, required this.longDescription, required this.url, required this.seqNo, required this.lessonsCount, required this.price, required  List<String> categories, required this.icon, required this.tutor, this.participants = 0}): _categories = categories;
  factory _CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);

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
@override final  TutorModel tutor;
@override@JsonKey() final  int participants;

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseModelCopyWith<_CourseModel> get copyWith => __$CourseModelCopyWithImpl<_CourseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.longDescription, longDescription) || other.longDescription == longDescription)&&(identical(other.url, url) || other.url == url)&&(identical(other.seqNo, seqNo) || other.seqNo == seqNo)&&(identical(other.lessonsCount, lessonsCount) || other.lessonsCount == lessonsCount)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other.categories, _categories)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.tutor, tutor) || other.tutor == tutor)&&(identical(other.participants, participants) || other.participants == participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,description,longDescription,url,seqNo,lessonsCount,price,const DeepCollectionEquality().hash(_categories),icon,tutor,participants);
}

@override
String toString() {
    return 'CourseModel(id: $id, description: $description, longDescription: $longDescription, url: $url, seqNo: $seqNo, lessonsCount: $lessonsCount, price: $price, categories: $categories, icon: $icon, tutor: $tutor, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$CourseModelCopyWith<$Res> implements $CourseModelCopyWith<$Res> {
  factory _$CourseModelCopyWith(_CourseModel value, $Res Function(_CourseModel) _then) = __$CourseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, String longDescription, String url, int seqNo, int lessonsCount, int price, List<String> categories, String icon, TutorModel tutor, int participants
});


@override $TutorModelCopyWith<$Res> get tutor;

}
/// @nodoc
class __$CourseModelCopyWithImpl<$Res>
    implements _$CourseModelCopyWith<$Res> {
  __$CourseModelCopyWithImpl(this._self, this._then);

  final _CourseModel _self;
  final $Res Function(_CourseModel) _then;

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? longDescription = null,Object? url = null,Object? seqNo = null,Object? lessonsCount = null,Object? price = null,Object? categories = null,Object? icon = null,Object? tutor = null,Object? participants = null,}) {
  return _then(_CourseModel(
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
as TutorModel,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CourseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TutorModelCopyWith<$Res> get tutor {
  
  return $TutorModelCopyWith<$Res>(_self.tutor, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}
}

// dart format on
