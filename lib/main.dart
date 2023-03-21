import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/res/theme.dart';

import 'Database/Curd_operation/HiveModel/productmodel.dart';
import 'Database/Curd_operation/HiveModel/templatemodel.dart';
import 'Database/Curd_operation/HiveModel/usermanagement.dart';
import 'Database/Curd_operation/HiveModel/workordermodel.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  /* Hive.registerAdapter(WorkorderModelAdapter());
   await Hive.openBox<WorkorderModel>('workorders');*/
   Hive.registerAdapter(ProductModelAdapter());
   await Hive.openBox<ProductModel>('product');
   Hive.registerAdapter(TemplateModelAdapter());
   await Hive.openBox<TemplateModel>('template');
  Hive.registerAdapter(UserManagementmodelAdapter());
  await Hive.openBox<UserManagementmodel>('users');
  Hive.registerAdapter(WorkOrderModelAdapter());
  await Hive.openBox<WorkOrderModel>('work_orders');




  runApp(const ProviderScope(child: AppTheme()));
}

