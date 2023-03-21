class TaskModel {
  TaskModel({
    required this.taskId,
    required this.userId,
    required this.assignId,
    required this.wolId,
    required this.quantity,
    required this.startSerialNo,
    required this.endSerialNo,
    required this.status,
    required this.testingStatus,
    required this.startDate,
    required this.endDate,
    required this.createdBy,
    required this.updatedBy,
    required this.createdDate,
    required this.updatedDate,
    required this.flg,
    required this.rating,
  });

  int taskId;
  int userId;
  int assignId;
  int wolId;
  int quantity;
  String startSerialNo;
  String endSerialNo;
  String status;
  String testingStatus;
  dynamic startDate;
  dynamic endDate;
  int createdBy;
  int updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int flg;
  int rating;

}
