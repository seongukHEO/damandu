import 'package:damandu/data/user_data_source.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import '../model/user_model.dart';

class LocationWidget extends ConsumerStatefulWidget {
  const LocationWidget({super.key});

  @override
  ConsumerState<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends ConsumerState<LocationWidget> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;

  // ✅ 파베 데이터 관리용
  final Map<String, Marker> _markerMap = {};
  final int myId = 1; // SharedPreferences로 교체 예정
  late final Stream<List<UserModel>> _userStream;

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
  BitmapDescriptor _getMarkerColor(int id) {
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
      appBar: AppBar(title: const Text('가족 위치 - 실시간')),
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

            for (var user in users) {
              final marker = Marker(
                markerId: MarkerId(user.id.toString()),
                position: LatLng(user.lat, user.lng),
                infoWindow: InfoWindow(title: user.name),
                icon: _getMarkerColor(user.id),
              );
              _markerMap[user.id.toString()] = marker;
            }

            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? const LatLng(37.5665, 126.9780),
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
