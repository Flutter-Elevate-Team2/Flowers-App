import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:permission_handler/permission_handler.dart';

class MapLocationPicker extends StatefulWidget {
  final double initialLat;
  final double initialLong;

  const MapLocationPicker({
    super.key,
    this.initialLat = 30.0444, // Default to Cairo
    this.initialLong = 31.2357,
  });

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  bool? _isGmsAvailable;

  // Result
  late double selectedLat;
  late double selectedLong;

  // Mapbox Controller
  mapbox.MapboxMap? _mapboxMap;

  @override
  void initState() {
    super.initState();
    selectedLat = widget.initialLat;
    selectedLong = widget.initialLong;
    _checkGmsAvailability();
  }

  Future<void> _checkGmsAvailability() async {
    await Permission.location.request();

    if (Platform.isIOS) {
      setState(() {
        _isGmsAvailable = true;
      });
      return;
    }

    try {
      final googleApiAvailability = GoogleApiAvailability.instance;
      final status = await googleApiAvailability
          .checkGooglePlayServicesAvailability();
      setState(() {
        _isGmsAvailable = status == GooglePlayServicesAvailability.success;
      });
    } catch (e) {
      setState(() {
        _isGmsAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isGmsAvailable == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(
                context,
              ).pop({'lat': selectedLat, 'long': selectedLong});
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _isGmsAvailable! ? _buildGoogleMap() : _buildMapboxMap(),
          const Center(
            child: Icon(Icons.location_on, size: 40, color: Colors.red),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.my_location),
        onPressed: () {
          // TODO: ممكن تضيف كود يجيب مكانك الحالي هنا
        },
      ),
    );
  }

  Widget _buildGoogleMap() {
    return gmap.GoogleMap(
      initialCameraPosition: gmap.CameraPosition(
        target: gmap.LatLng(widget.initialLat, widget.initialLong),
        zoom: 15,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (controller) {
        // _googleMapController = controller;
      },
      onCameraMove: (position) {
        selectedLat = position.target.latitude;
        selectedLong = position.target.longitude;
      },
    );
  }

  Widget _buildMapboxMap() {
    return mapbox.MapWidget(
      cameraOptions: mapbox.CameraOptions(
        center: mapbox.Point(
          coordinates: mapbox.Position(widget.initialLong, widget.initialLat),
        ),
        zoom: 15.0,
      ),
      styleUri: mapbox.MapboxStyles.MAPBOX_STREETS,
      onMapCreated: (mapbox.MapboxMap mapboxMap) {
        _mapboxMap = mapboxMap;
        _mapboxMap?.location.updateSettings(
             mapbox.LocationComponentSettings(enabled: true)
        );
      },
      onCameraChangeListener: (event) async {
        if (_mapboxMap != null) {
          final cameraState = await _mapboxMap!.getCameraState();
          final center = cameraState.center;
          selectedLong = center.coordinates.lng as double;
          selectedLat = center.coordinates.lat as double;
        }
      },
    );
  }
}
