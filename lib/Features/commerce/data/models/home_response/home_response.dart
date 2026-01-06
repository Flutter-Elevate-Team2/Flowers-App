import 'package:json_annotation/json_annotation.dart';

import 'best_seller.dart';
import 'category.dart';
import 'occasion.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse  {
  String? message;
  List<Category>? categories;
  List<BestSeller>? bestSeller;
  List<Occasion>? occasions;

  HomeResponse({
    this.message,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

}
