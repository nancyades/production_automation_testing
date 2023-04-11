class WorkorderModel {
  WorkorderModel({
    this.workorderId,
    this.workorderCode,
    this.quantity,
    this.startSerialNo,
    this.endSerialNo,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdDate,
    this.updatedDate,
    this.flg,
    this.remarks,
    this.woList
  });

  int? workorderId;
  String? workorderCode;
  int? quantity;
  String? startSerialNo;
  String? endSerialNo;
  String? status;
  int? createdBy;
  int? updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;
  String? remarks;
  List<WorkorderList>? woList;
}

class WorkorderList {
  WorkorderList({
    this.id,
    this.workorder_id,
    this.product_id,
    this.product_name,
    this.quantity,
    this.start_serial_no,
    this.end_serial_no,
    this.status,
    this.testing_status,
    this.start_date,
    this.end_date,
    this.flg,

  });

  int? id;
  int? workorder_id;
  int? product_id;
  String? product_name;
  int? quantity;
  String? start_serial_no;
  String? end_serial_no;
  String? status;
  String? testing_status;
  dynamic start_date;
  dynamic end_date;
  int? flg;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['workorder_id'] = workorder_id;
    data['quantity'] = quantity;
    data['product_name'] = product_name;
    data['product_id'] = product_id;
    data['start_serial_no'] = start_serial_no;
    data['end_serial_no'] = end_serial_no;
    data['status'] = status;
    data['testing_status'] = testing_status;
    data['start_date'] = start_date;
    data['end_date'] = end_date;
    data['flg'] = flg;
    return data;
  }


  /*Map<String, dynamic> toJsonAttr() => {
    'id': id,
    'workorder_id': workorder_id,
    'quantity': quantity,
    'product_id': product_id,
    'start_serial_no': start_serial_no,
    'end_serial_no': end_serial_no,
    'status': status,
    'testing_status': testing_status,
    'start_date': start_date,
    'end_date': end_date,
    'flg': flg,
  };*/


}