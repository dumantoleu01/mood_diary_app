// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoodEntry {

 String get id; DateTime get dateTime; MoodType get moodType; List<String> get subEmotions; int get stressLevel; int get selfEsteem; String get note;
/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodEntryCopyWith<MoodEntry> get copyWith => _$MoodEntryCopyWithImpl<MoodEntry>(this as MoodEntry, _$identity);

  /// Serializes this MoodEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&const DeepCollectionEquality().equals(other.subEmotions, subEmotions)&&(identical(other.stressLevel, stressLevel) || other.stressLevel == stressLevel)&&(identical(other.selfEsteem, selfEsteem) || other.selfEsteem == selfEsteem)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateTime,moodType,const DeepCollectionEquality().hash(subEmotions),stressLevel,selfEsteem,note);

@override
String toString() {
  return 'MoodEntry(id: $id, dateTime: $dateTime, moodType: $moodType, subEmotions: $subEmotions, stressLevel: $stressLevel, selfEsteem: $selfEsteem, note: $note)';
}


}

/// @nodoc
abstract mixin class $MoodEntryCopyWith<$Res>  {
  factory $MoodEntryCopyWith(MoodEntry value, $Res Function(MoodEntry) _then) = _$MoodEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime dateTime, MoodType moodType, List<String> subEmotions, int stressLevel, int selfEsteem, String note
});




}
/// @nodoc
class _$MoodEntryCopyWithImpl<$Res>
    implements $MoodEntryCopyWith<$Res> {
  _$MoodEntryCopyWithImpl(this._self, this._then);

  final MoodEntry _self;
  final $Res Function(MoodEntry) _then;

/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dateTime = null,Object? moodType = null,Object? subEmotions = null,Object? stressLevel = null,Object? selfEsteem = null,Object? note = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,subEmotions: null == subEmotions ? _self.subEmotions : subEmotions // ignore: cast_nullable_to_non_nullable
as List<String>,stressLevel: null == stressLevel ? _self.stressLevel : stressLevel // ignore: cast_nullable_to_non_nullable
as int,selfEsteem: null == selfEsteem ? _self.selfEsteem : selfEsteem // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodEntry].
extension MoodEntryPatterns on MoodEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodEntry value)  $default,){
final _that = this;
switch (_that) {
case _MoodEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodEntry value)?  $default,){
final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime dateTime,  MoodType moodType,  List<String> subEmotions,  int stressLevel,  int selfEsteem,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
return $default(_that.id,_that.dateTime,_that.moodType,_that.subEmotions,_that.stressLevel,_that.selfEsteem,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime dateTime,  MoodType moodType,  List<String> subEmotions,  int stressLevel,  int selfEsteem,  String note)  $default,) {final _that = this;
switch (_that) {
case _MoodEntry():
return $default(_that.id,_that.dateTime,_that.moodType,_that.subEmotions,_that.stressLevel,_that.selfEsteem,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime dateTime,  MoodType moodType,  List<String> subEmotions,  int stressLevel,  int selfEsteem,  String note)?  $default,) {final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
return $default(_that.id,_that.dateTime,_that.moodType,_that.subEmotions,_that.stressLevel,_that.selfEsteem,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoodEntry implements MoodEntry {
  const _MoodEntry({required this.id, required this.dateTime, required this.moodType, required final  List<String> subEmotions, required this.stressLevel, required this.selfEsteem, required this.note}): _subEmotions = subEmotions;
  factory _MoodEntry.fromJson(Map<String, dynamic> json) => _$MoodEntryFromJson(json);

@override final  String id;
@override final  DateTime dateTime;
@override final  MoodType moodType;
 final  List<String> _subEmotions;
@override List<String> get subEmotions {
  if (_subEmotions is EqualUnmodifiableListView) return _subEmotions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subEmotions);
}

@override final  int stressLevel;
@override final  int selfEsteem;
@override final  String note;

/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodEntryCopyWith<_MoodEntry> get copyWith => __$MoodEntryCopyWithImpl<_MoodEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoodEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.moodType, moodType) || other.moodType == moodType)&&const DeepCollectionEquality().equals(other._subEmotions, _subEmotions)&&(identical(other.stressLevel, stressLevel) || other.stressLevel == stressLevel)&&(identical(other.selfEsteem, selfEsteem) || other.selfEsteem == selfEsteem)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateTime,moodType,const DeepCollectionEquality().hash(_subEmotions),stressLevel,selfEsteem,note);

@override
String toString() {
  return 'MoodEntry(id: $id, dateTime: $dateTime, moodType: $moodType, subEmotions: $subEmotions, stressLevel: $stressLevel, selfEsteem: $selfEsteem, note: $note)';
}


}

/// @nodoc
abstract mixin class _$MoodEntryCopyWith<$Res> implements $MoodEntryCopyWith<$Res> {
  factory _$MoodEntryCopyWith(_MoodEntry value, $Res Function(_MoodEntry) _then) = __$MoodEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime dateTime, MoodType moodType, List<String> subEmotions, int stressLevel, int selfEsteem, String note
});




}
/// @nodoc
class __$MoodEntryCopyWithImpl<$Res>
    implements _$MoodEntryCopyWith<$Res> {
  __$MoodEntryCopyWithImpl(this._self, this._then);

  final _MoodEntry _self;
  final $Res Function(_MoodEntry) _then;

/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dateTime = null,Object? moodType = null,Object? subEmotions = null,Object? stressLevel = null,Object? selfEsteem = null,Object? note = null,}) {
  return _then(_MoodEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,moodType: null == moodType ? _self.moodType : moodType // ignore: cast_nullable_to_non_nullable
as MoodType,subEmotions: null == subEmotions ? _self._subEmotions : subEmotions // ignore: cast_nullable_to_non_nullable
as List<String>,stressLevel: null == stressLevel ? _self.stressLevel : stressLevel // ignore: cast_nullable_to_non_nullable
as int,selfEsteem: null == selfEsteem ? _self.selfEsteem : selfEsteem // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
