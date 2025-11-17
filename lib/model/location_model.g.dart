// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      id: json['id'] as String?,
      locationName: json['locationName'] as String? ?? '',
      locationTitle: json['locationTitle'] as String? ?? '',
      locationContent: json['locationContent'] as String? ?? '',
      visitTime: json['visitTime'] == null
          ? null
          : DateTime.parse(json['visitTime'] as String),
      lat: (json['lat'] as num?)?.toDouble() ?? 35.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 133.0,
      image: json['image'] as String?,
      docRef: const DocumentReferenceConverter().fromJson(
        json['docRef'] as String?,
      ),
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationName': instance.locationName,
      'locationTitle': instance.locationTitle,
      'locationContent': instance.locationContent,
      'visitTime': instance.visitTime?.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
      'image': instance.image,
      'docRef': const DocumentReferenceConverter().toJson(instance.docRef),
    };
