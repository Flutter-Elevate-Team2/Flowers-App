import 'dart:convert';
import 'package:flowers_app/Features/user_address/data/models/area_model.dart';
import 'package:flowers_app/Features/user_address/data/models/city_model.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flowers_app/core/extension/context_extension.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
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
        debugPrint('Loaded ${_cities.length} cities');
      } else {
        debugPrint('No governorates data found in JSON');
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
        debugPrint('Loaded ${_areas.length} areas');
      } else {
        debugPrint('No cities/areas data found in JSON');
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 24),
            Image(image: AssetImage("assets/images/Rectangle.png")),
            SizedBox(height: 24),
            TextFormField(
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: context.l10n.addressLabel,
                hintText: context.l10n.addressHint,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: context.l10n.phoneNumberLabel,
                hintText: context.l10n.phoneNumberHint,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: context.l10n.recipientNameLabel,
                hintText: context.l10n.recipientNameHint,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<CityModel>(
                    value: _selectedCity,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.cityLabel,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    hint: Text(context.l10n.cityHint),
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
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<AreaModel>(
                    value: _selectedArea,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.areaLabel,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    hint: Text(context.l10n.areaHint),
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
            SizedBox(height: 48),
            CustomButton(title: context.l10n.saveAddress, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
