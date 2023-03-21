// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 2;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      product_id: fields[0] as String?,
      product_name: fields[1] as String?,
      product_code: fields[2] as String?,
      description: fields[3] as String?,
      template_id: fields[4] as String?,
      quantity: fields[5] as String?,
      status: fields[6] as String?,
      created_by: fields[7] as String?,
      updated_by: fields[8] as String?,
      created_date: fields[9] as String?,
      updated_date: fields[10] as String?,
      flg: fields[11] as bool?,
      remarks: fields[12] as String?,
      time_required: fields[13] as String?,
      mac_address: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.product_id)
      ..writeByte(1)
      ..write(obj.product_name)
      ..writeByte(2)
      ..write(obj.product_code)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.template_id)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.created_by)
      ..writeByte(8)
      ..write(obj.updated_by)
      ..writeByte(9)
      ..write(obj.created_date)
      ..writeByte(10)
      ..write(obj.updated_date)
      ..writeByte(11)
      ..write(obj.flg)
      ..writeByte(12)
      ..write(obj.remarks)
      ..writeByte(13)
      ..write(obj.time_required)
      ..writeByte(14)
      ..write(obj.mac_address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
