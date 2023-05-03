

class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.description,
    required this.templateId,
    required this.quantity,
    required this.status,
    required this.createdBy,
    required this.updatedBy,
    required this.createdDate,
    required this.updatedDate,
    required this.flg,
    required this.remarks,
    required this.timeRequired,
    required this.macAddress,
   this.template,
  });

  int productId;
  String productName;
  String productCode;
  String description;
  int templateId;
  int quantity;
  String status;
  int createdBy;
  int updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int flg;
  String remarks;
  int timeRequired;
  String macAddress;
  List<Templatereadexcel>? template;


}

class Templatereadexcel {
  Templatereadexcel({
    required this.templateId,
    required this.templateName,
    required this.filePath,
    required this.createdBy,
    required this.updatedBy,
    required this.createdDate,
    required this.updatedDate,
    required this.flg,
    required this.remarks,
    required this.excelRead,

  });

  int templateId;
  String templateName;
  String filePath;
  int createdBy;
  int updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int flg;
  String remarks;
  List<ExcelRead> excelRead;



}

class ExcelRead {
  ExcelRead({
    this.testNumber,
    this.testType,
    this.testName,
    this.isOnline,
    this.type,
    this.packetId,
    this.pktType,
    this.userEntry,
    this.wifiResult,
    this.passCrieteria,
    this.remarks,
    this.isSelected

  });

  String? testNumber;
  String? testType;
  String? testName;
  String? isOnline;
  String? type;
  String? packetId;
  String? pktType;
  String? userEntry;
  String? wifiResult;
  String? passCrieteria;
  String? remarks;
  bool? isSelected = false ;


}
