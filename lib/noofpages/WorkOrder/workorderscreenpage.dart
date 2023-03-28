import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/addworkorder.dart';
import '../../DashBoard/src/ProjectCardOverview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../DashBoard/src/cardcount/workordercount.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/HiveModel/workordermodel.dart';
import '../../Database/Curd_operation/boxes.dart';
import '../../Database/Curd_operation/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/APIModel/workordermodel.dart';
import '../../Provider/excelprovider.dart';


class WorkOrderScreenPage extends ConsumerStatefulWidget {
  const WorkOrderScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WorkOrderScreenPage> createState() =>
      _WorkOrderScreenPageState();
}

int? key;
WorkOrderModel? data;
List<WorkOrderModel>? datamodels;

WorkorderModel workorder = WorkorderModel();

class _WorkOrderScreenPageState extends ConsumerState<WorkOrderScreenPage> {
  bool _isShow = false;
  bool chart = true;
  bool searchdropdown = true;

  bool all = true;
  bool create = false;
  bool verify = false;
  bool approve = false;
  bool reject = false;

  var createdvalue;
  var verifiedvalue;
  var approvedvalue;
  var rejectedvalue;


  final List<ChartData> chartData = <ChartData>[
    ChartData(2010, 10.53, 3.3, 0.0),
    ChartData(2011, 9.5, 5.4, 3.8),
    ChartData(2012, 10, 2.65, 4.0),
    ChartData(2013, 9.4, 2.62, 5.0),
    ChartData(2014, 5.8, 1.99, 3.9),
    ChartData(2015, 4.9, 1.44, 1.9),
    ChartData(2016, 4.5, 2, 1.4),
    ChartData(2017, 3.6, 1.56, 1.0),
    ChartData(2018, 3.43, 2.1, 5.9),
  ];

  var selectRole = "Super Admin";
  List<String> roles = [
    'Super Admin',
    'Design Admin',
    'Test Admin',
    'Design User',
    'Test User'
  ];


