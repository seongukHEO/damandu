// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return _LocationModel.fromJson(json);
}

/// @nodoc
mixin _$LocationModel {
  String? get id => throw _privateConstructorUsedError;
  String get locationName => throw _privateConstructorUsedError;
  String get locationTitle => throw _privateConstructorUsedError;
  String get locationContent => throw _privateConstructorUsedError;
  DateTime? get visitTime => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @DocumentReferenceConverter()
  DocumentReference<Object?>? get docRef => throw _privateConstructorUsedError;

  /// Serializes this LocationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationModelCopyWith<LocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationModelCopyWith<$Res> {
  factory $LocationModelCopyWith(
    LocationModel value,
    $Res Function(LocationModel) then,
  ) = _$LocationModelCopyWithImpl<$Res, LocationModel>;
  @useResult
  $Res call({
    String? id,
    String locationName,
    String locationTitle,
    String locationContent,
    DateTime? visitTime,
    double lat,
    double lng,
    String? image,
    @DocumentReferenceConverter() DocumentReference<Object?>? docRef,
  });
}

/// @nodoc
class _$LocationModelCopyWithImpl<$Res, $Val extends LocationModel>
    implements $LocationModelCopyWith<$Res> {
  _$LocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? locationName = null,
    Object? locationTitle = null,
    Object? locationContent = null,
    Object? visitTime = freezed,
    Object? lat = null,
    Object? lng = null,
    Object? image = freezed,
    Object? docRef = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationName: null == locationName
                ? _value.locationName
                : locationName // ignore: cast_nullable_to_non_nullable
                      as String,
            locationTitle: null == locationTitle
                ? _value.locationTitle
                : locationTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            locationContent: null == locationContent
                ? _value.locationContent
                : locationContent // ignore: cast_nullable_to_non_nullable
                      as String,
            visitTime: freezed == visitTime
                ? _value.visitTime
                : visitTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            docRef: freezed == docRef
                ? _value.docRef
                : docRef // ignore: cast_nullable_to_non_nullable
                      as DocumentReference<Object?>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationModelImplCopyWith<$Res>
    implements $LocationModelCopyWith<$Res> {
  factory _$$LocationModelImplCopyWith(
    _$LocationModelImpl value,
    $Res Function(_$LocationModelImpl) then,
  ) = __$$LocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String locationName,
    String locationTitle,
    String locationContent,
    DateTime? visitTime,
    double lat,
    double lng,
    String? image,
    @DocumentReferenceConverter() DocumentReference<Object?>? docRef,
  });
}

/// @nodoc
class __$$LocationModelImplCopyWithImpl<$Res>
    extends _$LocationModelCopyWithImpl<$Res, _$LocationModelImpl>
    implements _$$LocationModelImplCopyWith<$Res> {
  __$$LocationModelImplCopyWithImpl(
    _$LocationModelImpl _value,
    $Res Function(_$LocationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? locationName = null,
    Object? locationTitle = null,
    Object? locationContent = null,
    Object? visitTime = freezed,
    Object? lat = null,
    Object? lng = null,
    Object? image = freezed,
    Object? docRef = freezed,
  }) {
    return _then(
      _$LocationModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationName: null == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                  as String,
        locationTitle: null == locationTitle
            ? _value.locationTitle
            : locationTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        locationContent: null == locationContent
            ? _value.locationContent
            : locationContent // ignore: cast_nullable_to_non_nullable
                  as String,
        visitTime: freezed == visitTime
            ? _value.visitTime
            : visitTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        docRef: freezed == docRef
            ? _value.docRef
            : docRef // ignore: cast_nullable_to_non_nullable
                  as DocumentReference<Object?>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationModelImpl implements _LocationModel {
  _$LocationModelImpl({
    this.id,
    this.locationName = '',
    this.locationTitle = '',
    this.locationContent = '',
    this.visitTime,
    this.lat = 35.0,
    this.lng = 133.0,
    this.image,
    @DocumentReferenceConverter() this.docRef,
  });

  factory _$LocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final String locationName;
  @override
  @JsonKey()
  final String locationTitle;
  @override
  @JsonKey()
  final String locationContent;
  @override
  final DateTime? visitTime;
  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double lng;
  @override
  final String? image;
  @override
  @DocumentReferenceConverter()
  final DocumentReference<Object?>? docRef;

  @override
  String toString() {
    return 'LocationModel(id: $id, locationName: $locationName, locationTitle: $locationTitle, locationContent: $locationContent, visitTime: $visitTime, lat: $lat, lng: $lng, image: $image, docRef: $docRef)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationTitle, locationTitle) ||
                other.locationTitle == locationTitle) &&
            (identical(other.locationContent, locationContent) ||
                other.locationContent == locationContent) &&
            (identical(other.visitTime, visitTime) ||
                other.visitTime == visitTime) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.docRef, docRef) || other.docRef == docRef));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    locationName,
    locationTitle,
    locationContent,
    visitTime,
    lat,
    lng,
    image,
    docRef,
  );

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationModelImplCopyWith<_$LocationModelImpl> get copyWith =>
      __$$LocationModelImplCopyWithImpl<_$LocationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationModelImplToJson(this);
  }
}

abstract class _LocationModel implements LocationModel {
  factory _LocationModel({
    final String? id,
    final String locationName,
    final String locationTitle,
    final String locationContent,
    final DateTime? visitTime,
    final double lat,
    final double lng,
    final String? image,
    @DocumentReferenceConverter() final DocumentReference<Object?>? docRef,
  }) = _$LocationModelImpl;

  factory _LocationModel.fromJson(Map<String, dynamic> json) =
      _$LocationModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get locationName;
  @override
  String get locationTitle;
  @override
  String get locationContent;
  @override
  DateTime? get visitTime;
  @override
  double get lat;
  @override
  double get lng;
  @override
  String? get image;
  @override
  @DocumentReferenceConverter()
  DocumentReference<Object?>? get docRef;

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationModelImplCopyWith<_$LocationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
