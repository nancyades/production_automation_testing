import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TaskCardView extends StatefulWidget {
  final Color? color;
  final Color? progressIndicatorColor;
  final String? projectName;
  final String? peopleCount;
  final String? percentComplete;
  final IconData? icon;

  TaskCardView(
      {this.color,
      this.progressIndicatorColor,
      this.projectName,
      this.peopleCount,
      this.percentComplete,
      this.icon});

  @override
  State<TaskCardView> createState() => _TaskCardViewState();
}

class _TaskCardViewState extends State<TaskCardView> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        height: hovered ? 170.0 : 165.0,
        width: hovered ? 120.0 : 115.0,
        decoration: BoxDecoration(
            color: hovered ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 20.0, spreadRadius: 5.0)
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 15.0,
                    width: 15.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.white : Colors.black,
                      size: 10.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: hovered ? Colors.white : Colors.black
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      widget.projectName!,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 10.0,
                          color: hovered ? Colors.white : Colors.black
                      ),

                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Container(
                    height: 13.0,
                    width: 13.0,
                    child: Icon(
                      Feather.anchor,
                      size: 13.0,
                      color: hovered ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    child: Text(
                      widget.peopleCount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: hovered ? Colors.white : Colors.black
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3.0, left: 45.0),
                  child: Text(
                      widget.percentComplete!,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.5,
                          color: hovered ? Colors.white : Colors.black
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 275),
                        margin: EdgeInsets.only(top: 5.0),
                        height: 4.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: hovered ? widget.progressIndicatorColor : Color(
                              0xffF5F6FA),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 275),
                            height: 6.0,
                            width: (double.parse(
                                widget.percentComplete!.substring(0, 1)) / 10) * 160.0,
                            decoration: BoxDecoration(
                                color: hovered ? Colors.white : widget.color,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),



           /* Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 15.0,
                    width: 15.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.white : Colors.black,
                      size: 10.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: hovered ? Colors.white : Colors.black
                    ),
                  ),
                ),
              ],
            ),
            ClipOval(
              child: Center(
                child: Text(
                  widget.peopleCount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Colors.black),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 275),
              margin: EdgeInsets.only(top: 5.0),
              height: 4.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: hovered
                    ? widget.progressIndicatorColor
                    : Color(0xffF5F6FA),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 275),
                  height: 6.0,
                  width:
                      (double.parse(widget.percentComplete!.substring(0, 1)) /
                              10) *
                          160.0,
                  decoration: BoxDecoration(
                      color: hovered ? Colors.white : widget.color,
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
