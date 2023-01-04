import 'package:hive/hive.dart';

part 'usermanagement.g.dart';

@HiveType(typeId: 0)
class UserManagementmodel extends HiveObject{

  @HiveField(0)
  String? emp_id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? password;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? phoneno;

  @HiveField(5)
  bool? isActive = true;

  UserManagementmodel({this.emp_id, this.name, this.password,  this.email, this.phoneno, this.isActive});



}

