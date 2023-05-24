

class WorkorderbasedReport {
  WorkorderbasedReport({
    required this.workorderId,
    required this.workOrder,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.startSerialNo,
    required this.endSerialNo,
    required this.spendTime,
    required this.hoursTaken,
    required this.macAddress,
    required this.testType,
    required this.testedBy,
    required this.testedDate,
    required this.testResult,
    required this.testName,
  });

  int workorderId;
  String workOrder;
  int productId;
  String productName;
  String productCode;
  String startSerialNo;
  String endSerialNo;
  int spendTime;
  int hoursTaken;
  String macAddress;
  String testType;
  String testedBy;
  dynamic testedDate;
  String testResult;
  String testName;

}




class NewWorkorderbasedReport {
  int? workorderId;
  String? workOrder;
  int? productId;
  String? productName;
  String? productCode;
  String? startSerialNo;
  String? endSerialNo;
  dynamic spendTime;
  dynamic hoursTaken;
  dynamic macAddress;
  dynamic testType;
  String? assignedBy;
  String? testedBy;
  dynamic testedDate;
  dynamic testName;
  String? testResult;
  dynamic testStage;
  String? serialNo;

  NewWorkorderbasedReport({
    this.workorderId,
    this.workOrder,
    this.productId,
    this.productName,
    this.productCode,
    this.startSerialNo,
    this.endSerialNo,
    this.spendTime,
    this.hoursTaken,
    this.macAddress,
    this.testType,
    this.assignedBy,
    this.testedBy,
    this.testedDate,
    this.testName,
    this.testResult,
    this.testStage,
    this.serialNo,
  });


}
