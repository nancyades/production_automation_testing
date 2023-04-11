class Templatemodel{
  String? templatename;
  String? filepath;
  String? templateremarks;

  Templatemodel({
    this.templatename,
    this.filepath,
    this.templateremarks,
});

}


class ProductList{
  double? productid;
  String? productname;
  double? quantity;
  String? startserial;
  String? endserial;

  ProductList({
    this.productid,
    this.productname,
    this.quantity,
    this.startserial,
    this.endserial
});
}