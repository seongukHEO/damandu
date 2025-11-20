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

  // ✅ 클릭된 마커 ID 저장
  String? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _userStream = UserDataSource(FirebaseFirestore.instance).streamOtherUsers();
  }

  Future<void> _initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);
      _isLoading = false;
    });
  }

  /// ✅ id별 색상 지정
  BitmapDescriptor _getMarkerColor(int id, {bool selected = false}) {
    if (selected) {
      // 클릭 시 더 진한 색상
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
      body: SafeArea(
        child: FutureBuilder<List<LocationModel>>(
          future: ref.watch(userDataSourceProvider).fetchLocations(),
          builder: (context, locationSnapshot) {

            // ⛔ 로딩
            if (!locationSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final locations = locationSnapshot.data!;

            // ✅ DB location 로드 후 → 유저 스트림 로드
            return StreamBuilder<List<UserModel>>(
              stream: _userStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!;
                _markerMap.clear();

                // 1️⃣ 사용자 마커
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

                // 2️⃣ 🔥 Firestore location 마커 찍기
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

}

