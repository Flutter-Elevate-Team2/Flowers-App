import 'dart:convert';
import 'dart:io';

import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/area_model.dart';
import 'package:flowers_app/Features/user_address/data/models/city_model.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/map_location_picker.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

class AddAddressScreenBody extends StatefulWidget {
  final AddressEntity? addressToEdit;

  const AddAddressScreenBody({super.key, this.addressToEdit});

  @override
  State<AddAddressScreenBody> createState() => _AddAddressScreenBodyState();
}

class _AddAddressScreenBodyState extends State<AddAddressScreenBody> {
  List<CityModel> _cities = [];
  List<AreaModel> _areas = [];
  List<AreaModel> _filteredAreas = [];
  CityModel? _selectedCity;
  AreaModel? _selectedArea;

  double? _lat;
  double? _long;

  // Google Maps Variables
  GoogleMapController? _mapPreviewController;
  Set<Marker> _markers = {};

  // Mapbox Variables
  mapbox.MapboxMap? _mapboxPreviewController;
  mapbox.PointAnnotationManager? _pointAnnotationManager;

  // GMS Check
  bool? _isGmsAvailable;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get _isEditMode => widget.addressToEdit != null;

  @override
  void initState() {
    super.initState();
    _checkGmsAvailability();
    _loadData();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _mapPreviewController?.dispose();
    super.dispose();
  }

  Future<void> _checkGmsAvailability() async {
    if (Platform.isIOS) {
      setState(() => _isGmsAvailable = true);
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
      setState(() => _isGmsAvailable = false);
    }
  }

  Future<void> _loadData() async {
    await _loadCities();
    await _loadAreas();

    if (!mounted) return;
    if (_isEditMode) {
      _prefillEditData();
    } else {
      _updateMarkersAndCamera();
    }
  }

  void _prefillEditData() {
    final address = widget.addressToEdit!;
    _addressController.text = address.street;
    _phoneController.text = address.phone;
    _nameController.text = address.username;
    _lat = double.tryParse(address.lat);
    _long = double.tryParse(address.long);

    _updateMarkersAndCamera();

    if (_cities.isNotEmpty) {
      _selectedCity = _cities.firstWhere(
        (city) => city.governorateNameEn == address.city,
        orElse: () => _cities.first,
      );
      _onCityChanged(_selectedCity);
    }
  }

