import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

class DocumentReferenceConverter implements JsonConverter<DocumentReference<Object?>?, String?> {
  const DocumentReferenceConverter();

  @override
  DocumentReference<Object?>? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return FirebaseFirestore.instance.doc(json); // Firestore의 DocumentReference로 변환
  }

  @override
  String? toJson(DocumentReference<Object?>? object) {
    return object?.path; // DocumentReference의 경로를 저장
  }
}

@freezed
class LocationModel with _$LocationModel {
  factory LocationModel({
    String? id,
    @Default('') String locationName,
    @Default('') String locationTitle,
    @Default('') String locationContent,
    DateTime? visitTime,
    @Default(35.0) double lat,
    @Default(133.0) double lng,
    String? image,
    @DocumentReferenceConverter() DocumentReference<Object?>? docRef, // JsonConverter 적용
  }) = _LocationModel;

  factory LocationModel.fromDocument(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return LocationModel(
      id: data['id'] ?? "0",
      locationName: data['locationName'] ?? '',
      locationTitle: data['locationTitle'] ?? '',
      locationContent: data['locationContent'] ?? '',
      visitTime: (data['visitTime'] as Timestamp?)?.toDate(),
      lat: data['lat'] ?? 35.0,
      lng: data['lng'] ?? 133.0,
      image: data['image'] ?? '',
      docRef: doc.reference,
    );
  }



  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}

extension LocationModelExtension on LocationModel {
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'locationName': locationName,
      'locationTitle' : locationTitle,
      'locationContent': locationContent,
      'lat': lat,
      'lng': lng,
      'image': image,
      'visitTime': visitTime,
      'docRef': docRef?.path,
    };
  }
}