import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestTaskListItems extends StatefulWidget {
  final String? Workorder;
  final String? quantity;
  final String? createdby;
  final String? status;
  final String? testingstatus;


  TestTaskListItems({
    this.Workorder,
    this.quantity,
    this.createdby,
    this.status,
    this.testingstatus
  });


  @override
  State<TestTaskListItems> createState() => _TestTaskListItemsState();
}

class _TestTaskListItemsState extends State<TestTaskListItems> {
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
                child: Center(child: Text(widget.Workorder.toString(),
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
                child: Center(child: Text(widget.createdby.toString(),
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
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(widget.testingstatus.toString(),
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
