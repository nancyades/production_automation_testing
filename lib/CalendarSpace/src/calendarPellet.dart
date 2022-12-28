import 'package:flutter/material.dart';


List<int> dates = [21,22,23,24,25,26,27];
List<String> days = ['M', 'T', 'W', 'T', 'F','S','S'];
class CalendarPellet extends StatelessWidget {
  final int? date;
  final String? day;

  CalendarPellet({
    this.date,
    this.day,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: 25.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: (date == 24)? Colors.amber : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 7.5,
            spreadRadius: 1.0,
            color: Colors.black12
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text(
                date.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 11.0,
                  color:  (date == 24)? Colors.white : Colors.black,
                )
            ),
          Text(
             day!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11.0,
                color:  (date == 24)? Colors.white : Colors.black,
              )
          ),


        ],
      ),
    );
  }
}
