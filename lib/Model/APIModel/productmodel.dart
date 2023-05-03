
import 'package:production_automation_testing/Model/APIModel/templatemodel.dart';

class Productmodel {
  Productmodel({
     this.productId,
     this.productName,
     this.productCode,
     this.description,
     this.templateId,
     this.quantity,
     this.status,
     this.createdBy,
     this.updatedBy,
     this.createdDate,
     this.updatedDate,
     this.flg,
     this.remarks,
     this.timeRequired,
     this.macAddress,
    this.template
  });

  int? productId;
  String? productName;
  String? productCode;
  String? description;
  int? templateId;
  int? quantity;
  String? status;
  int? createdBy;
  int?updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  int? flg;
  String? remarks;
  int? timeRequired;
  String? macAddress;
  List<Template>? template;

}
