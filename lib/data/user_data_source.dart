import 'package:cloud_firestore/cloud_firestore.dart';

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
}