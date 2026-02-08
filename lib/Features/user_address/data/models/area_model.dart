class AreaModel {
  final String id;
  final String governorateId;
  final String cityNameAr;
  final String cityNameEn;

  AreaModel({
    required this.id,
    required this.governorateId,
    required this.cityNameAr,
    required this.cityNameEn,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'] as String,
      governorateId: json['governorate_id'] as String,
      cityNameAr: json['city_name_ar'] as String,
      cityNameEn: json['city_name_en'] as String,
    );
  }
}
