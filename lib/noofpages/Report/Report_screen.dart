import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:production_automation_testing/Model/APIModel/dashboardscreen/workorder_model.dart';
import 'package:production_automation_testing/Model/APIModel/usermodel.dart';
import 'package:production_automation_testing/Model/APIModel/workorderbasedreport.dart';
import 'package:production_automation_testing/Model/APIModel/workordermodel.dart';
import 'package:production_automation_testing/Model/APIModel/workorderprogressreport.dart';
import 'package:production_automation_testing/Provider/changenotifier/widget_notifier.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/Provider/post_provider/productreleaseexportreport_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/testerexcel_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/testerexportexcelreport_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/workorderbaasedtestexportexcel_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/workorderbasedexcel_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/workorderprogressexportexcel.dart';
import 'package:production_automation_testing/Provider/post_provider/workorderunderproduct.dart';
import 'package:production_automation_testing/Provider/reportprovider/testerreportprovider.dart';
import 'package:production_automation_testing/Provider/reportprovider/workorderbasedreportprovider.dart';
import 'package:production_automation_testing/Provider/reportprovider/workorderprogressreportprovider.dart';
import 'package:production_automation_testing/service/apiservice.dart';
import '../../Helper/AppClass.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/APIModel/productreport.dart';
import '../../Model/APIModel/testerreport.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../Model/APIModel/workorderunderproduct.dart';

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

  bool stanger = false;
  bool teststanger = false;
  bool workorderstanger = false;


