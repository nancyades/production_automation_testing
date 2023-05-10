import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:production_automation_testing/Model/APIModel/usermodel.dart';
import 'package:production_automation_testing/Model/APIModel/workorderbasedreport.dart';
import 'package:production_automation_testing/Model/APIModel/workordermodel.dart';
import 'package:production_automation_testing/Model/APIModel/workorderprogressreport.dart';
import 'package:production_automation_testing/Provider/changenotifier/widget_notifier.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/Provider/reportprovider/testerreportprovider.dart';
import 'package:production_automation_testing/Provider/reportprovider/workorderbasedreportprovider.dart';
import 'package:production_automation_testing/Provider/reportprovider/workorderprogressreportprovider.dart';
import 'package:production_automation_testing/service/apiservice.dart';
import '../../Helper/AppClass.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/APIModel/productreport.dart';
import '../../Model/APIModel/testerreport.dart';

class Reportscreen extends ConsumerStatefulWidget {
  const Reportscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<Reportscreen> createState() => _ReportscreenState();
}

int touchedIndex = -1;
bool card1 = false;
bool card2 = false;
bool card3 = false;
bool card4 = false;

class _ReportscreenState extends ConsumerState<Reportscreen> {
  String? start = '',
      end = '';
  DateTime? endDate;
  DateTime? startDate;
  bool isColor = false;

  var workorderuserid;
  var testuserid;
  var workorderid;

  bool preferencePressed = false;

  int? _currentColorIndex;
  int _previousColorIndex = 0;


  void _changeColor(int index) {
    setState(() {
      _currentColorIndex = index;
      if (_previousColorIndex != index) {
        _previousColorIndex = index;
      }
    });
  }

  int? _currentColorIndex_1;
  int _previousColorIndex_1 = 0;


  void _changeColor_1(int index) {
    setState(() {
      _currentColorIndex_1 = index;
      if (_previousColorIndex_1 != index) {
        _previousColorIndex_1 = index;
      }
    });
  }
  int? _currentColorIndex_2;
  int _previousColorIndex_2 = 0;


