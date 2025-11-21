import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damandu/common/app_images.dart';
import 'package:damandu/data/user_data_source.dart';
import 'package:damandu/provider/home/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import '../core/location/location_Tracker.dart';
import '../core/location/permission_Manager.dart';
import '../model/location_model.dart';
import '../model/user_model.dart';
import 'bottomSheet/fixed_marker_bottom_sheet.dart';



class LocationWidget extends ConsumerStatefulWidget {
  const LocationWidget({super.key});

  @override
  ConsumerState<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends ConsumerState<LocationWidget> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;

  final Map<String, Marker> _markerMap = {};
  late final Stream<List<UserModel>> _userStream;

  String? _selectedMarkerId;

  // 🔥 새로운 추가: 백그라운드 위치 스트림을 시작/정지하는 상태
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();

    PermissionManager.requestLocationPermission();
    _initLocation();
    _userStream = UserDataSource(FirebaseFirestore.instance).streamOtherUsers();

    // 🔥 앱 켜지면 자동 추적 시작
    _startLocationSharing();
  }

  // 현재 위치 가져오기
  Future<void> _initLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);
      _isLoading = false;
    });
  }

  /// 🔥 백그라운드 위치 추적 시작
  void _startLocationSharing() {
    if (_isTracking) return;

    LocationTracker.startTracking((Position pos) {
      print("📍 새로운 위치: ${pos.latitude}, ${pos.longitude}");

      // 필요하면 Firestore 전송 영역
      // FirebaseFirestore.instance.collection("locations").add({
      //   "lat": pos.latitude,
      //   "lng": pos.longitude,
      //   "updatedAt": FieldValue.serverTimestamp(),
      // });

      setState(() {
        _currentPosition = LatLng(pos.latitude, pos.longitude);
      });
    });

    setState(() => _isTracking = true);
  }

  /// 위치 공유 종료
  void _stopLocationSharing() {
    LocationTracker.stopTracking();
    setState(() => _isTracking = false);
  }

  BitmapDescriptor _getMarkerColor(int id, {bool selected = false}) {
    if (selected) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    }
    switch (id) {
      case 1:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 2:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
      case 3:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 4:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentPosition != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 13),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: _buildFloatingButtons(),
      body: SafeArea(
        child: FutureBuilder<List<LocationModel>>(
          future: ref.watch(userDataSourceProvider).fetchLocations(),
          builder: (context, locationSnapshot) {
            if (!locationSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final locations = locationSnapshot.data!;

            return StreamBuilder<List<UserModel>>(
              stream: _userStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!;
                _markerMap.clear();

                // -----------------------------------
                // 1️⃣ 가족/사용자 위치 마커
                // -----------------------------------
                for (var user in users) {
                  final isSelected = _selectedMarkerId == 'user_${user.id}';

                  final marker = Marker(
                    markerId: MarkerId('user_${user.id}'),
                    position: LatLng(user.lat, user.lng),
                    infoWindow: InfoWindow(title: user.name),
                    icon: _getMarkerColor(user.id, selected: isSelected),
                    onTap: () {
                      setState(() => _selectedMarkerId = 'user_${user.id}');
                    },
                  );

                  _markerMap['user_${user.id}'] = marker;
                }

                // -----------------------------------
                // 2️⃣ Firestore에서 저장된 고정 위치 마커
                // -----------------------------------
                for (var loc in locations) {
                  final markerId = 'loc_${loc.lat}_${loc.lng}';

                  final marker = Marker(
                    markerId: MarkerId(markerId),
                    position: LatLng(loc.lat, loc.lng),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => FixedMarkerBottomSheet(
                          locationModel: loc,
                        ),
                      );
                    },
                  );

                  _markerMap[markerId] = marker;
                }

                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition ??
                        const LatLng(37.5665, 126.9780),
                    zoom: 13,
                  ),
                  markers: _markerMap.values.toSet(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                );
              },
            );
          },
        ),
      ),
    );
  }

  // /// 🔥 위치 공유 시작/중지 버튼
  // Widget _buildFloatingButtons() {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       FloatingActionButton(
  //         backgroundColor: Colors.green,
  //         heroTag: "start",
  //         child: const Icon(Icons.play_arrow),
  //         onPressed: _startLocationSharing,
  //       ),
  //       const SizedBox(height: 10),
  //       FloatingActionButton(
  //         backgroundColor: Colors.red,
  //         heroTag: "stop",
  //         child: const Icon(Icons.stop),
  //         onPressed: _stopLocationSharing,
  //       ),
  //     ],
  //   );
  // }
}