  @override
  void initState() {
    ref.refresh(getWorkorderNotifier);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;


    /* return ValueListenableBuilder<Box<WorkOrderModel>>(
        valueListenable: WorkOrders.getWorkorders().listenable(),
        builder: (context,
            Box<WorkOrderModel> items, _) {

          datamodels = items.values.toList().cast<WorkOrderModel>();
            createdvalue = items.values
            .where((element) => element.status!.toUpperCase() == "CREATED")
            .toList();
            verifiedvalue = items.values
            .where((element) => element.status!.toUpperCase() == "VERIFIED")
            .toList();
            approvedvalue = items.values
            .where((element) => element.status!.toUpperCase() == "APPROVED")
            .toList();
            rejectedvalue = items.values
                .where((element) => element.status!.toUpperCase() == "REJECTED")
                .toList();*/


    return ref.watch(getWorkorderNotifier).when(
        data: (datum) {
          createdvalue =
              datum.where((element) => element.status!.toUpperCase() ==
                  "CREATED")
                  .toList();
          verifiedvalue =
              datum.where((element) => element.status!.toUpperCase() ==
                  "VERIFIED")
                  .toList();
          approvedvalue =
              datum.where((element) => element.status!.toUpperCase() ==
                  "APPROVED")
                  .toList();
          rejectedvalue =
              datum.where((element) => element.status!.toUpperCase() ==
                  "REJECTED")
                  .toList();
          return Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.63,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Work Order",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            MaterialButton(
                              padding: const EdgeInsets.all(15),
                              onPressed: () {
                                setState(() {
                                  workorder.workorderCode = "";
                                  workorder.quantity = 0;
                                  workorder.startSerialNo = "";
                                  workorder.endSerialNo = "";
                                  workorder.status = "";

                                  _isShow = !_isShow;
                                  chart = !chart;
                                  searchdropdown = !searchdropdown;
                                });
                              },
                              child: const Icon(
                                Icons.open_in_browser_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(getWorkorderCountNotifier).when(data: (count){
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
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                  children:[Card(
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
                                                                          Text("${count[0].wOCount}%",  style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15.0,
                                                                              color:  Colors.black
                                                                          ))
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text("Workorder", style: TextStyle(
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
                                                                      Icon(Icons.bar_chart,size: 20,)
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
                                                                    color: Colors.deepOrange.shade300,
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
                                                                      color: Colors.green.shade300,
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
                                              Padding(padding: EdgeInsets.only(left: 30)),
                                              Column(
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
                                                                      color: Colors.amber.shade300,
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
                                                  ]),
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
                                                                color: Colors.red.shade300,
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


                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: chart,
                                        child: Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.5,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.5,
                                            child: SfCartesianChart(
                                                series: <ChartSeries>[
                                                  SplineAreaSeries<ChartData, int>(
                                                      dataSource: chartData,
                                                      xValueMapper: (ChartData data,
                                                          _) => data.x,
                                                      yValueMapper: (ChartData data,
                                                          _) => data.y
                                                  ),
                                                  SplineAreaSeries<ChartData, int>(
                                                      dataSource: chartData,
                                                      xValueMapper: (ChartData data,
                                                          _) => data.x,
                                                      yValueMapper: (ChartData data,
                                                          _) => data.y1
                                                  ),
                                                  SplineAreaSeries<ChartData, int>(
                                                      dataSource: chartData,
                                                      xValueMapper: (ChartData data,
                                                          _) => data.x,
                                                      yValueMapper: (ChartData data,
                                                          _) => data.y2
                                                  ),
                                                ]
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                            }, error: (e,s){
                              return Text(e.toString());
                            }, loading: (){
                              return CircularProgressIndicator();
                            });

                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    child: Text("All".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
                                    onPressed: () {
                                      setState(() {
                                        all = true;
                                        create = false;
                                        verify = false;
                                        approve = false;
                                        reject = false;
                                      });
                                    }),
                                /* SizedBox(
                                        width: 10.0,
                                      ),*/
                                ElevatedButton(
                                    child: Text("Created".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
                                    onPressed: () {
                                      /* ref.read(ActiveUser.notifier).state =
                            !ref.watch(ActiveUser);*/
                                      setState(() {
                                        all = false;
                                        create = true;
                                        verify = false;
                                        approve = false;
                                        reject = false;
                                      });
                                    }),
                                /*SizedBox(
                                        width: 10.0,
                                      ),*/
                                ElevatedButton(
                                    child: Text("Verified".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
                                    onPressed: () {
                                      setState(() {
                                        all = false;
                                        create = false;
                                        verify = true;
                                        approve = false;
                                        reject = false;
                                      });
                                    }),
                                /* SizedBox(
                                        width: 10.0,
                                      ),*/
                                ElevatedButton(
                                    child: Text("Approved".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
                                    onPressed: () {
                                      /* ref.read(ActiveUser.notifier).state =
                            !ref.watch(ActiveUser);*/
                                      setState(() {
                                        all = false;
                                        create = false;
                                        verify = false;
                                        approve = true;
                                        reject = false;
                                      });
                                    }),
                                /*SizedBox(
                                        width: 10.0,
                                      ),*/
                                ElevatedButton(
                                    child: Text("Rejected".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
                                    onPressed: () {
                                      setState(() {
                                        all = false;
                                        create = false;
                                        verify = false;
                                        approve = false;
                                        reject = true;
                                      });
                                    }),
                                /* SizedBox(
                                        width: 70.0,
                                      ),*/
                              ],
                            ),
                          ),


                          Visibility(
                            visible: searchdropdown,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0),
                                        child: DropdownButton(
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0),
                                            child: Icon(
                                                Icons.keyboard_arrow_down),
                                          ),
                                          items: roles
                                              .map<DropdownMenuItem<String>>((
                                              String setlist) {
                                            return DropdownMenuItem<String>(
                                              value: setlist,
                                              child: Text(setlist.toString()),
                                            );
                                          }).toList(),
                                          value: selectRole,
                                          onChanged: (item) {
                                            setState(() {
                                              selectRole = item.toString();
                                              print("Index==>" + selectRole);
                                              //List<FirstClass> emptylist = [];
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                    child: Icon(Icons.search)
                                ),
                                Container(
                                  width: queryData.size.width * 0.25,
                                  //MediaQuery.of(context).size.width * 0.25,
                                  height: 30,
                                  child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'search',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      onChanged: (String query) {
                                        final suggestions = datamodels!
                                            .where((works) {
                                          final workordercode = works
                                              .workorder_code!.toLowerCase();
                                          final input = query.toLowerCase();
                                          return workordercode.contains(
                                              input);
                                        }).toList();
                                        setState(() =>
                                        datamodels = suggestions);
                                      }
                                    // SearchWorkorders,
                                  ),
                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Color(0xff8fcceb),
                          //Colors.blueAccent,
                          elevation: 10,
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
                                      Expanded(
                                        child: Center(
                                          child: Text("WorkOrder Code",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Quantity",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Start Serial No",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("End Serial No",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      /* Center(
                                      child: Icon(Icons.search)
                                    ),*/
                                      Expanded(
                                          child: Text("")


                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 500,
                                child:  SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 490,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15.0),
                                                ),
                                                color: Color(0xFFd9d8d7),
                                                //Color(0xffcbdff2),
                                                elevation: 15,
                                                child: ListView.builder(
                                                    itemCount: () {
                                                      if (all == true) {
                                                        return datum.length;
                                                      } else
                                                      if (create == true) {
                                                        return createdvalue
                                                            .length;
                                                      } else
                                                      if (verify == true) {
                                                        return verifiedvalue
                                                            .length;
                                                      } else
                                                      if (approve == true) {
                                                        return approvedvalue
                                                            .length;
                                                      } else
                                                      if (reject == true) {
                                                        return rejectedvalue
                                                            .length;
                                                      } else {
                                                        return 0;
                                                      }
                                                    }(),
                                                    itemBuilder: (
                                                        BuildContext ctxt,
                                                        int index) {
                                                      return () {
                                                        if (all == true) {
                                                          return getWorkorderItems(
                                                              datum, index);
                                                        } else
                                                        if (create == true) {
                                                          return getCreatedItems(
                                                              datum, index);
                                                        } else
                                                        if (verify == true) {
                                                          return getVerifiedItems(
                                                              datum, index);
                                                        } else
                                                        if (approve == true) {
                                                          return getApprovedItems(
                                                              datum, index);
                                                        } else if (reject ==
                                                            true) {
                                                          return getRejectedItems(
                                                              datum, index);
                                                        } else {
                                                          return getWorkorderItems(
                                                              datum, index);
                                                        }
                                                      }();
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              )
                            ],
                          ),
                        ),
                      ),


                      Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('@copyright rax-tech International 2022',
                              style: TextStyle(fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                  color: Colors.black)),
                        ],
                      )),

                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _isShow,
                child: Expanded(
                    flex: 5,
                    child: AddWorkOrder(workorderModel: workorder)),
              ),
            ],
          );
        }, error: (e, s) {
      return Text(e.toString());
    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });


    //  });
  }

