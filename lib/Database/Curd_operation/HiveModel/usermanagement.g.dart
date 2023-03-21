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
      user_id: fields[0] as String?,
      emp_id: fields[1] as String?,
      name: fields[2] as String?,
      password: fields[3] as String?,
      avatar_id: fields[4] as String?,
      emailid: fields[5] as String?,
      phoneno: fields[6] as String?,
      role: fields[7] as String?,
      created_by: fields[8] as String?,
      updated_by: fields[9] as String?,
      created_date: fields[10] as String?,
      updated_date: fields[11] as String?,
      flg: fields[12] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserManagementmodel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.user_id)
      ..writeByte(1)
      ..write(obj.emp_id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.avatar_id)
      ..writeByte(5)
      ..write(obj.emailid)
      ..writeByte(6)
      ..write(obj.phoneno)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.created_by)
      ..writeByte(9)
      ..write(obj.updated_by)
      ..writeByte(10)
      ..write(obj.created_date)
      ..writeByte(11)
      ..write(obj.updated_date)
      ..writeByte(12)
      ..write(obj.flg);
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
