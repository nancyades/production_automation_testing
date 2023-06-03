
class workorderunderproduct {
  int? productId;
  String? productCode;
  String? productName;
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

  workorderunderproduct({
    this.productId,
    this.productCode,
    this.productName,
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