  getWorkorderItems(List<WorkorderModel> items, int index) {
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color:

                                  items[index].status!.toUpperCase() ==
                                      "CREATED"
                                      ? Colors.blueAccent
                                      : items[index].status!
                                      .toUpperCase() == "VERIFIED"
                                      ? Colors.orange
                                      : items[index].status!
                                      .toUpperCase() == "APPROVED"
                                      ? Colors.green
                                      : Colors.red,


                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(items[index].workorderCode
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(items[index].quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(items[index].startSerialNo
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  items[index].endSerialNo.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                workorder.workorderId = int.parse(
                                    items[index].workorderId.toString());
                                workorder.workorderCode =
                                    items[index].workorderCode.toString();
                                workorder.quantity =
                                    int.parse(items[index].quantity.toString());
                                workorder.startSerialNo =
                                    items[index].startSerialNo.toString();
                                workorder.endSerialNo =
                                    items[index].endSerialNo.toString();
                                workorder.status =
                                    items[index].status.toString();

                                AddWorkOrder(workorderModel: workorder);

                                print("workorder id----------> ${int.parse(
                                    items[index].workorderId.toString())}");


                                chart = false;
                                _isShow = true;
                                searchdropdown = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              //  WorkOrder().deleteworkorder(datamodels[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  getCreatedItems(List<WorkorderModel> items, int index) {
    var createdvalue = items.where((element) =>
    element.status!.toUpperCase() == "CREATED").toList();

    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color:

                                  createdvalue[index].status!.toUpperCase() ==
                                      "CREATED"
                                      ? Colors.blueAccent
                                      : createdvalue[index].status!
                                      .toUpperCase() == "VERIFIED"
                                      ? Colors.orange
                                      : createdvalue[index].status!
                                      .toUpperCase() == "APPROVED"
                                      ? Colors.green
                                      : Colors.red,


                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(createdvalue[index].workorderCode
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(createdvalue[index].quantity
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(createdvalue[index].startSerialNo
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  createdvalue[index].endSerialNo.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                workorder.workorderId = int.parse(
                                    createdvalue[index].workorderId.toString());
                                workorder.workorderCode =
                                    createdvalue[index].workorderCode
                                        .toString();
                                workorder.quantity = int.parse(
                                    createdvalue[index].quantity.toString());
                                workorder.startSerialNo =
                                    createdvalue[index].startSerialNo
                                        .toString();
                                workorder.endSerialNo =
                                    createdvalue[index].endSerialNo.toString();
                                workorder.status =
                                    createdvalue[index].status.toString();

                                AddWorkOrder(workorderModel: workorder);

                                chart = false;
                                _isShow = true;
                                searchdropdown = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              // WorkOrder().deleteworkorder(createdvalue[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  getVerifiedItems(List<WorkorderModel> items, int index) {
    var verifiedvalue = items.where((element) =>
    element.status!.toUpperCase() == "VERIFIED").toList();

    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color:

                                  verifiedvalue[index].status!.toUpperCase() ==
                                      "CREATED"
                                      ? Colors.blueAccent
                                      : verifiedvalue[index].status!
                                      .toUpperCase() == "VERIFIED"
                                      ? Colors.orange
                                      : verifiedvalue[index].status!
                                      .toUpperCase() == "APPROVED"
                                      ? Colors.green
                                      : Colors.red,


                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(verifiedvalue[index].workorderCode
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(verifiedvalue[index].quantity
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(verifiedvalue[index].startSerialNo
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  verifiedvalue[index].endSerialNo.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                workorder.workorderId = int.parse(
                                    verifiedvalue[index].workorderId
                                        .toString());
                                workorder.workorderCode =
                                    verifiedvalue[index].workorderCode
                                        .toString();
                                workorder.quantity = int.parse(
                                    verifiedvalue[index].quantity.toString());
                                workorder.startSerialNo =
                                    verifiedvalue[index].startSerialNo
                                        .toString();
                                workorder.endSerialNo =
                                    verifiedvalue[index].endSerialNo.toString();
                                workorder.status =
                                    verifiedvalue[index].status.toString();

                                AddWorkOrder(workorderModel: workorder);

                                chart = false;
                                _isShow = true;
                                searchdropdown = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              // WorkOrder().deleteworkorder(verifiedvalue[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  getApprovedItems(List<WorkorderModel> items, int index) {
    var approvedvalue = items.where((element) =>
    element.status!.toUpperCase() == "APPROVED").toList();
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color:

                                  approvedvalue[index].status!.toUpperCase() ==
                                      "CREATED"
                                      ? Colors.blueAccent
                                      : approvedvalue[index].status!
                                      .toUpperCase() == "VERIFIED"
                                      ? Colors.orange
                                      : approvedvalue[index].status!
                                      .toUpperCase() == "APPROVED"
                                      ? Colors.green
                                      : Colors.red,


                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(approvedvalue[index].workorderCode
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(approvedvalue[index].quantity
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(approvedvalue[index].startSerialNo
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  approvedvalue[index].endSerialNo.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                workorder.workorderId = int.parse(
                                    approvedvalue[index].workorderId
                                        .toString());
                                workorder.workorderCode =
                                    approvedvalue[index].workorderCode
                                        .toString();
                                workorder.quantity = int.parse(
                                    approvedvalue[index].quantity.toString());
                                workorder.startSerialNo =
                                    approvedvalue[index].startSerialNo
                                        .toString();
                                workorder.endSerialNo =
                                    approvedvalue[index].endSerialNo.toString();
                                workorder.status =
                                    approvedvalue[index].status.toString();

                                AddWorkOrder(workorderModel: workorder);

                                chart = false;
                                _isShow = true;
                                searchdropdown = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              // WorkOrder().deleteworkorder(approvedvalue[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  getRejectedItems(List<WorkorderModel> items, int index) {
    var rejectedvalue = items.where((element) =>
    element.status!.toUpperCase() == "REJECTED").toList();
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color:

                                  rejectedvalue[index].status!.toUpperCase() ==
                                      "CREATED"
                                      ? Colors.blueAccent
                                      : rejectedvalue[index].status!
                                      .toUpperCase() == "VERIFIED"
                                      ? Colors.orange
                                      : rejectedvalue[index].status!
                                      .toUpperCase() == "APPROVED"
                                      ? Colors.green
                                      : Colors.red,


                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(rejectedvalue[index].workorderCode
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(rejectedvalue[index].quantity
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(rejectedvalue[index].startSerialNo
                                  .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  rejectedvalue[index].endSerialNo.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                workorder.workorderId = int.parse(
                                    rejectedvalue[index].workorderId
                                        .toString());
                                workorder.workorderCode =
                                    rejectedvalue[index].workorderCode
                                        .toString();
                                workorder.quantity = int.parse(
                                    rejectedvalue[index].quantity.toString());
                                workorder.startSerialNo =
                                    rejectedvalue[index].startSerialNo
                                        .toString();
                                workorder.endSerialNo =
                                    rejectedvalue[index].endSerialNo.toString();
                                workorder.status =
                                    rejectedvalue[index].status.toString();

                                AddWorkOrder(workorderModel: workorder);
                                chart = false;
                                _isShow = true;
                                searchdropdown = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              // WorkOrder().deleteworkorder(rejectedvalue[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  void SearchWorkorders(String query) {
    if (datamodels != null) {
      final suggestions = datamodels!.where((works) {
        final workordercode = works.workorder_code!.toLowerCase();
        final input = query.toLowerCase();
        return workordercode.contains(input);
      }).toList();
      setState(() => datamodels = suggestions);
    }
  }
}


class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);

  final int x;
  final double y;
  final double y1;
  final double y2;
}