import 'package:background_locator_2/location_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationCallbackHandler {
  static Future<void> callback(LocationDto locationDto) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc('1') // TODO: SharedPreferences 등으로 userId 받아서 대체
          .update({
        'lat': locationDto.latitude,
        'lng': locationDto.longitude,
        'update_time': FieldValue.serverTimestamp(),
      });

      print('📍 위치 업데이트: ${locationDto.latitude}, ${locationDto.longitude}');
    } catch (e) {
      print('❌ Firestore 업데이트 오류: $e');
    }
  }

  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    print('📲 Background Locator 초기화 완료');
  }

  static Future<void> disposeCallback() async {
    print('🛑 Background Locator 종료');
  }
}


