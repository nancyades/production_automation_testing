import 'package:flutter/material.dart';
import 'package:production_automation_testing/CalendarSpace/src/calendarsection.dart';
import 'package:production_automation_testing/CalendarSpace/src/meetingsection.dart';
import 'package:production_automation_testing/CalendarSpace/src/topcontainer.dart';

class Calendarspace extends StatelessWidget {
  const Calendarspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        //color: Color(0xffa4cfed),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.29,
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            TopContainer(),
            CalenderSection(),
            MeetingSection(),

            ClipRRect(
                child: Image.asset('assets/images/raxlogo.png', height: 300.0,
                  width: 400.0,)

            )
          ],
        ),
      ),
    );
  }
}
