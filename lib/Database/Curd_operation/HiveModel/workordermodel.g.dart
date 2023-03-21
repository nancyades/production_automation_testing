// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workordermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderModelAdapter extends TypeAdapter<WorkOrderModel> {
  @override
  final int typeId = 1;

  @override
  WorkOrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrderModel(
      workorder_id: fields[0] as String?,
      workorder_code: fields[1] as String?,
      quantity: fields[2] as String?,
      start_serial_no: fields[3] as String?,
      end_serial_no: fields[4] as String?,
      status: fields[5] as String?,
      created_by: fields[6] as String?,
      updated_by: fields[7] as String?,
      created_date: fields[8] as String?,
      updated_date: fields[9] as String?,
      flg: fields[10] as bool?,
      remarks: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrderModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.workorder_id)
      ..writeByte(1)
      ..write(obj.workorder_code)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.start_serial_no)
      ..writeByte(4)
      ..write(obj.end_serial_no)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.created_by)
      ..writeByte(7)
      ..write(obj.updated_by)
      ..writeByte(8)
      ..write(obj.created_date)
      ..writeByte(9)
      ..write(obj.updated_date)
      ..writeByte(10)
      ..write(obj.flg)
      ..writeByte(11)
      ..write(obj.remarks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
