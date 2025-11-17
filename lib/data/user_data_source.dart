import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damandu/model/location_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_model.dart';

class UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSource(this.firestore);

  /// 🔹 나(myId)를 제외한 모든 유저의 실시간 위치 스트림
  Stream<List<UserModel>> streamOtherUsers(int myId) {
    return firestore.collection('user').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromDocument(doc))
          .where((user) => user.id != myId) // ✅ 내 id 제외
          .toList();
    });
  }

  Future<void>addPost(LocationModel locationModel)async{
    final docRef = firestore.collection('location').doc();
    final postModelInfo = locationModel.copyWith(docRef: docRef);

    await docRef.set(postModelInfo.toFirestore());
  }


  //이미지 저장
  Future<String>uploadPostImageList(File image, String postUid)async{
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'location/$postUid/image_$postUid.jpg');
      await storageRef.putFile(image);

      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    }catch(e){
      throw e;
    }
  }

  /// 🔹 선택한 날짜(visitTime 기준)에 해당하는 location 문서들만 불러오기
  Future<List<LocationModel>> fetchLocationsByDate(DateTime selectedDate) async {
    final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await FirebaseFirestore.instance
        .collection('location')
        .where('visitTime', isGreaterThanOrEqualTo: startOfDay)
        .where('visitTime', isLessThan: endOfDay)
        .orderBy('visitTime', descending: false)
        .get();

    final locations = snapshot.docs
        .map((doc) => LocationModel.fromDocument(doc))
        .toList();

    return locations;
  }


}