  void _changeColor_2(int index) {
    setState(() {
      _currentColorIndex_2 = index;
      if (_previousColorIndex_2 != index) {
        _previousColorIndex_2 = index;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    print("currntindex-----> $_currentColorIndex");
    return Column(children: [
      Card(
        elevation: 7,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Reports",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Product Release Report".toUpperCase(),
                            style: TextStyle(fontSize: 14)))
                  ]),
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff333951)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xff333951))))),
                  onPressed: () {
                    setState(() {
                      card1 = true;
                      card2 = false;
                      card3 = false;
                      card4 = false;
                      start = '';
                      end = '';
                    /*  _currentColorIndex;
                     _previousColorIndex = 0;
                      _changeColor(changedIndex);*/
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Work Order Progress Report".toUpperCase(),
                            style: TextStyle(fontSize: 14)))
                  ]),
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff333951)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xff333951))))),
                  onPressed: () {
                    setState(() {
                      card1 = false;
                      card2 = true;
                      card3 = false;
                      card4 = false;
                      start = '';
                      end = '';
                 /*     _currentColorIndex;
                      _previousColorIndex = 0;
                      _changeColor(changedIndex);*/
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Testers Report".toUpperCase(),
                            style: TextStyle(fontSize: 14)))
                  ]),
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff333951)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xff333951))))),
                  onPressed: () {
                    setState(() {
                      card1 = false;
                      card2 = false;
                      card3 = true;
                      card4 = false;
                      start = '';
                      end = '';
                    /*  _currentColorIndex;
                      _previousColorIndex = 0;
                      _changeColor(changedIndex);*/
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                            "Work Order based Test Reports".toUpperCase(),
                            style: TextStyle(fontSize: 14)))
                  ]),
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff333951)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xff333951))))),
                  onPressed: () {
                    setState(() {
                      card1 = false;
                      card2 = false;
                      card3 = false;
                      card4 = true;
                      start = '';
                      end = '';
                    /*  _currentColorIndex;
                      _previousColorIndex = 0;
                      _changeColor(changedIndex);*/
                    });
                  }),
            ],
          ),
        ]),
      ),
      /* (){
      if(card1 == true){
        return getCard1();
      }else if(card2 == true){
        return getCard2();
      }else{
        return getCard1();
      }

    }(),*/

      Expanded(
          child: card1 == true
              ? () {
            return ref.watch(getProductReportNotifier).when(
                data: (product) {
                  return Column(
                    children: [
                      piechart(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Product Release Report",
                                  style: TextStyle(
                                      fontSize:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.014,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Export',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.013),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.open_in_new))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Color(0xff565e8a),
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
                                      Expanded(
                                        child: Center(
                                          child: Text("Product Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Product Template",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Created By",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Released Date",
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
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  height: 500,
                                  color: Color(0xFFd9d8d7),
                                  child: ListView.builder(
                                      itemCount: product.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return getProductReport(
                                            product, index);
                                      })),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }, error: (e, s) {
              return Text(e.toString());
            }, loading: () {
              return Center(child: CircularProgressIndicator());
            });
          }()
              : card2 == true
              ? () {
            return ref.watch(getUserNotifier).when(data: (user) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Workorder Progress Report",
                              style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width *
                                      0.014,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Export',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.013),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.open_in_new))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.05,
                          child: TextField(
                            onChanged: (value) {
                              //onItemChanged(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by Workorder',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                    onPressed: () async {
                                      DateTime? date = DateTime(1900);
                                      var inputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      var outputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now());
                                      start = inputFormat.format(
                                          outputFormat.parse(date
                                              .toString()
                                              .substring(0, 10)));
                                      List<String> splitStart =
                                      start!.split('-');
                                      startDate = DateTime.utc(
                                          int.parse(splitStart[0]),
                                          int.parse(splitStart[1]),
                                          int.parse(splitStart[2]));
                                    },
                                    icon: const Icon(
                                        Icons.date_range_outlined)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(start!.isNotEmpty
                                    ? start!
                                    : 'Start Date'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                    onPressed: () async {
                                      DateTime? date = DateTime(1900);
                                      var inputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      var outputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now());
                                      end = inputFormat.format(
                                          outputFormat.parse(date
                                              .toString()
                                              .substring(0, 10)));
                                      List<String> splitEnd =
                                      end!.split('-');
                                      endDate = DateTime.utc(
                                          int.parse(splitEnd[0]),
                                          int.parse(splitEnd[1]),
                                          int.parse(splitEnd[2]));
                                    },
                                    icon: const Icon(
                                        Icons.date_range_outlined)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0),
                                child: Text(end!.isNotEmpty
                                    ? end!
                                    : 'End Date'),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(5.0),
                                        child: Text(
                                            "Start".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 14)),
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
                                              BorderRadius.circular(
                                                  18.0),
                                              side: BorderSide(
                                                  color: Color(0xff6C6CE5))))),
                                  onPressed: () {
                                    if (start!.isEmpty) {
                                      popDialog(
                                          title:
                                          'Please Select Start date',
                                          msg: 'choose vaild date',
                                          context: context);
                                    } else if (end!.isEmpty) {
                                      popDialog(
                                          title:
                                          'Please Select end date',
                                          msg: 'choose vaild date',
                                          context: context);
                                    }

                                    ref.read(workorderProgressReportNotifier.notifier).workorderprogressReport(workorderuserid, start, end);
                                    print(
                                        "workorderid----------> ${workorderuserid}");
                                    print(
                                        "startdate----------> ${start}");
                                    print(
                                        "enddate----------> ${end}");
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Consumer(
                              builder: (context, snapshot, child) {
                                var testuser = user
                                    .where((element) =>
                                element.role == "Test User")
                                    .toList();
                                return Container(
                                    child: ListView.builder(
                                        itemCount: testuser.length,
                                        //controller: _controller,
                                        physics:
                                        const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return getWorkorder(
                                              testuser, index);
                                        }));
                              }),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 10.0),
                                color: Color(0xff333951),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            'WorkOrder ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Workorder QTY',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Starting serial no',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Ending Serial no',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0),
                                    child: ref.watch(workorderProgressReportNotifier).id.when(
                                        data: (workorder) {
                                          return ListView.builder(
                                              itemCount: workorder
                                                  .length,
                                              // shrinkWrap: true,
                                              controller:
                                              ScrollController(),
                                              itemBuilder: (context, index) {
                                                return getWorkorderdetails(
                                                    workorder, index);
                                              });
                                        },
                                        error: (error, s) {},
                                        loading: () {})),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }, error: (e, s) {
              return Text(e.toString());
            }, loading: () {
              return Center(child: CircularProgressIndicator());
            });
          }()
              : card3 == true
              ? () {
            return ref.watch(getUserNotifier).when(data: (user) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Testers",
                              style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width *
                                      0.014,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Export',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.013),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.open_in_new))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.05,
                          child: TextField(
                            onChanged: (value) {
                              //onItemChanged(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by User Name',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                    onPressed: () async {
                                      DateTime? date = DateTime(1900);
                                      var inputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      var outputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now());
                                      start = inputFormat.format(
                                          outputFormat.parse(date
                                              .toString()
                                              .substring(0, 10)));
                                      List<String> splitStart =
                                      start!.split('-');
                                      startDate = DateTime.utc(
                                          int.parse(splitStart[0]),
                                          int.parse(splitStart[1]),
                                          int.parse(splitStart[2]));
                                    },
                                    icon: const Icon(
                                        Icons.date_range_outlined)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(start!.isNotEmpty
                                    ? start!
                                    : 'Start Date'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                    onPressed: () async {
                                      DateTime? date = DateTime(1900);
                                      var inputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      var outputFormat =
                                      DateFormat('yyyy-MM-dd');
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now());
                                      end = inputFormat.format(
                                          outputFormat.parse(date
                                              .toString()
                                              .substring(0, 10)));
                                      List<String> splitEnd =
                                      end!.split('-');
                                      endDate = DateTime.utc(
                                          int.parse(splitEnd[0]),
                                          int.parse(splitEnd[1]),
                                          int.parse(splitEnd[2]));
                                    },
                                    icon: const Icon(
                                        Icons.date_range_outlined)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 8.0),
                                child: Text(end!.isNotEmpty
                                    ? end!
                                    : 'End Date'),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(5.0),
                                        child: Text(
                                            "Start".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 14)),
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
                                              BorderRadius.circular(
                                                  18.0),
                                              side: BorderSide(
                                                  color: Color(0xff6C6CE5))))),
                                  onPressed: () {
                                    if (start!.isEmpty) {
                                      popDialog(
                                          title:
                                          'Please Select Start date',
                                          msg: 'choose vaild date',
                                          context: context);
                                    } else if (end!.isEmpty) {
                                      popDialog(
                                          title:
                                          'Please Select end date',
                                          msg: 'choose vaild date',
                                          context: context);
                                    }

                                    ref.read(testerReportNotifier.notifier).testerReport(testuserid, start, end);
                                    print(
                                        "workorderid----------> ${testuserid}");
                                    print(
                                        "startdate----------> ${start}");
                                    print(
                                        "enddate----------> ${end}");
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Consumer(
                              builder: (context, snapshot, child) {
                                var testuser = user
                                    .where((element) =>
                                element.role == "Test User")
                                    .toList();
                                return Container(
                                    child: ListView.builder(
                                        itemCount: testuser.length,
                                        //controller: _controller,
                                        physics:
                                        const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {

                                          return gettestuser(testuser, index);
                                        }));
                              }),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 10.0),
                                color: Color(0xff333951),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            'Product ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Product serial number',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Test Name',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Test Result',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Tested Date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Consumer(builder:
                                  (context, snapshot, child) {
                                    return ref.watch(testerReportNotifier).id.when(data: (tester){
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: ListView.builder(
                                              itemCount: tester.length,
                                              // shrinkWrap: true,
                                              controller:
                                              ScrollController(),
                                              itemBuilder:
                                                  (context, index) {
                                                return getTestuserdetails(tester, index);
                                              }),
                                        ),
                                      );
                                    }, error: (e,s){
                                      return Text(e.toString());
                                    }, loading: (){
                                      return Center(child: CircularProgressIndicator());
                                    });


                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }, error: (e, s) {
              return Text(e.toString());
            }, loading: () {
              return Center(child: CircularProgressIndicator());
            });

          }()

              : card4 == true
              ? (){

            return ref.watch(getWorkorderNotifier).when(data: (data) {
              return  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Work Order based Test Reports",
                              style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width *
                                      0.014,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(right: 25.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Text(
                                  'Export',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.013),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.open_in_new))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.05,
                          child: TextField(
                            onChanged: (value) {
                              //onItemChanged(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon:
                              const Icon(Icons.search),
                              hintText: 'Search by Workorder',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Consumer(builder:
                              (context, snapshot, child) {
                            return Container(
                                child: ListView.builder(
                                    itemCount: data.length,
                                    //controller: _controller,
                                    physics:
                                    const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection:
                                    Axis.vertical,
                                    itemBuilder:
                                        (context, index) {
                                      return getworkorderbasedtest(data, index);
                                    }));
                          }),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 10.0),
                                color: Color(0xff333951),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            'Product ',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Product serial number',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Test Type',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Tested By',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Test Date',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Test Result',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(
                                            'Test Name',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Consumer(builder:
                                  (context, snapshot, child) {
                               return ref.watch(workorderbasedReportNotifier).id.when(data: (data){
                                  return Expanded(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 10.0),
                                      child: ListView.builder(
                                          itemCount: data.length,
                                          // shrinkWrap: true,
                                          controller:
                                          ScrollController(),
                                          itemBuilder:
                                              (context, index) {
                                            return getworkorderbasedtestdetails(data, index);
                                          }),
                                    ),
                                  );
                                }, error: (e,s){
                                  return Text(e.toString());
                                }, loading: (){
                                  return Center(child: CircularProgressIndicator());
                                });

                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }, error: (e, s) {
              return Text(e.toString());
            }, loading: () {
              return Center(child: CircularProgressIndicator());
            });



            }()

              : () {
            return ref.watch(getProductReportNotifier).when(
                data: (product) {
                  return Column(
                    children: [
                      piechart(),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Product Release Report",
                                  style: TextStyle(
                                      fontSize:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.014,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Export',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .width *
                                              0.013),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon:
                                      Icon(Icons.open_in_new))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                        ),
                        color: Color(0xff565e8a),
                        //Colors.blueAccent,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                              "Product Name",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 15.0,
                                                  color: Colors
                                                      .white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                              "Product Template",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 15.0,
                                                  color: Colors
                                                      .white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                              "Created By",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 15.0,
                                                  color: Colors
                                                      .white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                              "Released Date",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 15.0,
                                                  color: Colors
                                                      .white)),
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
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  height: 500,
                                  color: Color(0xFFd9d8d7),
                                  child: ListView.builder(
                                      itemCount: product.length,
                                      itemBuilder:
                                          (BuildContext ctxt,
                                          int index) {
                                        return getProductReport(
                                            product, index);
                                      })),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }, error: (e, s) {
              return Text(e.toString());
            }, loading: () {
              return Center(
                  child: CircularProgressIndicator());
            });
          }()),
    ]);
  }

  getProductReport(List<ProductReportmodel> productdetails, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 30.0,
                  width: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                              productdetails[index].productName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                              productdetails[index].productTemplate.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                              productdetails[index].createdBy.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(() {
                            var str = productdetails[index]
                                .releasedDate
                                .toString()
                                .split('T')[0];
                            return str.toString();
                          }(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget piechart() {
    return AspectRatio(
      aspectRatio: 6,
      child: Card(
        elevation: 4,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "open",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "In-progress",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "completed",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                    height: 200,
                    child: Row(
                      children: [
                        Card(
                          elevation: 12,
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      spreadRadius: 10,
                                      blurRadius: 12)
                                ],
                                border: Border.all(color: Colors.grey),
                                backgroundBlendMode: BlendMode.darken,
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
                                                Text("${10}%",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Open",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 10.0,
                                                        color: Colors.black))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.incomplete_circle,
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
                                      width: 147,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.rectangle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      spreadRadius: 10,
                                      blurRadius: 12)
                                ],
                                border: Border.all(color: Colors.grey),
                                backgroundBlendMode: BlendMode.darken,
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
                                                Text("${10}%",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("In-Progress",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 9.0,
                                                        color: Colors.black))
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
                                      width: 147,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.rectangle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      spreadRadius: 10,
                                      blurRadius: 12)
                                ],
                                border: Border.all(color: Colors.grey),
                                backgroundBlendMode: BlendMode.darken,
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
                                                Text("${10}%",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Completed",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 10.0,
                                                        color: Colors.black))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.incomplete_circle,
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
                                      width: 147,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          shape: BoxShape.rectangle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      spreadRadius: 10,
                                      blurRadius: 12)
                                ],
                                border: Border.all(color: Colors.grey),
                                backgroundBlendMode: BlendMode.darken,
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
                                                Text("${10}%",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Total",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 9.0,
                                                        color: Colors.black))
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
                                      width: 147,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.rectangle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.deepPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  getWorkorder(List<Users> user, int index) {
    //Color(0xff565e8a);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _changeColor(index);
          workorderuserid = user[index].userId;
          //  user[index].color = Color(0xff9ea441);

        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.04,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _currentColorIndex == index ?  Color(0xffFFAAA1E) : Color(0xff565e8a),
              //Color(0xff565e8a)
          ),

          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.01),
                    child: Text(user[index].name.toString(),
                        style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.011,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  getWorkorderdetails(List<WorkorderProgressReportModel> mdata, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 30.0,
                  width: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(mdata[index].workOrder.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mdata[index].workOrderQty.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mdata[index].startingSerialNumber
                              .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mdata[index].endingSerialNumber
                              .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  //**********************tester report ***************************************

  gettestuser(List<Users> user, int index) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          testuserid = user[index].userId;
          print("testuserid-----------> ${testuserid}");
          _changeColor_1(index);

        },
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.04,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: _currentColorIndex_1 == index ?  Color(0xffFFAAA1E) : Color(0xff565e8a),),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.01),
                    child: Text(user[index].name.toString(),
                        style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.011,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  getTestuserdetails(List<TesterReportModel> tester, int index) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 35.0,
                  width: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(tester[index].productName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(tester[index].startSerialNo,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(tester[index].testname,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(tester[index].testResult,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text((){
                            var str = tester[index].testedDate.toString().split('T')[0];
                            return str.toString();
                          }(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  //**********************workorder based t6est  report ***************************************
  getworkorderbasedtest(List<WorkorderModel> workorder, int index) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GestureDetector(
        onTap: () {
          ref.read(workorderbasedReportNotifier.notifier).workorderbasedReport(workorder[index].workorderId);
          _changeColor_2(index);
        },
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.04,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: _currentColorIndex_2 == index ?  Color(0xffFFAAA1E) : Color(0xff565e8a)),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.01),
                    child: Text(workorder[index].workorderCode.toString(),
                        style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.011,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  getworkorderbasedtestdetails(List<WorkorderbasedReport> mData, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 35.0,
                  width: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(mData[index].productName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mData[index].startSerialNo.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mData[index].testType.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mData[index].testedBy.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                                  (){
                                var str = mData[index].testedDate.toString().split('T')[0] ;
                                return str.toString();
                              }(),


                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mData[index].testResult.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(mData[index].testName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
