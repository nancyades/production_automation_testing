import 'package:production_automation_testing/Model/readexcelmodel.dart';

class Template {
  Template({
    this.templateId,
    this.templateName,
    this.filePath,
    this.createdBy,
    this.updatedBy,
    this.createdDate,
    this.updatedDate,
    this.flg,
    this.remarks,
    this.excelread,
    this.productid,
  });

  int? templateId;
  String? templateName;
  String? filePath;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;
  String? remarks;
  List<ExcelRead>? excelread;
  String? productid;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_id'] = templateId;
    data['template_name'] = templateName;
    data['file_path'] = filePath;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['flg'] = flg;
    data['remarks'] = remarks;
    data['product_id'] = productid;

    return data;
  }

}




