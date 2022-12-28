import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/addworkorder.dart';
import '../../DashBoard/src/ProjectCardOverview.dart';
import '../../DashBoard/src/tabs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class WorkOrderScreenPage extends StatefulWidget {
  const WorkOrderScreenPage({Key? key}) : super(key: key);

  @override
  State<WorkOrderScreenPage> createState() => _WorkOrderScreenPageState();
}

class _WorkOrderScreenPageState extends State<WorkOrderScreenPage> {
  bool _isShow = false;

  final List<ChartData> chartData = <ChartData>[
    ChartData(2010, 10.53, 3.3,0.0),
    ChartData(2011, 9.5, 5.4,3.8),
    ChartData(2012, 10, 2.65, 4.0),
    ChartData(2013, 9.4, 2.62, 5.0),
    ChartData(2014, 5.8, 1.99,3.9),
    ChartData(2015, 4.9, 1.44, 1.9),
    ChartData(2016, 4.5, 2, 1.4),
    ChartData(2017, 3.6, 1.56, 1.0),
    ChartData(2018, 3.43, 2.1,5.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.63,
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.all(15),
                        onPressed: () {
                          setState(() {
                            _isShow =!_isShow;
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
                Container(
                  margin: EdgeInsets.only(top:5.0),
                  height: 200.0,
                  width: MediaQuery.of(context).size.width * 0.62,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProjectCardView(
                          color: Color(0xffFF4C60),
                          projectName: 'The matrix',
                          percentComplete: '34%',
                          progressIndicatorColor: Colors.redAccent[100],
                          icon: Feather.moon
                      ),
                      ProjectCardView(
                          color: Color(0xff6C6CE5),
                          projectName: 'Delivery Club',
                          percentComplete: '78%',
                          progressIndicatorColor: Colors.blue[200],
                          icon: Feather.truck
                      ),
                      ProjectCardView(
                          color: Color(0xffFAAA1E),
                          projectName: 'Travel Comrode',
                          percentComplete: '82%',
                          progressIndicatorColor: Colors.amber[200],
                          icon: Icons.local_airport
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Tabs(),
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
                          child: Container(
                            height: 20.0,
                            width: 10.0,
                            child: Center(child: Text("WorkOrder Code",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.black ))),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.0,
                            width: 10.0,
                            child:  Center(child: Text("Quantity",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.black ))),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.0,
                            width: 10.0,
                            child:  Center(child: Text("Start Serial No",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.black ))),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20.0,
                            width: 10.0,
                            child:  Center(child: Text("End Serial No",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.black ))),
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
                            child: ListView.builder
                              (
                                itemCount: 20,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Card(
                                      color: Colors.green[100],
                                      child:  Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("16 zone"),
                                            Text("100"),
                                            Text("001"),
                                            Text("500"),

                                          ],
                                        ),
                                      ));
                                }
                            ),
                          ),
                          Center(
                              child: SfCartesianChart(
                                  series: <ChartSeries>[
                                    SplineAreaSeries<ChartData, int>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y
                                    ),
                                    SplineAreaSeries<ChartData, int>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y1
                                    ),
                                    SplineAreaSeries<ChartData, int>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y2
                                    ),
                                  ]
                              )
                          )
                        ],
                      ),
                    ),
                ),




                Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('@copyright rax-tech International 2022',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0,color: Colors.black)),
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
              child: AddWorkOrder()),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1,this.y2);
  final int x;
  final double y;
  final double y1;
  final double y2;
}