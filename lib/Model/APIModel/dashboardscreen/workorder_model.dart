
class AllWorkorder {
  int? workorderId;
  String? workOrder;
  int? workOrderQty;
  String? startingSerialNumber;
  String? endingSerialNumber;
  int? totalTestUnit;
  String? testStartDate;
  String? testEndDate;
  int? qtyPassed;
  int? qtyFailed;
  String? testingStatus;

  AllWorkorder({
     this.workorderId,
     this.workOrder,
     this.workOrderQty,
     this.startingSerialNumber,
     this.endingSerialNumber,
     this.totalTestUnit,
     this.testStartDate,
     this.testEndDate,
     this.qtyPassed,
     this.qtyFailed,
     this.testingStatus,
  });

}




class workprogess {
  int? productId;
  dynamic productCode;
  dynamic productName;
  int? productQty;
  int? workorderId;
  String? workOrder;
  int? workOrderQty;
  String? startingSerialNumber;
  String? endingSerialNumber;
  int? totalTestUnit;
  dynamic testStartDate;
  dynamic testEndDate;
  int? qtyPassed;
  int? qtyFailed;
  dynamic testingStatus;

  workprogess({
     this.productId,
     this.productCode,
     this.productName,
     this.productQty,
     this.workorderId,
     this.workOrder,
     this.workOrderQty,
     this.startingSerialNumber,
     this.endingSerialNumber,
     this.totalTestUnit,
     this.testStartDate,
     this.testEndDate,
     this.qtyPassed,
     this.qtyFailed,
     this.testingStatus,
  });

}



class Work_order_progress_report {
  int? workorderId;
  String? workOrder;
  int? workOrderQty;
  List<PproductwiseWoReport>? pproductwiseWoReport;

  Work_order_progress_report({
     this.workorderId,
     this.workOrder,
     this.workOrderQty,
     this.pproductwiseWoReport,
  });

}

class PproductwiseWoReport {
  int? workorderId;
  int? productId;
  String? productCode;
  String? productName;
  int? productQty;
  String? startingSerialNumber;
  String? endingSerialNumber;
  int? totalTestUnit;
  String? testStartDate;
  String? testEndDate;
  int? qtyPassed;
  int? qtyFailed;
  String? testingStatus;

  PproductwiseWoReport({
    this.workorderId,
    this.productId,
    this.productCode,
    this.productName,
    this.productQty,
    this.startingSerialNumber,
    this.endingSerialNumber,
    this.totalTestUnit,
    this.testStartDate,
    this.testEndDate,
    this.qtyPassed,
    this.qtyFailed,
    this.testingStatus,
  });


}

