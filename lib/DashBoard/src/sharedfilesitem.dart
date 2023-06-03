import 'package:flutter/material.dart';

class SharedFilesItem extends StatefulWidget {

  final String? product;
  final String? template;
  final String? createdby;
  final String? releseddate;

      SharedFilesItem({

     this.product,
     this.template,
     this.createdby,
     this.releseddate,
  });



  @override
  State<SharedFilesItem> createState() => _SharedFilesItemState();
}

class _SharedFilesItemState extends State<SharedFilesItem> {
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
                              child: Text( widget.product!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.template!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.createdby!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.releseddate!.split("T")[0],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          /* Center(
                                      child: Icon(Icons.search)
                                    ),*/

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
