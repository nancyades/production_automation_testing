import 'package:flutter/material.dart';
import 'package:production_automation_testing/noofpages/dashboardscreenpage.dart';
import 'package:production_automation_testing/noofpages/Task/taskpage.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/workorderscreenpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/noofpages/Product/product.dart';
import 'package:production_automation_testing/screens/homescreen.dart';


import 'NavigationBar/navigationbar.dart';
import 'Provider/navigation_provider.dart';
import 'noofpages/fivthPage.dart';
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
    FivthPage(),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Navigationbar(),
          Expanded(
              child: Column(
            children: [
              Consumer(builder: (context, ref, child) {
                final currentIndex = ref.watch(navNotifier);
                dynamic selectedScreeen = screen[currentIndex];
                return selectedScreeen;
              }),
            ],
          ))
        ],

      ),
    );
  }
}
