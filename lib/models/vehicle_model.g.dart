// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) => VehicleModel(
      id: json['id'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      alias: json['alias'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'alias': instance.alias,
      'title': instance.title,
    };
