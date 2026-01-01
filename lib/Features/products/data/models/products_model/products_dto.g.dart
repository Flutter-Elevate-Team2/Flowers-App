// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
  imgCover: json['imgCover'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  price: (json['price'] as num?)?.toInt(),
  priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
  quantity: (json['quantity'] as num?)?.toInt(),
  category: json['category'] as String?,
  occasion: json['occasion'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
  isSuperAdmin: json['isSuperAdmin'] as bool?,
  sold: (json['sold'] as num?)?.toInt(),
  rateAvg: (json['rateAvg'] as num?)?.toInt(),
  rateCount: (json['rateCount'] as num?)?.toInt(),
  favoriteId: json['favoriteId'],
  isInWishlist: json['isInWishlist'] as bool?,
  discount: (json['discount'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'imgCover': instance.imgCover,
  'images': instance.images,
  'price': instance.price,
  'priceAfterDiscount': instance.priceAfterDiscount,
  'quantity': instance.quantity,
  'category': instance.category,
  'occasion': instance.occasion,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'isSuperAdmin': instance.isSuperAdmin,
  'sold': instance.sold,
  'rateAvg': instance.rateAvg,
  'rateCount': instance.rateCount,
  'favoriteId': instance.favoriteId,
  'isInWishlist': instance.isInWishlist,
  'discount': instance.discount,
};
