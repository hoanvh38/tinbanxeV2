import 'package:tinbanxe/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta_pagination_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaPaginationModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int limit;

  @JsonKey(defaultValue: 0)
  int offset;

  @JsonKey(defaultValue: 0)
  int total_size;


  MetaPaginationModel({
    this.limit = 0,
    this.offset = 0,
    this.total_size = 0,
  });

  factory MetaPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$MetaPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaPaginationModelToJson(this);
}
