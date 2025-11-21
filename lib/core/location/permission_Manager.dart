// PermissionManager.dart
import 'package:geolocator/geolocator.dart';

class PermissionManager {
  /// 위치 권한 요청 (iOS Always까지 요청 흐름 포함)
  static Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // iOS: "앱 사용 중"만 뜨면 한 번 더 요청해야 "항상 허용" 등장
    if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }

    // 영구 거부 시 설정창으로 보내기
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
  }
}
