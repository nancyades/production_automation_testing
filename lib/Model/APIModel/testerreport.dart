
class TesterReportModel {
  TesterReportModel({
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
    required this.testname,
    required this.testResult,
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
  String testname;
  String testResult;


}
