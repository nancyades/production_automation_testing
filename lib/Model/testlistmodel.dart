

class TestList {
  int? id;
  int? workorderId;
  int? productId;
  int? quantity;
  String? startSerialNo;
  String? endSerialNo;
  String? status;
  String? testingStatus;
  String? startDate;
  String? endDate;
  int? flg;
  List<Task>? task;

  TestList({
     this.id,
     this.workorderId,
     this.productId,
     this.quantity,
     this.startSerialNo,
     this.endSerialNo,
     this.status,
     this.testingStatus,
     this.startDate,
     this.endDate,
     this.flg,
     this.task,
  });

}

class Task {
  int? taskId;
  int? userId;
  int? assignId;
  int? wolId;
  int? quantity;
  String? startSerialNo;
  String? endSerialNo;
  String? status;
  String? testingStatus;
  dynamic startDate;
  dynamic endDate;
  int? createdBy;
  int? updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;
  int? rating;
  int? workorderId;
  int? productId;
  String? name;
  List<Tested>? testing;

  Task({
     this.taskId,
     this.userId,
     this.assignId,
     this.wolId,
     this.quantity,
     this.startSerialNo,
     this.endSerialNo,
     this.status,
     this.testingStatus,
     this.startDate,
     this.endDate,
     this.createdBy,
     this.updatedBy,
     this.createdDate,
     this.updatedDate,
     this.flg,
     this.rating,
     this.workorderId,
     this.productId,
     this.name,
     this.testing,
  });


}

class Tested {
  int? testId;
  int? taskId;
  int? testStage;
  dynamic testStatus;
  int? pass;
  int? fail;
  dynamic status;
  int? flg;
  String? macAddress;
  dynamic testType;
  dynamic testDate;
  int? hoursTaken;
  String? testNumber;

  Tested({
    this.testId,
    this.taskId,
    this.testStage,
    this.testStatus,
    this.pass,
    this.fail,
    this.status,
    this.flg,
    this.macAddress,
    this.testType,
    this.testDate,
    this.hoursTaken,
    this.testNumber,
  });


}

