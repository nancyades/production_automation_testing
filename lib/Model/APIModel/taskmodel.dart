class TaskModel {
  TaskModel({
    this.workorderid,
    this.productid,
    this.username,
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
    this.testing
  });

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
  int? workorderid;
  int? productid;
  String? username;
  List<Testing>? testing;


}

class Testing {
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
  bool? isSelected = false;

  Testing({
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
    this.isSelected,
  });


  Testing.fromJson(Map<String, dynamic> json)
  : testId = json['testId'],
        taskId = json['taskId'],
        testStage = json['testStage'],
        testStatus = json['testStatus'],
        pass = json['pass'],
        fail = json['fail'],
        status = json['status'],
        flg = json['flg'],
        macAddress = json['macAddress'],
        testType = json['testType'],
        testDate = json['testDate'],
        hoursTaken = json['hoursTaken'],
        testNumber = json['testNumber'];


  Map<String, dynamic> toJson() {
    return {
   'testId':  testId,
   'taskId':  taskId,
   'testStage':  testStage,
   'testStatus':  testStatus,
   'pass':  pass,
   'fail':  fail,
   'status':  status,
   'flg':  flg,
   'macAddress':  macAddress,
   'testType':  testType,
   'testDate':  testDate,
   'hoursTaken':  hoursTaken,
   'testNumber':  testNumber,

    };
  }

}


class Nancy{
  String? testNumber;
  String? testName;

  Nancy({
    this.testNumber,
    this.testName
});
}









class TaskNewModel {
  TaskNewModel({
    this.taskId,
    this.userId,
    this.username,
    this.assignId,
    this.wolId,
    this.workOrder,
    this.templateId,
    this.templateName,
    this.productName,
    this.productCode,
    this.quantity,
    this.startSerialNo,
    this.endSerialNo,
    this.status,
    this.testingStatus,
    this.startDate,
    this.endDate,
    this.welcomeCreatedBy,
    this.createdBy,
    this.welcomeUpdatedBy,
    this.updatedBy,
    this.createdDate,
    this.updatedDate,
    this.flg,
    this.rating,
  });

  int? taskId;
  int? userId;
  String? username;
  int? assignId;
  int? wolId;
  String? workOrder;
  int? templateId;
  String? templateName;
  String? productName;
  String? productCode;
  int? quantity;
  String? startSerialNo;
  String? endSerialNo;
  String? status;
  String? testingStatus;
  dynamic startDate;
  dynamic endDate;
  int? welcomeCreatedBy;
  String? createdBy;
  int? welcomeUpdatedBy;
  String? updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;
  int? rating;

}
