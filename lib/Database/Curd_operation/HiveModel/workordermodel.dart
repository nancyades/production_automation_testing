import 'package:hive/hive.dart';

part 'workordermodel.g.dart';

@HiveType(typeId: 1)
class WorkOrderModel extends HiveObject {
  @HiveField(0)
  String? workorder_id;

  @HiveField(1)
  String? workorder_code;

  @HiveField(2)
  String? quantity;

  @HiveField(3)
  String? start_serial_no;

  @HiveField(4)
  String? end_serial_no;

  @HiveField(5)
  String? status;

  @HiveField(6)
  String? created_by;

  @HiveField(7)
  String? updated_by;

  @HiveField(8)
  String? created_date;

  @HiveField(9)
  String? updated_date;

  @HiveField(10)
  bool? flg;

  @HiveField(11)
  String? remarks;


  WorkOrderModel(
      {this.workorder_id,
        this.workorder_code,
        this.quantity,
        this.start_serial_no,
        this.end_serial_no,
        this.status,
        this.created_by,
        this.updated_by,
        this.created_date,
        this.updated_date,
        this.flg,
        this.remarks,
      });
}
