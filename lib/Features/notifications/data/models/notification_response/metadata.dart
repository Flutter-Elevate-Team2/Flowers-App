import 'package:json_annotation/json_annotation.dart';

part 'metadata.g.dart';

@JsonSerializable()
class Metadata {
  num? currentPage;
  num? totalPages;
  num? limit;
  num? totalItems;
  num? unreadCount;

  Metadata({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
    this.unreadCount,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
