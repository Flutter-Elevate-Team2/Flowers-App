class CityModel {
  final String id;
  final String governorateNameAr;
  final String governorateNameEn;

  CityModel({
    required this.id,
    required this.governorateNameAr,
    required this.governorateNameEn,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      governorateNameAr: json['governorate_name_ar'] as String,
      governorateNameEn: json['governorate_name_en'] as String,
    );
  }
}
