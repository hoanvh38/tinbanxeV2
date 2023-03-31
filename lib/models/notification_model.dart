import 'package:json_annotation/json_annotation.dart';
import 'package:tinbanxe/models/base_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: '')
  String image;

  @JsonKey(defaultValue: 0)
  int status;

  @JsonKey(defaultValue: '')
  String created_at;

  @JsonKey(defaultValue: '')
  String updated_at;

  NotificationModel(
      {this.id = 0,
      this.title = '',
      this.description = '',
      this.image = '',
      this.status = 0,
      this.created_at = '',
      this.updated_at = ''});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
