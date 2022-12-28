import 'package:flutter/material.dart';
import '../CalendarSpace/calendarspace.dart';
import '../DashBoard/dashboard.dart';
import '../NavigationBar/navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
           Navigationbar(),
            DashBoard(),
            Calendarspace()
          ],
        ),
      ),
    );
  }
}
