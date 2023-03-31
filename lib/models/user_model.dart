import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class UserModel extends HiveObject {
  @HiveField(0, defaultValue: 0)
  @JsonKey(defaultValue: 0)
  int id;

  @HiveField(1, defaultValue: '')
  @JsonKey(defaultValue: '')
  String name;

  @HiveField(2, defaultValue: '')
  @JsonKey(defaultValue: '')
  String email;

  @HiveField(3, defaultValue: '')
  @JsonKey(defaultValue: '')
  String method;

  @HiveField(4, defaultValue: '')
  @JsonKey(defaultValue: '')
  String address;

  @HiveField(5, defaultValue: '')
  @JsonKey(defaultValue: '')
  String f_name;

  @HiveField(6, defaultValue: '')
  @JsonKey(defaultValue: '')
  String l_name;

  @HiveField(7, defaultValue: '')
  @JsonKey(defaultValue: '')
  String phone;

  @HiveField(8, defaultValue: '')
  @JsonKey(defaultValue: '')
  String image;

  UserModel(
      {this.id=0,
      this.name='',
      this.email='',
      this.method='',
      this.address='',
      this.f_name='',
      this.l_name='',
      this.phone='',
      this.image=''});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
