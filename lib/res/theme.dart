import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:production_automation_testing/HomeScreen.dart';
import 'package:production_automation_testing/LoginPage/loginscreen.dart';



import 'appColors.dart';
import 'appId.dart';



class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: AppColors.primarySwatch,
              accentColor: Colors.red,
              backgroundColor: Colors.pink,
              primaryColorDark: Colors.orange),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          )),
      initialRoute: AppId.initialRoute,
      routes: <String, WidgetBuilder>{
        AppId.LoginScreen: (context) => const LoginScreen(),
        AppId.HomeScreenPage: (context) => const HomeScreenPage(),
       // AppId.ConfigurationList: (context) =>  ConfigurationList(),
       // AppId.SmartConfigID: (context) => const SmartConfig(),
       // AppId.DashBoard: (context) => const DashBoard(),
       // AppId.DashboardID: (context) => const DashBoardScreen(),
       // AppId.Schedule: (context) => const Schedule(),

      },
    );
  }
}