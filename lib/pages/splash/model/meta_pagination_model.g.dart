// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaPaginationModel _$MetaPaginationModelFromJson(Map<String, dynamic> json) =>
    MetaPaginationModel(
      limit: json['limit'] as int? ?? 0,
      offset: json['offset'] as int? ?? 0,
      total_size: json['total_size'] as int? ?? 0,
    );

Map<String, dynamic> _$MetaPaginationModelToJson(
        MetaPaginationModel instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total_size': instance.total_size,
    };
