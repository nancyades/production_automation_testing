class ExcelModel {
  String? testNumber;
  String? testTitle;
  String? testContent;
  String? testMode;
  String? testType;
  bool? isOnlineTest;
  String? testUserEntry;
  String? testUserWifiResult;
  String? testUserPassCrieteria;
  String? testRemark;
  String? testSelectedOption;
  String? result = '';
  String? packetId;
  String? displayResult = 'UNDEFINED';
  String? userAckValue ;
  String? packetType;
  String? remarks;
  String? workOrderId;


  ExcelModel(
      {this.testNumber,
        this.testTitle,
        this.testContent,
        this.testMode,
        this.testType,
        this.isOnlineTest,
        this.packetId,
        this.packetType,
        this.testSelectedOption,
        this.testUserEntry,
        this.testUserWifiResult,
        this.testUserPassCrieteria,
        this.testRemark,
        this.displayResult,
        this.result,
        this.remarks,
        this.workOrderId});


  setResult(var value){
    result = value;
  }

  setRemarks(var values){
    remarks = values;
  }

  setDisplayResult(var value){
    displayResult = value;
  }

  setSelectedOption(var val) {
    testSelectedOption = val;
  }

  setUserAckVal (var val) {
    userAckValue = val;
  }
}