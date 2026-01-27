import 'dart:io';

import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:permission_handler/permission_handler.dart';

class MapLocationPicker extends StatefulWidget {
  final double initialLat;
  final double initialLong;

  const MapLocationPicker({
    super.key,
    this.initialLat = 30.0444,
    this.initialLong = 31.2357,
  });

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  bool? _isGmsAvailable;

  late double selectedLat;
  late double selectedLong;

  gmap.GoogleMapController? _googleMapController;

  mapbox.MapboxMap? _mapboxMap;

  Set<gmap.Marker> _googleMarkers = {};

  @override
  void initState() {
    super.initState();
    selectedLat = widget.initialLat;
    selectedLong = widget.initialLong;
    _checkGmsAvailability();
    _updateGoogleMarker();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
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

  void _updateGoogleMarker() {
    setState(() {
      _googleMarkers = {
        gmap.Marker(
          markerId: const gmap.MarkerId('selected_location'),
          position: gmap.LatLng(selectedLat, selectedLong),
          icon: gmap.BitmapDescriptor.defaultMarkerWithHue(
            gmap.BitmapDescriptor.hueRed,
          ),
        ),
      };
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.locationServicesDisabled)),
          );
        }
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.locationPermissionsDenied)),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.locationPermissionsPermanentlyDenied),
            ),
          );
        }
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        selectedLat = position.latitude;
        selectedLong = position.longitude;
      });

      // Animate camera to current location
      if (_isGmsAvailable == true && _googleMapController != null) {
        await _googleMapController!.animateCamera(
          gmap.CameraUpdate.newLatLngZoom(
            gmap.LatLng(position.latitude, position.longitude),
            15,
          ),
        );
        _updateGoogleMarker();
      } else if (_mapboxMap != null) {
        await _mapboxMap!.flyTo(
          mapbox.CameraOptions(
            center: mapbox.Point(
              coordinates: mapbox.Position(
                position.longitude,
                position.latitude,
              ),
            ),
            zoom: 15.0,
          ),
          mapbox.MapAnimationOptions(duration: 1000),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.currentLocationSelected),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${context.l10n.errorGettingLocation}$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isGmsAvailable == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.pickLocation),
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
      body: _isGmsAvailable!
          ? GoogleMapWidget(
              initialLat: widget.initialLat,
              initialLong: widget.initialLong,
              markers: _googleMarkers,
              onMapCreated: (controller) {
                _googleMapController = controller;
              },
              onTap: (gmap.LatLng position) {
                setState(() {
                  selectedLat = position.latitude;
                  selectedLong = position.longitude;
                });
                _updateGoogleMarker();
              },
            )
          : MapboxMapWidget(
              initialLat: widget.initialLat,
              initialLong: widget.initialLong,
              onMapCreated: (mapbox.MapboxMap mapboxMap) {
                _mapboxMap = mapboxMap;
                _mapboxMap?.location.updateSettings(
                  mapbox.LocationComponentSettings(enabled: true),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

class GoogleMapWidget extends StatelessWidget {
  final double initialLat;
  final double initialLong;
  final Set<gmap.Marker> markers;
  final void Function(gmap.GoogleMapController) onMapCreated;
  final void Function(gmap.LatLng) onTap;

  const GoogleMapWidget({
    super.key,
    required this.initialLat,
    required this.initialLong,
    required this.markers,
    required this.onMapCreated,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return gmap.GoogleMap(
      initialCameraPosition: gmap.CameraPosition(
        target: gmap.LatLng(initialLat, initialLong),
        zoom: 15,
      ),
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: onMapCreated,
      onTap: onTap,
    );
  }
}

class MapboxMapWidget extends StatelessWidget {
  final double initialLat;
  final double initialLong;
  final void Function(mapbox.MapboxMap) onMapCreated;

  const MapboxMapWidget({
    super.key,
    required this.initialLat,
    required this.initialLong,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return mapbox.MapWidget(
      cameraOptions: mapbox.CameraOptions(
        center: mapbox.Point(
          coordinates: mapbox.Position(initialLong, initialLat),
        ),
        zoom: 15.0,
      ),
      styleUri: mapbox.MapboxStyles.MAPBOX_STREETS,
      onMapCreated: onMapCreated,
    );
  }
}
