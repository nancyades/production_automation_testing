
class ProductReportmodel {
  ProductReportmodel({
    this.productId,
    this.productName,
    this.productTemplate,
    this.createdBy,
    this.releasedDate,
    this.status,

  });

  int? productId;
  String? productName;
  String? productTemplate;
  String? releasedDate;
  String? status;
  String? createdBy;

}
