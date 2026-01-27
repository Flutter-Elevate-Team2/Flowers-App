import 'dart:io';
import 'dart:ui' as ui;
import 'package:flowers_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  // Result
  late double selectedLat;
  late double selectedLong;

  // Google Map Controller
  gmap.GoogleMapController? _googleMapController;

  // Mapbox Variables
  mapbox.MapboxMap? _mapboxMap;
  mapbox.PointAnnotationManager? _pointAnnotationManager;

  // Markers for Google
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

  // ------------------ Helper: Convert SVG to Bytes ------------------
  Future<Uint8List> _getBytesFromSvg(String assetName, double width) async {
    final String svgString = await rootBundle.loadString(assetName);
    final PictureInfo pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);
    double devicePixelRatio = ui.window.devicePixelRatio;
    int size = (width * devicePixelRatio).toInt();

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    canvas.scale(devicePixelRatio);
    canvas.drawPicture(pictureInfo.picture);

    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(size, size);

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  // ------------------ Google Maps Logic ------------------
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

  // ------------------ Mapbox Logic ------------------
  Future<void> _updateMapboxMarker(double lat, double long) async {
    if (_pointAnnotationManager == null) return;

    await _pointAnnotationManager!.deleteAll();

    try {
      final Uint8List iconData = await _getBytesFromSvg(Assets.icons.locationDot, 64.0);

      var options = mapbox.PointAnnotationOptions(
        geometry: mapbox.Point(coordinates: mapbox.Position(long, lat)),
        image: iconData,
        iconSize: 1.0,
      );

      await _pointAnnotationManager!.create(options);
    } catch (e) {
      debugPrint("Error loading mapbox SVG: $e");
    }
  }

  // ------------------ Current Location Logic ------------------
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location services are disabled.')),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      setState(() {
        selectedLat = position.latitude;
        selectedLong = position.longitude;
      });

      if (_isGmsAvailable == true && _googleMapController != null) {
        await _googleMapController!.animateCamera(
          gmap.CameraUpdate.newLatLngZoom(
            gmap.LatLng(position.latitude, position.longitude),
            15,
          ),
        );
        _updateGoogleMarker();
      } else if (_mapboxMap != null) {
        _mapboxMap!.flyTo(
          mapbox.CameraOptions(
            center: mapbox.Point(
              coordinates: mapbox.Position(position.longitude, position.latitude),
            ),
            zoom: 15.0,
          ),
          mapbox.MapAnimationOptions(duration: 1000),
        );
        _updateMapboxMarker(position.latitude, position.longitude);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Current location selected')),
        );
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
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
              Navigator.of(context).pop({'lat': selectedLat, 'long': selectedLong});
            },
          ),
        ],
      ),
      body: _isGmsAvailable! ? _buildGoogleMap() : _buildMapboxMap(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Widget _buildGoogleMap() {
    return gmap.GoogleMap(
      initialCameraPosition: gmap.CameraPosition(
        target: gmap.LatLng(widget.initialLat, widget.initialLong),
        zoom: 15,
      ),
      markers: _googleMarkers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
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
      onMapCreated: (mapbox.MapboxMap mapboxMap) async {
        _mapboxMap = mapboxMap;

        _mapboxMap?.location.updateSettings(
          mapbox.LocationComponentSettings(enabled: true),
        );

        _pointAnnotationManager = await mapboxMap.annotations.createPointAnnotationManager();

        _updateMapboxMarker(selectedLat, selectedLong);
      },
      onTapListener: (mapbox.MapContentGestureContext context) {
        final lat = context.point.coordinates.lat.toDouble();
        final lng = context.point.coordinates.lng.toDouble();

        setState(() {
          selectedLat = lat;
          selectedLong = lng;
        });

        _updateMapboxMarker(lat, lng);
      },
    );
  }
}
