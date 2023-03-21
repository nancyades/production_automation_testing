import 'package:hive/hive.dart';

part 'templatemodel.g.dart';

@HiveType(typeId: 3)
class TemplateModel extends HiveObject {
  @HiveField(0)
  String? Template_ID;

  @HiveField(1)
  String? Template_Name;

  @HiveField(2)
  String? File_Path;

  @HiveField(3)
  String? Created_By;

  @HiveField(4)
  String? Updated_By;

  @HiveField(5)
  String? Created_date;

  @HiveField(6)
  String? Updated_date;

  @HiveField(7)
  bool? Flg = true;

  @HiveField(8)
  String? Remarks;


  TemplateModel({
       this.Template_ID,
        this.Template_Name,
        this.File_Path,
        this.Created_By,
        this.Updated_By,
        this.Created_date,
        this.Updated_date,
        this.Flg,
        this.Remarks});
}
