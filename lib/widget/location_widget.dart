import 'package:damandu/common/app_images.dart';
import 'package:damandu/data/user_data_source.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
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
  final int myId = 1; // SharedPreferences로 교체 예정
  late final Stream<List<UserModel>> _userStream;

  // ✅ 클릭된 마커 ID 저장
  String? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _userStream = UserDataSource().streamOtherUsers(myId);
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

  final List<Map<String, dynamic>> fixedMarkers = [
    {
      "id": 5,
      "name": '만두',
      "info": "D동 계단",
      'x': 37.57045463,
      'y': 126.99213429,
      "image": ''
    },
    {
      "id": 6,
      "name": '대만',
      "info": "D동 화장실",
      'x': 37.567191,
      'y': 127.010490,
      "image": ''
    },
    {
      "id": 7,
      "name": '일갑자찬음',
      "info": "월요일 오전 10시에 방문할 핵 존맛 만두가게",
      'x': 37.48502640,
      'y': 127.01627176,
      "image": ''
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : StreamBuilder<List<UserModel>>(
          stream: _userStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final users = snapshot.data!;
            _markerMap.clear();

            // ✅ 1️⃣ Firebase 사용자 마커 추가
            for (var user in users) {
              final isSelected =
                  _selectedMarkerId == 'user_${user.id}';
              final marker = Marker(
                markerId: MarkerId('user_${user.id}'),
                position: LatLng(user.lat, user.lng),
                infoWindow: InfoWindow(title: user.name),
                icon:
                _getMarkerColor(user.id, selected: isSelected),
                onTap: () {
                  setState(() {
                    _selectedMarkerId = 'user_${user.id}';
                  });
                },
              );
              _markerMap['user_${user.id}'] = marker;
            }

            // ✅ 2️⃣ 고정 마커 추가
            for (var fm in fixedMarkers) {
              final id = fm['id'];
              final isSelected = _selectedMarkerId == 'fixed_$id';
              final marker = Marker(
                markerId: MarkerId('fixed_$id'),
                position: LatLng(fm['x'], fm['y']),
                icon: isSelected
                    ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet)
                    : BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueYellow),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => FixedMarkerBottomSheet(
                      fixedName: fm['name'],
                      content: fm['info'],
                      imageUrl: AppImages.mokup1,
                    ),
                  );
                },
              );
              _markerMap['fixed_$id'] = marker;
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
        ),
      ),
    );
  }
}

