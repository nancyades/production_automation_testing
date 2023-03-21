import 'package:hive/hive.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/templatemodel.dart';
import 'HiveModel/productmodel.dart';
import 'HiveModel/usermanagement.dart';
import 'HiveModel/workordermodel.dart';


class Products{
  static Box<ProductModel> getProducts() =>
      Hive.box<ProductModel>('product');
}

class Templates{
  static Box<TemplateModel> getTemplate() =>
      Hive.box<TemplateModel>('template');
}

class Usersvalue{
  static Box<UserManagementmodel> getUsers() =>
      Hive.box<UserManagementmodel>('users');
}

class WorkOrders{
  static Box<WorkOrderModel> getWorkorders() =>
      Hive.box<WorkOrderModel>('work_orders');
}
