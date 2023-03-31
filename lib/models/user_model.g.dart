// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] == null ? 0 : fields[0] as int,
      name: fields[1] == null ? '' : fields[1] as String,
      email: fields[2] == null ? '' : fields[2] as String,
      method: fields[3] == null ? '' : fields[3] as String,
      address: fields[4] == null ? '' : fields[4] as String,
      f_name: fields[5] == null ? '' : fields[5] as String,
      l_name: fields[6] == null ? '' : fields[6] as String,
      phone: fields[7] == null ? '' : fields[7] as String,
      image: fields[8] == null ? '' : fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.method)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.f_name)
      ..writeByte(6)
      ..write(obj.l_name)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      method: json['method'] as String? ?? '',
      address: json['address'] as String? ?? '',
      f_name: json['f_name'] as String? ?? '',
      l_name: json['l_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'method': instance.method,
      'address': instance.address,
      'f_name': instance.f_name,
      'l_name': instance.l_name,
      'phone': instance.phone,
      'image': instance.image,
    };
