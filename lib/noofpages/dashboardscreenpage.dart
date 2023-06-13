import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:production_automation_testing/DashBoard/src/cardcount/singletestfileitem.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/Provider/post_provider/singletest_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/tasklist_provider.dart';
import '../CalendarSpace/calendarspace.dart';
import '../DashBoard/src/ProjectCardOverview.dart';
import '../DashBoard/src/cardcount/workorderfileitem.dart';
import '../DashBoard/src/projectStatisticsCards.dart';
import '../DashBoard/src/sharedfilesitem.dart';
import '../DashBoard/src/subheader.dart';
import '../DashBoard/src/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Helper/helper.dart';

class DashboardScreenPage extends ConsumerStatefulWidget {
  const DashboardScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreenPage> createState() => _DashboardScreenPageState();
}

class _DashboardScreenPageState extends ConsumerState<DashboardScreenPage> {

  bool prod = true;
  bool work = false;

  var inprogress;
  var complete;





  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "On going Project",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),

                      ],
                    ),
                  ),
                  Helper.sharedRoleId == "Test User"
                      ?  Consumer(
                      builder: (context, ref, child) {
                        return ref.watch(getTaskListNotifier).id.when(data: (count) {
                          inprogress =  count.where((element) => element.status == "In-Progress").toList();
                          complete   =  count.where((element) => element.status == "Completed").toList();


                          return Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Card(
                                elevation: 12,
                                child: Container(
                                  width: 170,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.white10,
                                            spreadRadius: 10,
                                            blurRadius: 12)
                                      ],
                                      border: Border.all(color: Colors.grey),
                                      backgroundBlendMode: BlendMode.darken,
                                      color: Colors.white,
                                      shape: BoxShape.rectangle
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${count.length}%",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .deepOrange
                                                                  .shade300
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Total Task",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .black
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Icon(Icons.bar_chart)
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),


                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 168,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                shape: BoxShape.rectangle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(
                                                    Icons.call_made, size: 16,),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 12,
                                child: Container(
                                  width: 170,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.white10,
                                            spreadRadius: 10,
                                            blurRadius: 12)
                                      ],
                                      border: Border.all(color: Colors.grey),
                                      backgroundBlendMode: BlendMode.darken,
                                      color: Colors.white,
                                      shape: BoxShape.rectangle
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${inprogress.length}%",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .green
                                                                  .shade300
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("In-Progress",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .black
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Icon(Icons.incomplete_circle)
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 168,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.rectangle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(
                                                    Icons.call_made, size: 16,),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 12,
                                child: Container(
                                  width: 170,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.white10,
                                            spreadRadius: 10,
                                            blurRadius: 12)
                                      ],
                                      border: Border.all(color: Colors.grey),
                                      backgroundBlendMode: BlendMode.darken,
                                      color: Colors.white,
                                      shape: BoxShape.rectangle
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${complete.length}%",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .amber
                                                                  .shade300
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Completed",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .black
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Icon(Icons.thumb_up)
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 168,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                shape: BoxShape.rectangle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(
                                                    Icons.call_made, size: 16,),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }, error: (e, s) {
                          return Text(e.toString());
                        }, loading: () {
                          return CircularProgressIndicator();
                        });
                      }
                  )

                  : Helper.sharedRoleId == "Design User"

                  ? Consumer(
                      builder: (context, ref, child) {
                        return ref.watch(getProductCountNotifier).when(data: (count){
                          return Container(
                            margin: EdgeInsets.only(top: 5.0),
                            height: 218.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child:SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children:[
                                              Card(
                                                elevation:12,
                                                child: Container(
                                                  width:200,
                                                  height:100,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                      border: Border.all(color: Colors.grey),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text("${count[0].created}%",  style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 15.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text("Created", style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 10.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.incomplete_circle, size: 20,)
                                                                ],
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),


                                                      SizedBox(
                                                        height: 14,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width:198,
                                                            height:36,
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                shape: BoxShape.rectangle
                                                            ),
                                                            child:  Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('% change'),
                                                                  Icon(Icons.call_made, size: 12,),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                elevation:12,
                                                child: Container(
                                                  width:200,
                                                  height:100,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                      border: Border.all(color: Colors.grey),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text("${count[0].verified}%",  style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 15.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text("verified", style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 9.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.admin_panel_settings_outlined,size: 20,)
                                                                ],
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),


                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width:198,
                                                            height:36,
                                                            decoration: BoxDecoration(
                                                                color: Colors.amber,
                                                                shape: BoxShape.rectangle
                                                            ),
                                                            child:  Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('% change'),
                                                                  Icon(Icons.call_made, size: 12,),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                elevation:12,
                                                child: Container(
                                                  width:200,
                                                  height:100,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                      border: Border.all(color: Colors.grey),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text("${count[0].approved}%",  style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 15.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text("Approved", style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 10.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.task,size: 20,)
                                                                ],
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),


                                                      SizedBox(
                                                        height: 14,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width:198,
                                                            height:36,
                                                            decoration: BoxDecoration(
                                                                color: Colors.blue,
                                                                shape: BoxShape.rectangle
                                                            ),
                                                            child:  Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('% change'),
                                                                  Icon(Icons.call_made, size: 12,),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                elevation:12,
                                                child: Container(
                                                  width:200,
                                                  height:100,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                      border: Border.all(color: Colors.grey),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text("${count[0].rejected}%",  style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 15.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text("Rejected", style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 10.0,
                                                                          color:  Colors.black
                                                                      ))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.account_circle_outlined,size: 20)
                                                                ],
                                                              ),

                                                            ),
                                                          ],
                                                        ),
                                                      ),


                                                      SizedBox(
                                                        height: 14,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width:198,
                                                            height:36,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                shape: BoxShape.rectangle
                                                            ),
                                                            child:  Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('% change'),
                                                                  Icon(Icons.call_made, size: 12,),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),

                                      ],
                                    ),
                                  ),
                                )],
                            ),
                          );

                        }, error: (e,s){
                          return Text(e.toString());
                        }, loading: (){
                          return CircularProgressIndicator();
                        });

                      }
                  )
                 : Consumer(builder: (context, ref, child) {
                    return ref.watch(getUserCountNotifier).when(data: (count) {

                      return Container(
                        margin: EdgeInsets.only(top: 5.0),
                        height: 218.0,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(

                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Card(
                                    elevation: 12,
                                    child: Container(
                                      width: 200,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white10,
                                                spreadRadius: 10,
                                                blurRadius: 12)
                                          ],
                                          border: Border.all(
                                              color: Colors.grey),
                                          backgroundBlendMode:
                                          BlendMode.darken,
                                          color: Colors.white,
                                          shape: BoxShape.rectangle),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${Helper.usercount}%",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15.0,
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Users",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  10.0,
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.bar_chart,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 198,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    color:
                                                    Colors.deepOrange,
                                                    shape:
                                                    BoxShape.rectangle),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text('% change'),
                                                      Icon(
                                                        Icons.call_made,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 12,
                                    child: Container(
                                      width: 200,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white10,
                                                spreadRadius: 10,
                                                blurRadius: 12)
                                          ],
                                          border: Border.all(
                                              color: Colors.grey),
                                          backgroundBlendMode:
                                          BlendMode.darken,
                                          color: Colors.white,
                                          shape: BoxShape.rectangle),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${ Helper.productcount}%",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15.0,
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Product",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  10.0,
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .incomplete_circle,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 198,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    shape:
                                                    BoxShape.rectangle),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text('% change'),
                                                      Icon(
                                                        Icons.call_made,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 12,
                                    child: Container(
                                      width: 200,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white10,
                                                spreadRadius: 10,
                                                blurRadius: 12)
                                          ],
                                          border: Border.all(
                                              color: Colors.grey),
                                          backgroundBlendMode:
                                          BlendMode.darken,
                                          color: Colors.white,
                                          shape: BoxShape.rectangle),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, top: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${Helper.workordercount}%",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15.0,
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("WorkOrder",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  9.0,
                                                                  color: Colors
                                                                      .black))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .admin_panel_settings_outlined,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 198,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape:
                                                    BoxShape.rectangle),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                      8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text('% change'),
                                                      Icon(
                                                        Icons.call_made,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    }, error: (e, s) {
                      return Text(e.toString());
                    }, loading: () {
                      return CircularProgressIndicator();
                    });
                  }),

                  Helper.sharedRoleId == "Test User" || Helper.sharedRoleId == "Design User"
                      ?  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 32.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(Helper.sharedRoleId == "Design User" ? "Product":"Test Report".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff6C6CE5)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Color(0xff6C6CE5))))),
                                  onPressed: () {
                                    setState(() {

                                      //inactive = false;
                                    });
                                  }),

                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                :  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 32.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [

                              ElevatedButton(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("Product".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff6C6CE5)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Color(0xff6C6CE5))))),
                                  onPressed: () {
                                    setState(() {
                                     prod = true;
                                     work = false;
                                     //inactive = false;
                                    });
                                  }),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                  child: Row(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("Workorder".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff6C6CE5)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Color(0xff6C6CE5))))),
                                  onPressed: () {
                                    setState(() {
                                      prod = false;
                                      work = true;
                                    // inactive = false;
                                    });
                                  }),
                              SizedBox(
                                width: 15.0,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Helper.sharedRoleId == "Super Admin"
                      || Helper.sharedRoleId == "Design Admin"
                        || Helper.sharedRoleId == "Test Admin"
                      ? prod == true
                  ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color:Color(0xff333951),
                          //Colors.blueAccent,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 20.0,
                                    width: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(' '),
                                        Expanded(
                                          child: Center(
                                            child: Text("Product",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Template",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Created by",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Release Date",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 450,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 440,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                          ),
                                          color: Color(0xFFd9d8d7),
                                          elevation: 15,
                                          child:  Consumer(

                                              builder: (context, ref, child) {
                                                return ref.watch(getProductReportNotifier).when(data: (data){
                                                  Helper.productcount = data.length;
                                                  return ListView.builder(
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (BuildContext ctxt,
                                                          int index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: SharedFilesItem(
                                                                product: data[index].productName,
                                                                template: data[index].productTemplate,
                                                                createdby: data[index].createdBy,
                                                                releseddate: data[index].releasedDate,
                                                              ),
                                                            ),

                                                          ],
                                                        );
                                                      });
                                                }, error: (e,s){
                                                  return Text(e.toString());
                                                }, loading: (){
                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                }) ;

                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                            )
                          ],
                        ),
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color:Color(0xff333951),
                          //Colors.blueAccent,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 20.0,
                                    width: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(' '),
                                        Expanded(
                                          child: Center(
                                            child: Text("workorder",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Quantity",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Start Serial",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("End Serial",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Status",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 450,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 440,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                          ),
                                          color: Color(0xFFd9d8d7),
                                          elevation: 15,
                                          child:  Consumer(

                                              builder: (context, ref, child) {
                                                return ref.watch(getAllWorkorderReportNotifier).when(data: (data){
                                                  Helper.workordercount = data.length;
                                                  return ListView.builder(
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (BuildContext ctxt,
                                                          int index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: workorderFileItem(
                                                              workorder: data[index].workOrder,
                                                              quantity: data[index].workOrderQty.toString(),
                                                              startserial: data[index].startingSerialNumber,
                                                              endserial: data[index].endingSerialNumber,
                                                              status: data[index].testingStatus == null ? "Not Yet Start" : data[index].testingStatus,
                                                              )

                                                            ),

                                                          ],
                                                        );
                                                      });
                                                }, error: (e,s){
                                                  return Text(e.toString());
                                                }, loading: (){
                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                }) ;

                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                            )
                          ],
                        ),
                      ),
                    ],
                  )

                  :  Helper.sharedRoleId == "Design User"
                  ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color:Color(0xff333951),
                          //Colors.blueAccent,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 20.0,
                                    width: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(' '),
                                        Expanded(
                                          child: Center(
                                            child: Text("Product",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Template",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Created by",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Release Date",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 450,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 440,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                          ),
                                          color: Color(0xFFd9d8d7),
                                          elevation: 15,
                                          child:  Consumer(

                                              builder: (context, ref, child) {
                                                return ref.watch(getProductReportNotifier).when(data: (data){
                                                  return ListView.builder(
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (BuildContext ctxt,
                                                          int index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: SharedFilesItem(
                                                                product: data[index].productName,
                                                                template: data[index].productTemplate,
                                                                createdby: data[index].createdBy,
                                                                releseddate: data[index].releasedDate,
                                                              ),
                                                            ),

                                                          ],
                                                        );
                                                      });
                                                }, error: (e,s){
                                                  return Text(e.toString());
                                                }, loading: (){
                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                }) ;

                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                            )
                          ],
                        ),
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color:Color(0xff333951),
                          //Colors.blueAccent,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 20.0,
                                    width: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(' '),
                                        Expanded(
                                          child: Center(
                                            child: Text("Product",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Product Serial no",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Test Result",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Tested Date",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text("Test Report",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 450,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 440,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                          ),
                                          color: Color(0xFFd9d8d7),
                                          elevation: 15,
                                          child:  Consumer(

                                              builder: (context, ref, child) {


                                                return ref.watch(singletesterReportNotifier).id.when(data: (data){
                                                  return ListView.builder(
                                                      itemCount: data.length,
                                                      itemBuilder:
                                                          (BuildContext ctxt,
                                                          int index) {
                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: singletestFileItem(
                                                                product: data[index].productName,
                                                                productserial: data[index].serial_no,
                                                                testresult: data[index].testResult,
                                                                testdate: data[index].testedDate!.split("T")[0],


                                                              ),
                                                            ),

                                                          ],
                                                        );
                                                      });
                                                }, error: (e,s){
                                                  return Text(e.toString());
                                                }, loading: (){
                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                }) ;

                                              }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                            )
                          ],
                        ),
                      ),
                    ],
                  ),





                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('@copyright rax-tech International 2022',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                  color: Colors.black)),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Calendarspace()
        ),
      ],
    );


  }
}





