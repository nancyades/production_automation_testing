import 'package:hive/hive.dart';

part 'usermanagement.g.dart';

@HiveType(typeId: 0)
class UserManagementmodel extends HiveObject{

  @HiveField(0)
  String? user_id;

  @HiveField(1)
  String? emp_id;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? password;

  @HiveField(4)
  String? avatar_id;

  @HiveField(5)
  String? emailid;

  @HiveField(6)
  String? phoneno;

  @HiveField(7)
  String? role;

  @HiveField(8)
  String? created_by;

  @HiveField(9)
  String? updated_by;

  @HiveField(10)
  String? created_date;

  @HiveField(11)
  String? updated_date;

  @HiveField(12)
  bool? flg;

  UserManagementmodel({this.user_id,
    this.emp_id,
    this.name,
    this.password,
    this.avatar_id,
    this.emailid,
    this.phoneno,
    this.role,
    this.created_by,
    this.updated_by,
    this.created_date,
    this.updated_date,
    this.flg
  });



}