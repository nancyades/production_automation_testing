// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermanagement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserManagementmodelAdapter extends TypeAdapter<UserManagementmodel> {
  @override
  final int typeId = 0;

  @override
  UserManagementmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserManagementmodel(
      emp_id: fields[0] as String?,
      name: fields[1] as String?,
      password: fields[2] as String?,
      email: fields[3] as String?,
      phoneno: fields[4] as String?,
      isActive: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserManagementmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.emp_id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneno)
      ..writeByte(5)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserManagementmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
