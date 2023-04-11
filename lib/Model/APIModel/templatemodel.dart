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
    this.productid,
  });

  int? templateId;
  String? templateName;
  String? filePath;
  int? createdBy;
  int? updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;
  String? remarks;
  String? productid;

}
