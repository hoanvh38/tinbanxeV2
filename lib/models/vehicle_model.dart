import 'package:json_annotation/json_annotation.dart';
import 'package:tinbanxe/models/base_model.dart';
part 'vehicle_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String text;

  @JsonKey(defaultValue: '')
  String alias;

  @JsonKey(defaultValue: '')
  String title;

  VehicleModel({
    this.id = 0,
    this.text = '',
    this.alias = '',
    this.title = '',
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
