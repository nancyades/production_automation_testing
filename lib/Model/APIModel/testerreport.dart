
class TesterReportModel {
  TesterReportModel({
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
    this.testedBy,
    this.testedDate,
    this.testname,
    this.testResult,
    this.testStage,
    this.serial_no
  });

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
  String? testedBy;
  dynamic testedDate;
  dynamic testname;
  String? testResult;
  String? testStage;
  String? serial_no;

}




