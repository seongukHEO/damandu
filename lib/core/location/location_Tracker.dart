// LocationTracker.dart
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationTracker {
  static StreamSubscription<Position>? _positionStream;

  /// 백그라운드 위치 추적 시작
  static void startTracking(Function(Position) onLocationUpdated) {
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // 10m 이동 시 업데이트
    );

    _positionStream = Geolocator.getPositionStream(
      locationSettings: settings,
    ).listen((Position pos) {
      onLocationUpdated(pos);
    });
  }

  /// 위치 추적 종료
  static void stopTracking() {
    _positionStream?.cancel();
  }
}
