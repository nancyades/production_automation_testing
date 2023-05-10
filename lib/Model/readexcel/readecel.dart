class Testtype{
  String? testType;
  bool  ? isSelected = false;

  Testtype({
    this.testType,
    this.isSelected
  });

  selectTest(bool val) {
    isSelected = val;
  }
}

class FirstTest{
  String? testnumber;
  String? testtype;
  String? testname;
  dynamic isonline;
  String? type;
  dynamic? packetid;
  dynamic packettype;
  String? userentry;
  String? wifiresult;
  String? passcrieteria;
  String? remarks;
  String? result = '';
  String? radiotype;
  String? displayResult = 'UNDEFINED';
  String? userAckValue ;
  bool? isSelected = false ;



  FirstTest({
  this.testnumber,
  this.testtype,
  this.testname,
  this.isonline,
  this.type,
  this.packetid,
  this.packettype,
  this.passcrieteria,
  this.wifiresult,
  this.remarks,
  this.userentry,
  this.radiotype,
  this.displayResult,
  this.result,
  this.userAckValue, this.isSelected,

});



  setDisplayResult(var value){
    displayResult = value;
  }

  setResult(var value){
    result = value;
  }

  setRemarks(var values){
    remarks = values;
  }

  setUserAckVal (var val) {
    userAckValue = val;
  }

}



