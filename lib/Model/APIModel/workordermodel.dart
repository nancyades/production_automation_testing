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

}