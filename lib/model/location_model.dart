import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  factory LocationModel({
    int? id,
    @Default('') String locationName,
    @Default('') String locationTitle,
    @Default('') String locationContent,
    DateTime? visitTime,
    @Default(35.0) double lat,
    @Default(133.0) double lng,
    String? image
  }) = _LocationModel;

  factory LocationModel.fromDocument(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return LocationModel(
      id: data['id'] ?? 0,
      locationName: data['locationName'] ?? '',
      locationTitle: data['locationTitle'] ?? '',
      locationContent: data['locationContent'] ?? '',
      visitTime: (data['visitTime'] as Timestamp?)?.toDate(),
      lat: data['lat'] ?? 35.0,
      lng: data['lng'] ?? 133.0,
      image: data['image'] ?? '',
    );
  }



  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}