import 'dart:convert';

import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/area_model.dart';
import 'package:flowers_app/Features/user_address/data/models/city_model.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/map_location_picker.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreenBody extends StatefulWidget {
  const AddAddressScreenBody({super.key});

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

  GoogleMapController? _mapPreviewController;
  Set<Marker> _markers = {};

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadData();
    _updateMarker();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _mapPreviewController?.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await _loadCities();
    await _loadAreas();
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
      _selectedArea = null;
      if (city != null) {
        _filteredAreas = _areas
            .where((area) => area.governorateId == city.id)
            .toList();
      } else {
        _filteredAreas = [];
      }
    });
  }

  void _updateMarker() {
    final lat = _lat ?? 30.0444;
    final long = _long ?? 31.2357;

    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
    });
  }

  Future<void> _updateMapLocation(double lat, double long) async {
    if (_mapPreviewController != null) {
      await _mapPreviewController!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, long), 15),
      );
      _updateMarker();
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

      await _updateMapLocation(_lat!, _long!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location Selected: $_lat, $_long"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserAddressViewModel>(),
      child: BlocConsumer<UserAddressViewModel, UserAddressState>(
        listener: (context, state) {
          if (state.addAddressState?.isLoading == false) {
            if (state.addAddressState?.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.addAddressState!.errorMessage!)),
              );
            } else if (state.addAddressState?.data != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Address added successfully")),
              );
              context.pop();
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // Live Map Preview Card
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
                              GoogleMap(
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
                              ),
                              // Tap to Edit Overlay
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
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit_location, size: 18),
                                      SizedBox(width: 4),
                                      Text(
                                        'Tap to change',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
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
                          return 'Please enter address';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: const InputDecoration(
                        labelText: "Address",
                        hintText: "Enter your address",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Enter your phone number",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(
                        labelText: "Recipient name",
                        hintText: "Enter recipient name",
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<CityModel>(
                            initialValue: _selectedCity,
                            validator: (value) =>
                                value == null ? 'Required' : null,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: "City",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            hint: const Text("Cairo"),
                            items: _cities.map((CityModel city) {
                              return DropdownMenuItem<CityModel>(
                                value: city,
                                child: Text(
                                  city.governorateNameEn,
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
                                value == null ? 'Required' : null,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: "Area",
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            hint: const Text("October"),
                            items: _filteredAreas.map((AreaModel area) {
                              return DropdownMenuItem<AreaModel>(
                                value: area,
                                child: Text(
                                  area.cityNameEn,
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
                    state.addAddressState?.isLoading == true
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: "save Address",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_lat == null || _long == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please pick a location on map",
                                      ),
                                    ),
                                  );
                                  return;
                                }

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
                            },
                          ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
