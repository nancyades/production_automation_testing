class TestModel {
  String? testTitle;
  String? taskId;
  bool? isSelected = false;

  // for assaign
  String? userId;
  String? productId;
  String? workorderId;

  bool? woSlected = false;
  String? woTitle;
  String? filePath;
  String? testIdentifyType;

  TestModel({this.testTitle, this.taskId, this.isSelected, this.userId,
    this.productId, this.workorderId, this.filePath, this.woTitle, this.testIdentifyType});

  selectTest(bool val) {
    isSelected = val;
  }

  selectWo(bool val) {
    woSlected = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_id'] = userId;
    data['task_id'] = taskId;
    data['product_id'] = productId;
    data['workorder_id'] = workorderId;
    return data;
  }
}


/*class Test {
  String? testTitle;
  bool? isSelected = false;

  Test({this.testTitle,  this.isSelected});

  selectTest(bool val) {
    isSelected = val;
  }

}*/
class radTest {
  String? testid;
  String? testname;
  String? radiotype;
  String? result;

  radTest({this.testid,this.testname,this.radiotype,this.result});

  selectTest1(String val1) {
    radiotype= val1;
  }


}