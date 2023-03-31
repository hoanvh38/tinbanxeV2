// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarCompanyModel _$CarCompanyModelFromJson(Map<String, dynamic> json) =>
    CarCompanyModel(
      id: json['id'] as int? ?? 0,
      url: json['url'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      parent_id: json['parent_id'] as int? ?? 0,
      position: json['position'] as int? ?? 0,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int? ?? 0,
      childes: (json['childes'] as List<dynamic>?)
              ?.map((e) => SubBranchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      brand_products_count: json['brand_products_count'] as int? ?? 0,
    );

Map<String, dynamic> _$CarCompanyModelToJson(CarCompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'slug': instance.slug,
      'name': instance.name,
      'icon': instance.icon,
      'parent_id': instance.parent_id,
      'title': instance.title,
      'position': instance.position,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'status': instance.status,
      'brand_products_count': instance.brand_products_count,
      'childes': instance.childes.map((e) => e.toJson()).toList(),
    };
