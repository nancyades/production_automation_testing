import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/res/theme.dart';
import 'Database/Curd_operation/HiveModel/usermanagement.dart';
import 'Database/Curd_operation/HiveModel/usermodel.dart';





void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserManagementmodelAdapter());
  await Hive.openBox<UserManagementmodel>('pat');

  runApp(const ProviderScope(child: AppTheme()));
}

