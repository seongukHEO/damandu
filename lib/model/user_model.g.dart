// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '이름 없음',
      lat: (json['lat'] as num?)?.toDouble() ?? 35.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 133.0,
      update_time: json['update_time'] == null
          ? null
          : DateTime.parse(json['update_time'] as String),
      usable: json['usable'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'update_time': instance.update_time?.toIso8601String(),
      'usable': instance.usable,
    };