int tapped = 0;
  int? _currentColorIndex;
  int _previousColorIndex = 0;

  var selectUsers = "";
  var selectworkorder = "";

  List<NewWorkorderbasedReport> glossarListOnSearch_1 = [];
  TextEditingController _textEditing_1Controller = TextEditingController();
  List<NewWorkorderbasedReport> workorderbased = [];

  List<TesterReportModel> glossarListOnSearch_2 = [];
  TextEditingController _textEditing_2Controller = TextEditingController();
  List<TesterReportModel> Tester = [];

  List<WorkorderModel> glossarListOnSearch_3 = [];
  TextEditingController _textEditing_3Controller = TextEditingController();
  List<WorkorderModel> workorderprogress = [];

  var work_order_id;





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
  void initState(){
    ref.refresh(getProductReportNotifier);

  }


  String? filePath;

  String? _localPath;
  late bool _permissionReady;





  var gg;




  Future<void> downloadExcelFile(String url, String savePath) async {
    final response = await http.get(Uri.parse(url));
    final file = File(savePath);

     file.writeAsBytes(response.bodyBytes);
  }

  void openExcelFile(String filePath) {
    OpenFile.open(filePath);
  }


  Future<void> _prepareSaveDir() async {

      _localPath = (await _findLocalPath())!;



    print("_localPath------------------> ${_localPath!}");
    final savedDir = Directory(_localPath!);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
      var directory = await getApplicationDocumentsDirectory();
       gg = directory.path + Platform.pathSeparator + 'Download';
      return directory.path + Platform.pathSeparator + 'Download';

  }

   String? apiLink;
   String? savePath;


  List<Vehicle> vehicles = [
    Vehicle(
      'workorder 1',
      ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
      Icons.motorcycle,
    ),
    Vehicle(
      'workorder 2',
      ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
      Icons.directions_car,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    _prepareSaveDir();


    int _selectedIndex = -1;

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
                                      onPressed: () {
                                        ref.read(getproductreleseexportexcelNotifier.notifier).getproductreleseexport();
                                      },
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
                                  onPressed: () {
                                    ref.read(getworkorderprogressexportexcelNotifier.notifier).getworkorderprogressexportexcel(workorderuserid, start, end);

                                  },
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
                            controller: _textEditing_3Controller,
                            onChanged: (value) {
                              setState(() {
                                glossarListOnSearch_3 = workorderprogress
                                    .where((element) => element.workorderCode!
                                    .toLowerCase()
                                    .contains(
                                    value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by Workorder',
                            ),
                          ),
                        ),
                      ),
                      Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(getUserNotifier).when(data: (data){
                              List<Users> testuser = data.where((element) => element.role == "Test User").toList();

                              if(stanger == false){
                                selectUsers =testuser.isEmpty? "": testuser[0].name.toString();
                              }


                              return DropdownButton(
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.keyboard_arrow_down),
                                ),
                                items: testuser.map<DropdownMenuItem<String>>(
                                        (Users setlist) {
                                      return DropdownMenuItem<String>(
                                        value: setlist.name,
                                        child: Text(setlist.name.toString()),
                                      );
                                    }).toList(),
                                value: selectUsers,
                                onChanged: (item) {

                                  setState(() {

                                    selectUsers = item.toString();
                                    stanger = true;
                                    for(int i=0; i<testuser.length; i++){
                                      if(selectUsers == testuser[i].name){
                                        workorderuserid = testuser[i].userId;
                                        print("print nancy-----> ${workorderuserid}");
                                      }

                                    }
                                  //  workorderuserid = testuser[index].userId;
                                    print("Index==>"+selectUsers);
                                    //List<FirstClass> emptylist = [];

                                  });
                                },
                              );

                            }, error: (e,s){
                              return Text(e.toString());
                            }, loading: (){
                              return Center(child: CircularProgressIndicator());
                            });

                          }
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
                               flex: 5,
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
                                                 'Workorder',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.bold),
                                               )),
                                           Expanded(
                                               child: Text(
                                                 'Product Name',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.bold),
                                               )),
                                           Expanded(
                                               child: Text(
                                                 'Start serial',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.bold),
                                               )),
                                           Expanded(
                                               child: Text(
                                                 'end serial',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.bold),
                                               )),
                                           Expanded(
                                               child: Text(
                                                 'Tested Unit',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 12,
                                                     fontWeight:
                                                     FontWeight.bold),
                                               )),
                                           Expanded(
                                               child: Text(
                                                 'Testing Status',
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
                                   Consumer(
                                     builder: (context, ref, child) {
                                      // return ref.watch(workorderunderproductReportNotifier).id.when(data: (data){
                                         return Expanded(
                                           child: Padding(
                                               padding: const EdgeInsets.only(
                                                   top: 10.0),
                                               child:
                                               ListView.builder(
                                                 itemCount: vehicles.length,
                                                 itemBuilder: (context, i) {
                                                   return ExpansionTile(
                                                     title: Text(vehicles[i].title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                                                     children: <Widget>[
                                                       Column(
                                                         children: _buildExpandableContent(vehicles[i]),
                                                       ),
                                                     ],
                                                   );
                                                 },
                                               )
                                              /* ListView.builder(
                                                   itemCount:  data.length,

                                                   // shrinkWrap: true,
                                                   controller:
                                                   ScrollController(),
                                                   itemBuilder: (context, index) {
                                                     return getWorkorderunderproduct(
                                                         data, index);
                                                   })*/


                                           ),
                                         );
                                      /* }, error: (e,s){
                                         return Text(e.toString());
                                       }, loading: (){
                                         return Center(child: CircularProgressIndicator());
                                       });*/

                                     }
                                   )
                                 ],
                               ),
                             )




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
                                  onPressed: () {
                                    ref.read(gettesterexportexcelNotifier.notifier).gettesterexportexcel(testuserid, start, end);
                                  },
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
                            controller: _textEditing_2Controller,
                            onChanged: (value) {
                              setState(() {
                                glossarListOnSearch_2 = Tester
                                    .where((element) => element.productName!
                                    .toLowerCase()
                                    .contains(
                                    value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by User Name',
                            ),
                          ),
                        ),
                      ),
                      Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(getUserNotifier).when(data: (data){
                              List<Users> testuser = data.where((element) => element.role == "Test User").toList();

                              if(teststanger == false){
                                selectUsers =testuser.isEmpty? "": testuser[0].name.toString();
                              }


                              return DropdownButton(
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.keyboard_arrow_down),
                                ),
                                items: testuser.map<DropdownMenuItem<String>>(
                                        (Users setlist) {
                                      return DropdownMenuItem<String>(
                                        value: setlist.name,
                                        child: Text(setlist.name.toString()),
                                      );
                                    }).toList(),
                                value: selectUsers,
                                onChanged: (item) {

                                  setState(() {

                                    selectUsers = item.toString();
                                    teststanger = true;
                                    for(int i=0; i<testuser.length; i++){
                                      if(selectUsers == testuser[i].name){
                                        testuserid = testuser[i].userId;
                                        print("print nancy-----> ${testuserid}");
                                      }

                                    }
                                    //  workorderuserid = testuser[index].userId;
                                    print("Index==>"+selectUsers);
                                    //List<FirstClass> emptylist = [];

                                  });
                                },
                              );

                            }, error: (e,s){
                              return Text(e.toString());
                            }, loading: (){
                              return Center(child: CircularProgressIndicator());
                            });

                          }
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
                       /* Expanded(
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
                        ),*/
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
                                            'workorder ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
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
                                      Expanded(
                                          child: Text(
                                            'Test Report',
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
                                      Tester = tester;
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: _textEditing_2Controller
                                              .text.isNotEmpty &&
                                              glossarListOnSearch_2.isEmpty
                                              ? Column(
                                            children: [
                                              Align(
                                                alignment:
                                                Alignment.center,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .fromLTRB(
                                                      0, 50, 0, 0),
                                                  child: Text(
                                                    'No results',
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'Avenir',
                                                        fontSize: 22,
                                                        color: Color(
                                                            0xff848484)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                          : ListView.builder(
                                              itemCount:  _textEditing_2Controller
                                                  .text.isNotEmpty
                                                  ? glossarListOnSearch_2
                                                  .length
                                                  :  tester.length,

                                              // shrinkWrap: true,
                                              controller: ScrollController(),
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
                                  onPressed: () {
                                    ref.read(getworkorderbasedtestexportexcelexportexcelNotifier.notifier).getworkorderbasedtestexportexcelexportexcel(work_order_id);

                                  },
                                  icon: Icon(Icons.open_in_new))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        child: SizedBox(
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height *
                              0.05,
                          child: TextField(
                            controller: _textEditing_1Controller,
                            onChanged: (value) {
                              setState(() {
                                glossarListOnSearch_1 = workorderbased
                                    .where((element) => element.productName!
                                    .toLowerCase()
                                    .contains(
                                    value.toLowerCase()))
                                    .toList();
                              });
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
                      ref.watch(getWorkorderNotifier).when(data: (doll){


                        if(workorderstanger == false){
                          selectworkorder =doll.isEmpty? "": doll[0].workorderCode.toString();
                        }


                        return DropdownButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                          items: doll.map<DropdownMenuItem<String>>(
                                  (WorkorderModel setlist) {
                                return DropdownMenuItem<String>(
                                  value: setlist.workorderCode,
                                  child: Text(setlist.workorderCode.toString()),
                                );
                              }).toList(),
                          value: selectworkorder,
                          onChanged: (item) {

                            setState(() {

                              selectworkorder = item.toString();
                              workorderstanger = true;
                              for(int i=0; i<doll.length; i++){
                                if(selectworkorder == doll[i].workorderCode){
                                   work_order_id = doll[i].workorderId;
                                  ref.read(workorderbasedReportNotifier.notifier).workorderbasedReport(doll[i].workorderId);

                                }

                              }
                              //  workorderuserid = testuser[index].userId;
                              print("Index==>"+selectUsers);
                              //List<FirstClass> emptylist = [];

                            });
                          },
                        );

                      }, error: (e,s){
                        return Text(e.toString());
                      }, loading: (){
                        return Center(child: CircularProgressIndicator());
                      }),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                      /*  Expanded(
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
                        ),*/
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
                                            'Test Report',
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
                                 workorderbased = data;
                                  return Expanded(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 10.0),
                                      child: _textEditing_1Controller
                                          .text.isNotEmpty &&
                                          glossarListOnSearch_1.isEmpty
                                          ? Column(
                                        children: [
                                          Align(
                                            alignment:
                                            Alignment.center,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .fromLTRB(
                                                  0, 50, 0, 0),
                                              child: Text(
                                                'No results',
                                                style: TextStyle(
                                                    fontFamily:
                                                    'Avenir',
                                                    fontSize: 22,
                                                    color: Color(
                                                        0xff848484)),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                      : ListView.builder(
                                          itemCount: _textEditing_1Controller
                                              .text.isNotEmpty
                                              ? glossarListOnSearch_1
                                              .length
                                              : data.length,

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
                                      onPressed: () {
                                        ref.read(getproductreleseexportexcelNotifier.notifier).getproductreleseexport();
                                      },
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

  List<WorkorderModel> generateItems(List<WorkorderModel> mdata,  int count) {
    return List<WorkorderModel>.generate(count, (int index) {
      List<WorkorderList> wolst = [];
      for(int i = 0; i< mdata[index].woList!.length; i++){
        if(mdata[index].workorderId == mdata[index].woList![i].workorder_id ){
          WorkorderList wlist = WorkorderList(
            id: mdata[index].woList![i].id,
            workorder_id: mdata[index].woList![i].workorder_id,
            product_id: mdata[index].woList![i].product_id,
            product_name: mdata[index].woList![i].product_name,
            quantity:mdata[index].woList![i].quantity,
            start_serial_no: mdata[index].woList![i].start_serial_no,
            end_serial_no: mdata[index].woList![i].end_serial_no,
            status: mdata[index].woList![i].status,
            testing_status: mdata[index].woList![i].testing_status,
            start_date: mdata[index].woList![i].start_date,
            end_date: mdata[index].woList![i].end_date,
            flg: mdata[index].woList![i].flg,
          );
          wolst.add(wlist);
        }
      }



      return WorkorderModel(
          workorderId: mdata[index].workorderId,
          workorderCode: mdata[index].workorderCode,
          quantity: mdata[index].quantity,
          startSerialNo: mdata[index].startSerialNo,
          endSerialNo: mdata[index].endSerialNo,
          status: mdata[index].status,
          createdBy: mdata[index].createdBy,
          updatedBy: mdata[index].updatedBy,
          createdDate: mdata[index].createdDate,
          updatedDate: mdata[index].updatedDate,
          flg: mdata[index].flg,
          remarks: mdata[index].remarks,
          woList: wolst);









      /*workprogess(
        productId: mdata[index].productId,
        productCode: mdata[index].productCode,
        productName: mdata[index].productName,
        productQty: mdata[index].productQty,
        workorderId: mdata[index].workorderId,
        workOrder: mdata[index].workOrder.toString(),
        workOrderQty: mdata[index].workOrderQty,
        startingSerialNumber: mdata[index].startingSerialNumber.toString(),
        endingSerialNumber: mdata[index].endingSerialNumber.toString(),
        totalTestUnit: mdata[index].totalTestUnit,
        testStartDate: mdata[index].testStartDate.toString(),
        testEndDate: mdata[index].testEndDate.toString(),
        qtyPassed: mdata[index].qtyPassed,
        qtyFailed: mdata[index].qtyFailed,
        testingStatus: mdata[index].workOrder.toString(),

      );*/
    });
  }
  getWorkorderdetails(List<WorkorderModel> mdata, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: (){
                    print("print workorderid------>${mdata[index].workorderId}");
                    mdata[index].workorderId;
                    ref.read(workorderunderproductReportNotifier.notifier).workorderunderproductReport(mdata[index].workorderId);

                  },
                  child: Container(
                    height: 30.0,
                    width: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(_textEditing_3Controller.text.isNotEmpty
                            ? glossarListOnSearch_3[index].workorderCode.toString()
                            :  mdata[index].workorderCode.toString(),

                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0,
                                color: Colors.black)),

                      /*  Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].workorderId.toString()
                                :  mdata[index].workorderId.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].workOrderQty.toString()
                                : mdata[index].productQty.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].startingSerialNumber.toString()
                                :  mdata[index].startingSerialNumber.toString(),


                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].endingSerialNumber.toString()
                                :  mdata[index].endingSerialNumber.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].totalTestUnit.toString()
                                :  mdata[index].totalTestUnit.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].qtyPassed.toString()
                                :  mdata[index].qtyPassed.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(_textEditing_3Controller.text.isNotEmpty
                                ? glossarListOnSearch_3[index].qtyFailed.toString()
                                :  mdata[index].qtyFailed.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),*/

                       /* Expanded(
                          child: Center(
                            child: Text((){
                              if(_textEditing_3Controller.text.isNotEmpty){
                               return glossarListOnSearch_3[index].qtyPassed.toString() == "0"
                                   && glossarListOnSearch_3[index].qtyFailed.toString() == "0" ? ""
                                   : glossarListOnSearch_3[index].testStartDate.toString().split(" ")[0];
                              }else{
                               return  mdata[index].qtyPassed.toString() == "0"
                                    && mdata[index].qtyFailed.toString() == "0" ? ""
                                    : mdata[index].testStartDate.toString().split(" ")[0];
                              }

                            }(),


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
                                  if(_textEditing_3Controller.text.isNotEmpty){
                                    return  glossarListOnSearch_3[index].qtyPassed.toString() == "0"
                                        && glossarListOnSearch_3[index].qtyFailed.toString() == "0" ? ""
                                        : glossarListOnSearch_3[index].testStartDate.toString().split(" ")[0];
                                  }else{
                                    return   mdata[index].qtyPassed.toString() == "0"
                                        && mdata[index].qtyFailed.toString() == "0" ? ""
                                        : mdata[index].testStartDate.toString().split(" ")[0];
                                  }

                                }(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),*/
                      ],
                    ),
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



  getWorkorderunderproduct( List<workorderunderproduct> mdata, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: (){
                  },
                  child: Container(
                    height: 30.0,
                    width: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text( mdata[index].productName.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text( mdata[index].startingSerialNumber.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text( mdata[index].endingSerialNumber.toString(),


                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text( mdata[index].totalTestUnit.toString(),

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text( mdata[index].testingStatus.toString(),

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
                          child: Text( _textEditing_2Controller.text.isNotEmpty
                              ? glossarListOnSearch_2[index].workOrder.toString()
                              : tester[index].workOrder.toString(),


                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text( _textEditing_2Controller.text.isNotEmpty
                              ? glossarListOnSearch_2[index].productName.toString()
                              : tester[index].productName.toString(),

                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(_textEditing_2Controller.text.isNotEmpty
                              ? glossarListOnSearch_2[index].serial_no.toString()
                              : tester[index].serial_no.toString(),

                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(_textEditing_2Controller.text.isNotEmpty
                              ? glossarListOnSearch_2[index].testResult.toString()
                              : tester[index].testResult.toString(),

                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text((){
                            var str = _textEditing_2Controller.text.isNotEmpty
                                ? glossarListOnSearch_2[index].testedDate.toString().split('T')[0]
                                :  tester[index].testedDate.toString().split('T')[0];
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
                          child: GestureDetector(
                            onTap: ()async{
                              ref.read(gettesterexcelNotifier.notifier).gettester(tester[index].productId, tester[index].serial_no);

/*

                              apiLink = "http://192.168.1.55//PAT_API/ReportExport/TestingReportExcelExport_100_16-05-2023.xls";
                              savePath = gg + "\\" + "TestingReportExcelExport_100_16-05-2023.xls" ;
                              downloadExcelFile(apiLink!, savePath!);

                              final downloadedFilePath = savePath;

                              openExcelFile(downloadedFilePath!);
*/



                            },
                            child: Text("https//link_to_open_report",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.blue)),
                          ),
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
 /* getworkorderbasedtest(List<NewWorkorderbasedReport> workorder, int index) {
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
  }*/


  getworkorderbasedtestdetails(List<NewWorkorderbasedReport> mData, int index) {
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
                          child: Text(
                              _textEditing_1Controller.text.isNotEmpty
                                  ? glossarListOnSearch_1[index].productName.toString()
                                  : mData[index].productName.toString(),

                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text( _textEditing_1Controller.text.isNotEmpty
                              ? glossarListOnSearch_1[index].serialNo.toString()
                              : mData[index].serialNo.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(_textEditing_1Controller.text.isNotEmpty
                              ? glossarListOnSearch_1[index].testStage.toString()
                              : mData[index].testStage.toString(),

                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(_textEditing_1Controller.text.isNotEmpty
                              ? glossarListOnSearch_1[index].testedBy.toString()
                              : mData[index].testedBy.toString(),

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
                                var str = _textEditing_1Controller.text.isNotEmpty
                                    ? glossarListOnSearch_1[index].testedDate.toString().split('T')[0]
                                    : mData[index].testedDate.toString().split('T')[0];
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
                          child: Text(_textEditing_1Controller.text.isNotEmpty
                              ? glossarListOnSearch_1[index].testResult.toString()
                              : mData[index].testResult.toString(),

                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: (){

                              ref.read(getworkorderexcelNotifier.notifier).addworkorder(mData[index].workorderId, mData[index].productId,mData[index].serialNo);




/*
                              apiLink = "http://192.168.1.55//PAT_API/ReportExport/WOReportExcelExport_100_17-05-2023.xls";
                              savePath = gg + "\\" + "WOReportExcelExport_100_17-05-2023.xls" ;
                              downloadExcelFile(apiLink!, savePath!);

                              final downloadedFilePath = savePath;

                              openExcelFile(downloadedFilePath!);*/
                            },
                            child: Text("https//link_to_open_report",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.blue)),
                          ),
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

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: (){
                  },
                  child: Container(
                    height: 30.0,
                    width: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text( "pro name",

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text( "start serial",

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text( "end serial",


                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text( "tested unit",

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black)),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text( "testing status",

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
              ),
            ],
          ),
          leading: Text("")
        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}






