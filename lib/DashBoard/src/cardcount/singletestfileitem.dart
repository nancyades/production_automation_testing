import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/Provider/post_provider/singletest_provider.dart';

class singletestFileItem extends ConsumerStatefulWidget {

  final String? product;
  final String? productserial;
  final String? testresult;
  final String? testdate;
  final String? testreport;


  singletestFileItem({
    this.product,
    this.productserial,
    this.testresult,
    this.testdate,
    this.testreport

  });




  @override
  ConsumerState<singletestFileItem> createState() => _singletestFileItemState();
}

class _singletestFileItemState extends ConsumerState<singletestFileItem> {
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
                              child: Text( widget.product.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.productserial!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.testresult!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text( widget.testdate!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: (){

                                },
                                child: Text( "https//link_to_open_report",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                        color: Colors.blue)),
                              ),
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
