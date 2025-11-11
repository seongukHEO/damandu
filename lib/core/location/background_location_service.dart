// import 'dart:async';
// import 'dart:io';
// import 'package:background_locator_2/background_locator.dart';
// import 'package:background_locator_2/location_dto.dart';
// import 'package:background_locator_2/settings/android_settings.dart';
// import 'package:background_locator_2/settings/ios_settings.dart';
// import 'package:background_locator_2/settings/locator_settings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart' as geo;
//
// import 'background_callback_handler.dart';
//
//
// class BackgroundLocationService {
//   StreamSubscription<geo.Position>? _positionSub;
//   bool _isRunning = false;
//
//   Future<void> start(String userId) async {
//     if (_isRunning) return;
//     _isRunning = true;
//
//     if (Platform.isAndroid) {
//       await _startAndroid(userId);
//     } else if (Platform.isIOS) {
//       await _startIOS(userId);
//     }
//   }
//
//   Future<void> _startAndroid(String userId) async {
//     await BackgroundLocator.initialize();
//
//     BackgroundLocator.registerLocationUpdate(
//       LocationCallbackHandler.callback,
//       initCallback: LocationCallbackHandler.initCallback,
//       disposeCallback: LocationCallbackHandler.disposeCallback,
//       autoStop: false,
//       initDataCallback: {'userId': userId},
//       // ⬇️ 요렇게, settings: 래퍼 없이 바로 넣어야 함
//       androidSettings: const AndroidSettings(
//         accuracy: LocationAccuracy.NAVIGATION,
//         distanceFilter: 0,           // 움직임 감지 민감도
//         wakeLockTime: 60,
//         androidNotificationSettings: AndroidNotificationSettings(
//           notificationChannelName: 'Location tracking',
//           notificationTitle: 'Weavo 위치 공유 중',
//           notificationMsg: '가족 위치를 실시간으로 업데이트합니다.',
//           notificationIcon: '',      // 필요하면 아이콘 지정
//         ),
//       ),
//       iosSettings: const IOSSettings(
//         accuracy: LocationAccuracy.NAVIGATION,
//         distanceFilter: 0,
//       ),
//     );
//
//     print('✅ Android 백그라운드 위치 추적 시작');
//   }
//
//   Future<void> _startIOS(String userId) async {
//     final permission = await geo.Geolocator.requestPermission();
//     if (permission == geo.LocationPermission.denied ||
//         permission == geo.LocationPermission.deniedForever) {
//       print('❌ iOS 위치 권한 거부됨');
//       return;
//     }
//
//     const settings = geo.LocationSettings(
//       accuracy: geo.LocationAccuracy.best,
//       distanceFilter: 10,
//     );
//
//     _positionSub?.cancel();
//     _positionSub = geo.Geolocator.getPositionStream(locationSettings: settings)
//         .listen((pos) async {
//       await FirebaseFirestore.instance.collection('user').doc(userId).update({
//         'lat': pos.latitude,
//         'lng': pos.longitude,
//         'update_time': FieldValue.serverTimestamp(),
//       });
//     });
//
//     print('✅ iOS 움직임 감지 기반 위치 추적 시작');
//   }
//
//   Future<void> stop() async {
//     if (!_isRunning) return;
//     _isRunning = false;
//
//     if (Platform.isAndroid) {
//       await BackgroundLocator.unRegisterLocationUpdate();
//       print('🛑 Android 위치 추적 중지');
//     } else if (Platform.isIOS) {
//       await _positionSub?.cancel();
//       print('🛑 iOS 위치 추적 중지');
//     }
//   }
// }
//
// final backgroundLocationService = BackgroundLocationService();
