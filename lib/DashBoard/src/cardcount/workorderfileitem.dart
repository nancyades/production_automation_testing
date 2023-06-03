import 'package:flutter/material.dart';

class workorderFileItem extends StatefulWidget {

  final String? workorder;
  final String? quantity;
  final String? startserial;
  final String? endserial;
  final String? status;

  workorderFileItem({

    this.workorder,
    this.quantity,
    this.startserial,
    this.endserial,
    this.status
  });




  @override
  State<workorderFileItem> createState() => _workorderFileItemState();
}

class _workorderFileItemState extends State<workorderFileItem> {
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
        //margin: EdgeInsets.only(bottom: 10.0,left: 40.0, right: 15.0),
        padding: EdgeInsets.all(10.0),

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
        child: Column(
          children: [
            Container(

              child: Row(

                children: [

                  Expanded(
                    child: Center(

                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text( widget.workorder!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.quantity!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.startserial!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.endserial!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.status!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),


                        ],
                      ),

                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
