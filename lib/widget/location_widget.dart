import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;
  Timer? _mockTimer;

  List<Map<String, dynamic>> _mockLocations = [
    {
      'id': 'dad',
      'name': '아빠',
      'lat': 37.5700,
      'lng': 127.0090,
    },
    {
      'id': 'mom',
      'name': '엄마',
      'lat': 37.5547,
      'lng': 126.9706,
    },
    {
      'id': 'me',
      'name': '나',
      'lat': 37.5717,
      'lng': 126.9959,
    },
  ];

  final Map<String, Marker> _markerMap = {};

  @override
  void initState() {
    super.initState();
    _initLocation();
    _initializeMarkers();
    _startMockMovement();
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
  BitmapDescriptor _getMarkerColor(String id) {
    switch (id) {
      case 'dad':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'mom':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
      case 'me':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }
  }

  void _initializeMarkers() {
    for (var loc in _mockLocations) {
      final marker = Marker(
        markerId: MarkerId(loc['id']),
        position: LatLng(loc['lat'], loc['lng']),
        infoWindow: InfoWindow(title: loc['name']),
        icon: _getMarkerColor(loc['id']), // ✅ 색상 지정
      );
      _markerMap[loc['id']] = marker;
    }
  }

  void _startMockMovement() {
    const duration = Duration(seconds: 10);
    final random = Random();

    _mockTimer = Timer.periodic(duration, (timer) async {
      for (var loc in _mockLocations) {
        final newLat = loc['lat'] + (random.nextDouble() - 0.5) * 0.001;
        final newLng = loc['lng'] + (random.nextDouble() - 0.5) * 0.001;
        loc['lat'] = newLat;
        loc['lng'] = newLng;

        final oldMarker = _markerMap[loc['id']];
        if (oldMarker != null) {
          _animateMarker(loc['id'], oldMarker.position, LatLng(newLat, newLng),
              duration: const Duration(seconds: 2));
        }
      }
    });
  }

  void _animateMarker(String id, LatLng from, LatLng to,
      {required Duration duration}) async {
    const fps = 30;
    final totalFrames = (duration.inMilliseconds / (1000 / fps)).floor();
    for (int i = 0; i < totalFrames; i++) {
      await Future.delayed(Duration(milliseconds: (1000 / fps).floor()));
      final lat = from.latitude + (to.latitude - from.latitude) * (i / totalFrames);
      final lng = from.longitude + (to.longitude - from.longitude) * (i / totalFrames);
      _updateMarkerPosition(id, LatLng(lat, lng));
    }
  }

  void _updateMarkerPosition(String id, LatLng newPos) {
    final oldMarker = _markerMap[id];
    if (oldMarker != null) {
      final updatedMarker = oldMarker.copyWith(positionParam: newPos);
      setState(() {
        _markerMap[id] = updatedMarker;
      });
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
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('가족 위치 - 색상 구분')),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentPosition ?? const LatLng(37.5665, 126.9780),
            zoom: 13,
          ),
          markers: _markerMap.values.toSet(),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
        ),
      ),
    );
  }
}
