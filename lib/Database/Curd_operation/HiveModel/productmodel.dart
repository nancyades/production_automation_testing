import 'package:hive/hive.dart';

part 'productmodel.g.dart';

@HiveType(typeId: 2)
class ProductModel extends HiveObject {
  @HiveField(0)
  String? product_id;

  @HiveField(1)
  String? product_name;

  @HiveField(2)
  String? product_code;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? template_id;

  @HiveField(5)
  String? quantity;

  @HiveField(6)
  String? status;

  @HiveField(7)
  String? created_by;

  @HiveField(8)
  String? updated_by;

  @HiveField(9)
  String? created_date;

  @HiveField(10)
  String? updated_date;

  @HiveField(11)
  bool? flg;

  @HiveField(12)
  String? remarks;

  @HiveField(13)
  String? time_required;

  @HiveField(14)
  String? mac_address;



  ProductModel(
      {this.product_id,
        this.product_name,
        this.product_code,
        this.description,
        this.template_id,
        this.quantity,
        this.status,
        this.created_by,
        this.updated_by,
        this.created_date,
        this.updated_date,
        this.flg,
        this.remarks,
        this.time_required,
        this.mac_address,
      });
}