  Future<void> _loadCities() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/lottie/cities.json',
      );
      final List<dynamic> data = json.decode(response);
      final governoratesData = data.firstWhere(
        (element) =>
            element is Map &&
            element['type'] == 'table' &&
            element['name'] == 'governorates',
        orElse: () => null,
      );

      if (governoratesData != null && governoratesData['data'] != null) {
        setState(() {
          _cities = (governoratesData['data'] as List)
              .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
              .toList();
        });

        if (_isEditMode && _selectedCity == null) {
          final address = widget.addressToEdit!;
          _selectedCity = _cities.firstWhere(
            (city) => city.governorateNameEn == address.city,
            orElse: () => _cities.first,
          );
          _onCityChanged(_selectedCity);
        }
      }
    } catch (e) {
      debugPrint('Error loading cities: $e');
    }
  }

  Future<void> _loadAreas() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/lottie/states (1).json',
      );
      final List<dynamic> data = json.decode(response);
      final citiesData = data.firstWhere(
        (element) =>
            element is Map &&
            element['type'] == 'table' &&
            element['name'] == 'cities',
        orElse: () => null,
      );

      if (citiesData != null && citiesData['data'] != null) {
        setState(() {
          _areas = (citiesData['data'] as List)
              .map((e) => AreaModel.fromJson(e as Map<String, dynamic>))
              .toList();
        });
      }
    } catch (e) {
      debugPrint('Error loading areas: $e');
    }
  }

  void _onCityChanged(CityModel? city) {
    setState(() {
      _selectedCity = city;
      if (!_isEditMode || _selectedArea?.governorateId != city?.id) {
        _selectedArea = null;
      }
      if (city != null) {
        _filteredAreas = _areas
            .where((area) => area.governorateId == city.id)
            .toList();
      } else {
        _filteredAreas = [];
      }
    });
  }

  // --- Map Helper Methods ---

  Future<Uint8List> _getBytesFromPng(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    return data.buffer.asUint8List();
  }

  Future<void> _updateMarkersAndCamera() async {
    final lat = _lat ?? 30.0444;
    final long = _long ?? 31.2357;

    if (_isGmsAvailable == true) {
      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId('selected_location'),
            position: LatLng(lat, long),
            icon: BitmapDescriptor.defaultMarker,
          ),
        };
      });
      if (_mapPreviewController != null) {
        await _mapPreviewController!.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(lat, long), 15),
        );
      }
    } else {
      if (_mapboxPreviewController != null) {
        _mapboxPreviewController!.flyTo(
          mapbox.CameraOptions(
            center: mapbox.Point(coordinates: mapbox.Position(long, lat)),
            zoom: 15.0,
          ),
          mapbox.MapAnimationOptions(duration: 1000),
        );
      }
      if (_pointAnnotationManager != null) {
        await _pointAnnotationManager!.deleteAll();
        try {
          final Uint8List iconData = await _getBytesFromPng(
            "assets/images/icons8-location-48.png",
          );

          var options = mapbox.PointAnnotationOptions(
            geometry: mapbox.Point(coordinates: mapbox.Position(long, lat)),
            image: iconData,
            iconSize: 2.0,
          );
          await _pointAnnotationManager!.create(options);
        } catch (e) {
          debugPrint("Error marker mapbox preview: $e");
        }
      }
    }
  }

  Future<void> _pickLocationOnMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocationPicker(
          initialLat: _lat ?? 30.0444,
          initialLong: _long ?? 31.2357,
        ),
      ),
    );

    if (!mounted) return;

    if (result != null && result is Map) {
      setState(() {
        _lat = result['lat'];
        _long = result['long'];
      });
      await _updateMarkersAndCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isGmsAvailable == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocConsumer<UserAddressViewModel, UserAddressState>(
      listenWhen: (previous, current) {
        return previous.addAddressState != current.addAddressState ||
            previous.editAddressState != current.editAddressState;
      },
      listener: (context, state) {
        if (state.addAddressState?.isLoading == false) {
          if (state.addAddressState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.addAddressState!.errorMessage!)),
            );
          } else if (state.addAddressState?.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.addressAddedSuccess)),
            );
            context.pop();
          }
        }

        if (state.editAddressState?.isLoading == false) {
          if (state.editAddressState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.editAddressState!.errorMessage!)),
            );
          } else if (state.editAddressState?.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.addressUpdatedSuccess)),
            );
            context.pop();
          }
        }
      },
      builder: (context, state) {
        final isLoading =
            state.addAddressState?.isLoading == true ||
            state.editAddressState?.isLoading == true;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: _pickLocationOnMap,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            // ------------------ Map Preview Check ------------------
                            _isGmsAvailable!
                                ? GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                        _lat ?? 30.0444,
                                        _long ?? 31.2357,
                                      ),
                                      zoom: 15,
                                    ),
                                    markers: _markers,
                                    onMapCreated: (controller) {
                                      _mapPreviewController = controller;
                                    },
                                    scrollGesturesEnabled: false,
                                    zoomGesturesEnabled: false,
                                    rotateGesturesEnabled: false,
                                    tiltGesturesEnabled: false,
                                    myLocationButtonEnabled: false,
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                    compassEnabled: false,
                                  )
                                : mapbox.MapWidget(
                                    key: const ValueKey("mapbox_preview"),
                                    cameraOptions: mapbox.CameraOptions(
                                      center: mapbox.Point(
                                        coordinates: mapbox.Position(
                                          _long ?? 31.2357,
                                          _lat ?? 30.0444,
                                        ),
                                      ),
                                      zoom: 15.0,
                                    ),
                                    styleUri:
                                        mapbox.MapboxStyles.MAPBOX_STREETS,
                                    onMapCreated: (mapboxMap) async {
                                      _mapboxPreviewController = mapboxMap;
                                      _pointAnnotationManager = await mapboxMap
                                          .annotations
                                          .createPointAnnotationManager();
                                      _updateMarkersAndCamera();
                                    },
                                  ),

                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.edit_location, size: 18),
                                    const SizedBox(width: 4),
                                    Text(
                                      context.l10n.tapToChange,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(color: Colors.transparent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.addressRequired;
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      labelText: context.l10n.addressLabel,
                      hintText: context.l10n.addressHint,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.phoneNumberRequired;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: context.l10n.phoneNumberLabel,
                      hintText: context.l10n.phoneNumberHint,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.recipientNameRequired;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: context.l10n.recipientNameLabel,
                      hintText: context.l10n.recipientNameHint,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<CityModel>(
                          initialValue: _selectedCity,
                          validator: (value) =>
                              value == null ? context.l10n.required : null,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: context.l10n.cityLabel,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          hint: Text(context.l10n.cairoHint),
                          items: _cities.map((CityModel city) {
                            return DropdownMenuItem<CityModel>(
                              value: city,
                              child: Text(
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? city.governorateNameAr
                                    : city.governorateNameEn,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: _onCityChanged,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<AreaModel>(
                          initialValue: _selectedArea,
                          validator: (value) =>
                              value == null ? context.l10n.required : null,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: context.l10n.areaLabel,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          hint: Text(context.l10n.octoberHint),
                          items: _filteredAreas.map((AreaModel area) {
                            return DropdownMenuItem<AreaModel>(
                              value: area,
                              child: Text(
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? area.cityNameAr
                                    : area.cityNameEn,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: _selectedCity == null
                              ? null
                              : (AreaModel? area) {
                                  setState(() {
                                    _selectedArea = area;
                                  });
                                },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          title: _isEditMode
                              ? context.l10n.updateAddress
                              : context.l10n.saveAddress,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_lat == null || _long == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.l10n.pleasePickLocation,
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (_isEditMode) {
                                final request = EditAddressRequest(
                                  street: _addressController.text,
                                  phone: _phoneController.text,
                                  username: _nameController.text,
                                  city: _selectedCity?.governorateNameEn,
                                  lat: _lat.toString(),
                                  long: _long.toString(),
                                );

                                context.read<UserAddressViewModel>().doIntent(
                                  EditAddressEvent(
                                    request,
                                    widget.addressToEdit!.id,
                                  ),
                                );
                              } else {
                                final request = AddAddressRequest(
                                  street: _addressController.text,
                                  phone: _phoneController.text,
                                  username: _nameController.text,
                                  city: _selectedCity?.governorateNameEn,
                                  lat: _lat.toString(),
                                  long: _long.toString(),
                                );

                                context.read<UserAddressViewModel>().doIntent(
                                  AddAddressEvent(request),
                                );
                              }
                            }
                          },
                        ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
