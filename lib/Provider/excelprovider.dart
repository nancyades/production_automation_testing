import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/templatemodel.dart';
import '../Model/APIModel/productcount.dart';
import '../Model/APIModel/productmodel.dart';
import '../Model/APIModel/productreport.dart';
import '../Model/APIModel/taskcount.dart';
import '../Model/APIModel/taskmodel.dart';
import '../Model/APIModel/usercountmodel.dart';
import '../Model/APIModel/usermodel.dart';
import '../Model/APIModel/workordercount.dart';
import '../Model/APIModel/workordermodel.dart';
import '../Model/APIModel/workorderprogressreport.dart';
import '../Model/readexcel/readecel.dart';
import '../service/apiservice.dart';

/*
final gettesttypeNotifier = FutureProvider<List<Testtype>>((ref) async {
  return await ref.read(apiProvider).getTestType();
});
*/



final getfirsttestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getFirstTest();
});


final getsecondtestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getSecondTest();
});

final getthirdtestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getThirdTest();
});

final getfourthtestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getFourthTest();
});

final getfivthtestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getFivthTest();
});

final getsixthtestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getSixthTest();
});


final getseventhtestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getSeventhTest();
});

final getallestNotifier = FutureProvider<List<FirstTest>>((ref) async {
  return await ref.read(apiProvider).getAllTest();
});



final getUserNotifier = FutureProvider<List<Users>>((ref) async {
  return await ref.read(apiProvider).getUsers();
});



final getWorkorderNotifier = FutureProvider<List<WorkorderModel>>((ref) async {
  return await ref.read(apiProvider).getWorkOrders();
});



final getProductNotifier = FutureProvider<List<Productmodel>>((ref) async {
  return await ref.read(apiProvider).getProducts();
});

final getTemplateNotifier = FutureProvider<List<Template>>((ref) async {
  return await ref.read(apiProvider).getTemplate();
});

final getTaskNotifier = FutureProvider<List<TaskModel>>((ref) async {
  return await ref.read(apiProvider).getTask();
});



final getNewTaskNotifier = FutureProvider<List<TaskNewModel>>((ref) async {
  return await ref.read(apiProvider).getNewTask();
});

final getUserCountNotifier = FutureProvider<List<UserCountModel>>((ref) async {
  return await ref.read(apiProvider).getCountUser();
});


final getWorkorderCountNotifier = FutureProvider<List<WorkorderCount>>((ref) async {
  return await ref.read(apiProvider).getWorkorderCount();
});


final getProductCountNotifier = FutureProvider<List<ProductCount>>((ref) async {
  return await ref.read(apiProvider).getProductCount();
});


final getTaskCountNotifier = FutureProvider<List<TaskCount>>((ref) async {
  return await ref.read(apiProvider).getTaskCount();
});


final getProductReportNotifier = FutureProvider<List<ProductReportmodel>>((ref) async {
  return await ref.read(apiProvider).getProductsreport();
});





