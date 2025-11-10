import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    @Default(0) int id,
    @Default('이름 없음') String name,
    @Default(35.0) double lat,
    @Default(133.0) double lng,
    DateTime? update_time,
    @Default(true) bool usable
  }) = _UserModel;

  factory UserModel.fromDocument(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      lat: data['lat'] ?? 35.0,
      lng: data['lng'] ?? 133.0,
      update_time: (data['update_time'] as Timestamp?)?.toDate(),
      usable: data['usable'] ?? true,

    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}