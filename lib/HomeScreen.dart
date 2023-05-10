import 'package:flutter/material.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/Provider/post_provider/tasklist_provider.dart';
import 'package:production_automation_testing/noofpages/Report/Report_screen.dart';
import 'package:production_automation_testing/noofpages/Test/tasklistscreen.dart';
import 'package:production_automation_testing/noofpages/dashboardscreenpage.dart';
import 'package:production_automation_testing/noofpages/Task/taskpage.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/workorderscreenpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/noofpages/Product/product.dart';
import 'package:production_automation_testing/noofpages/setting/settingpage.dart';



import 'NavigationBar/navigationbar.dart';
import 'Provider/navigation_provider.dart';
import 'noofpages/Test/firsrtaskviewpage.dart';
import 'noofpages/Users/user.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final screen = [
    DashboardScreenPage(),
    WorkOrderScreenPage(),
    ProductPage(),
    TaskPage(),
    UserPage(),
    TaskListPage(),
    SettingPage(),
    Reportscreen()
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Navigationbar(),
          Expanded(
              child: Consumer(builder: (context, ref, child) {
                final currentIndex = ref.watch(navNotifier);
                dynamic selectedScreeen = screen[currentIndex];
                return selectedScreeen;
              }))
        ],

      ),
    );
  }
}
