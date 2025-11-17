import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damandu/model/location_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_model.dart';

class UserDataSource {
  final _firestore = FirebaseFirestore.instance;

  /// 🔹 나(myId)를 제외한 모든 유저의 실시간 위치 스트림
  Stream<List<UserModel>> streamOtherUsers(int myId) {
    return _firestore.collection('user').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromDocument(doc))
          .where((user) => user.id != myId) // ✅ 내 id 제외
          .toList();
    });
  }

  Future<void>addPost(LocationModel locationModel)async{
    final docRef = _firestore.collection('location').doc();
    final postModelInfo = locationModel.copyWith(docRef: docRef);

    await docRef.set(postModelInfo.toFirestore());
  }


  //이미지 저장
  Future<String>uploadPostImageList(File image, String postUid, int index)async{
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'location/$postUid/image_$index.jpg');
      await storageRef.putFile(image);

      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    }catch(e){
      throw e;
    }
  }

}