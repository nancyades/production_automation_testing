import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskListItems extends StatefulWidget {
  final String? username;
  final String? product;
  final String? workorder;
  final String? quantity;
  final String? startserial;
  final String? endserial;
  final String? status;

  TaskListItems({
    this.username,
    this.product,
    this.workorder,
    this.quantity,
    this.startserial,
    this.endserial,
    this.status
  });


  @override
  State<TaskListItems> createState() => _TaskListItemsState();
}

class _TaskListItemsState extends State<TaskListItems> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (value){
        setState(() {
          hovered = true;
        });
      },
      onExit: (value){
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        margin: EdgeInsets.all( 1.0),
        padding: EdgeInsets.all(9.0),

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: hovered ?
            [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 13.0,
                  spreadRadius: 0.0
              )
            ]
                :[]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.username.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.product.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.workorder.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.quantity.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.startserial.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.endserial.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.status.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.black))),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
