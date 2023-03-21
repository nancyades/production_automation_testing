// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'templatemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemplateModelAdapter extends TypeAdapter<TemplateModel> {
  @override
  final int typeId = 3;

  @override
  TemplateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemplateModel(
      Template_ID: fields[0] as String?,
      Template_Name: fields[1] as String?,
      File_Path: fields[2] as String?,
      Created_By: fields[3] as String?,
      Updated_By: fields[4] as String?,
      Created_date: fields[5] as String?,
      Updated_date: fields[6] as String?,
      Flg: fields[7] as bool?,
      Remarks: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TemplateModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.Template_ID)
      ..writeByte(1)
      ..write(obj.Template_Name)
      ..writeByte(2)
      ..write(obj.File_Path)
      ..writeByte(3)
      ..write(obj.Created_By)
      ..writeByte(4)
      ..write(obj.Updated_By)
      ..writeByte(5)
      ..write(obj.Created_date)
      ..writeByte(6)
      ..write(obj.Updated_date)
      ..writeByte(7)
      ..write(obj.Flg)
      ..writeByte(8)
      ..write(obj.Remarks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
