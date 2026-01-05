import 'package:json_annotation/json_annotation.dart';

part 'occasion.g.dart';

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? slug;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isSuperAdmin;

  Occasion({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) {
    return _$OccasionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}
