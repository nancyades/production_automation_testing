import 'package:hive/hive.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/usermodel.dart';

import 'HiveModel/usermanagement.dart';


class Boxes{
  static Box<UserManagementmodel> getUsers() =>
      Hive.box<UserManagementmodel>('pat');
}
