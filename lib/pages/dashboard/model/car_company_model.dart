import 'package:json_annotation/json_annotation.dart';
import 'package:tinbanxe/models/SubBranchModel.dart';
import 'package:tinbanxe/models/base_model.dart';

part 'car_company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CarCompanyModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String url;

  @JsonKey(defaultValue: '')
  String slug;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String icon;

  @JsonKey(defaultValue: 0)
  int parent_id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: 0)
  int position;

  DateTime? created_at;

  DateTime? updated_at;

  @JsonKey(defaultValue: 0)
  int status;

  @JsonKey(defaultValue: 0)
  int brand_products_count;

  @JsonKey(defaultValue: <SubBranchModel>[])
  List<SubBranchModel> childes;

  CarCompanyModel({this.id = 0,
    this.url = '',
    this.slug = '',
    this.name = '',
    this.title ='',
    this.icon = '',
    this.parent_id = 0,
    this.position = 0,
    this.created_at,
    this.updated_at,
    this.status = 0,
    this.childes = const <SubBranchModel>[],
    this.brand_products_count = 0});

  factory CarCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CarCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarCompanyModelToJson(this);
}
