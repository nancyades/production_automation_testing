import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:production_automation_testing/Helper/application_class.dart';
import 'package:production_automation_testing/Helper/packet_control.dart';
import 'package:production_automation_testing/Model/resultmodel.dart';
import 'package:production_automation_testing/Model/testmodel.dart';
import 'package:production_automation_testing/Provider/post_provider/test_provider.dart';
import 'package:production_automation_testing/Provider/tcpprovider/tcp_provider_receive_data.dart';
import 'package:production_automation_testing/Provider/testProvider.dart';
import 'package:production_automation_testing/noofpages/Test/firsrtaskviewpage.dart';
import 'package:production_automation_testing/noofpages/Test/secondtaskviewpage.dart';
import 'package:production_automation_testing/noofpages/Test/tasklistscreen.dart';
import 'package:production_automation_testing/noofpages/TestCompleted/test_completed.dart';
import 'package:production_automation_testing/noofpages/dashboardscreenpage.dart';
import 'package:production_automation_testing/noofpages/Task/taskpage.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/workorderscreenpage.dart';
import 'package:production_automation_testing/noofpages/Product/product.dart';
import 'package:production_automation_testing/noofpages/setting/settingpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Helper/AppClass.dart';
import '../../Helper/helper.dart';
import '../../HomeScreen.dart';
import '../../Model/APIModel/taskmodel.dart';
import '../../Model/readexcel/readecel.dart';
import '../../NavigationBar/src/company_name.dart';
import '../../NavigationBar/src/navbar.dart';
import '../../Provider/changenotifier/widget_notifier.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/generalProvider.dart';
import '../../Provider/post_provider/result_provider.dart';
import '../../Provider/tcpprovider/tcp_provider_send_data.dart';
import '../../service/tcpclient.dart';
import '../Users/user.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreenPage extends ConsumerStatefulWidget {
  dynamic testtype;
  List<Testing>? testlist;
  TaskModel? tsk;
  String? stages;

  TestScreenPage({Key? key, this.testtype, this.testlist, this.tsk, this.stages}) : super(key: key);

  @override
  ConsumerState<TestScreenPage> createState() => _TestScreenPageState();
}

class _TestScreenPageState extends ConsumerState<TestScreenPage> {
  String fir_radiotype = "01";
  String sec_radiotype = "02";

  final screen = [
    DashboardScreenPage(),
    WorkOrderScreenPage(),
    ProductPage(),
    TaskPage(),
    UserPage(),
    TestPage(),
    SettingPage()
  ];

  List<radTest> items = <radTest>[];
  int groupValue = 0;
  int indices = 0;

  String rType = "";

  bool isPressed = true;

  var stopWatchTimer;
  var sec = 00, min = 00, hour = 00;
  var fontSize, height;

  bool isNow = false;

  TextEditingController macaddresscontroller = TextEditingController();
  TextEditingController producttitlecontroller = TextEditingController();
  TextEditingController serialnocontroller = TextEditingController();
  TextEditingController jigaddresscontroller = TextEditingController(text: '');

  List<TextEditingController> generalController=[];

  TextEditingController mac = TextEditingController();

  String? choice;
  
  var startserialno;
  var endserialno;
  bool isEast = false;
  var userEntry;

  bool isCommunicate = false;

  List<List<Testing>> test = [];

  int k = 0;
  bool isOnlineTestStarted = false;
  Map<int, OnlineTestModel> onlineTestIds = {};
  List<OnlineTestModel> testList = [];
  int i = 0;

  List<Testing>? testlist = [];

  bool value = true;

   var displayTime;

   List<Results> reslt = [];

  List<Results> ted = [];
  int jk = 0;

  List<Results> uniquelist =[];

  int? totalSeconds;

  @override
  void initState() {
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      onChange: (value) => hour = value,
      onChangeRawSecond: (value) => sec = value,
      onChangeRawMinute: (value) => min = value,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      stopWatchTimer.onExecute.add(StopWatchExecute.start);


      jigaddresscontroller.text =
          await ApplicationClass().getStringFormSharePreferences('Jig') ?? '';
    });


    super.initState();

    for(int i=0;i<100;i++){
      generalController.add(TextEditingController(text: ""));
    }
  }

  String? receivedData;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    
   
    startserialno = int.parse(widget.tsk!.startSerialNo!.toString());
    endserialno = int.parse(widget.tsk!.endSerialNo!.toString());

    producttitlecontroller.text = widget.tsk!.product!.productName.toString();
    fontSize = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    List<FirstTest>? alltest = ref.watch(getallestNotifier).value;



    if (receivedData == null) {
      receivedData = Helper.tcpResponse;
    }

    if (alltest == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    List<int> ind = [];
    List<List<Testing>> ind2 = [];
    List<List<Testing>> ind3 = [];
    List<Testing> ss = <Testing>[];
    int j = 0;
    
    
    for(int i=0; i<widget.testtype[0].length; i++){
      for(int j=0; j<widget.testlist!.length; j++){
        if (widget.testtype[0][i] == widget.testlist![j].testStatus){
          ss.add(widget.testlist![j]);
          ss.sort((a, b) => a.testNumber!.compareTo(b.testNumber!));
        }
      }
      ind2.add(ss);
      //uniquelist.sort((a, b) => a.testNumber!.compareTo(b.testNumber!));
      ss = [];
    }



   /* for (int i = 0; i < widget.testlist!.length; i++) {
      if (widget.testtype[0].length > j) {
        for(int m = 0; m<widget.testtype[0].length; m++)
        if (widget.testlist![i].testStage == widget.testtype[0][m]) {


          if (ss.length != 0) {
            ind2.add(ss);
            ss = <Testing>[];
          }
          ss.add(widget.testlist![i]);
        }
      }
    }

    ind2.add(ss);*/

    for (int i = 0; i < ind2.length; i++) {
      List<Testing> list1 = <Testing>[];
      list1 = ind2[i].toList();

      if (widget.testtype[0].length > j) {
        if (widget.testtype[0][j].toString() == list1[0].testStatus.toString()) {
          ind3.add(list1);

          j++;
        }
      }
    }

    if (ind3.length >= k && test.isEmpty) {
      test.add(ind3[k]);
      if (test.isNotEmpty) {
        Helper.selectedTest = ind3;
      }
    }

    return Scaffold(
      body: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: 100,
              color: Color(0xff333951),
              child: Stack(
                children: [
                  CompanyName(),
                  Align(alignment: Alignment.center, child: NavBar()),
                ],
              ),
            ),
          ),
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
                    padding: const EdgeInsets.only(left: 10.0, top: 20, right: 20, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       /* IconButton(
                            onPressed: () {
                             // ref.refresh(gettesttypeNotifier);
                              Navigator.of(context).pop();
                              Helper.classes = "TEST";
                            },
                            icon: Icon(Icons.arrow_back_outlined)),*/
                        Text(
                          "Product Test",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            onPressed: () async {
                              ref.read(testStartedProvider.notifier).state = false;
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => HomeScreenPage()));
                            },
                            child: const Text('DASHBOARD')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.95,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2.0),
                        ),
                        child: Card(
                          color: Colors.white,
                          elevation: 70,
                          child: Column(
                            children: [
                              Container(
                                height: 200.0,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Product Title : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.red),
                                                ),
                                                SizedBox(
                                                  width: fontSize * 0.15,
                                                  height: height * 0.05,
                                                  child: TextField(
                                                    maxLength: 10,
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 10.0),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.0)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          1.0)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          1.0)),
                                                    ),
                                                    cursorColor: Colors.red,
                                                    controller:
                                                        producttitlecontroller,
                                                    onChanged: (val) {},
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            fontSize! * 0.010,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Serial Number : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.red),
                                                ),
                                                SizedBox(
                                                  width: fontSize * 0.15,
                                                  height: height * 0.05,
                                                  child: TextField(
                                                    maxLength: 10,
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 10.0),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.0)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          1.0)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          1.0)),
                                                    ),
                                                    cursorColor: Colors.red,
                                                    controller:
                                                        serialnocontroller,
                                                    onChanged: (val) {
                                                      ref
                                                          .read(
                                                              serialNoTestProvider
                                                                  .notifier)
                                                          .state = val;
                                                    },
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            fontSize! * 0.010,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                 " ${"Note:  " +
                                                      startserialno.toString() +
                                                    "-"
                                                    + endserialno.toString()
                                                  }",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 10.0,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Jig Address : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.red),
                                                ),
                                                SizedBox(
                                                  width: fontSize * 0.15,
                                                  height: height * 0.05,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 10.0),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.0)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          1.0)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          1.0)),
                                                    ),
                                                    cursorColor: Colors.red,
                                                    controller:
                                                        jigaddresscontroller,
                                                    onChanged: (val) {
                                                      saveJigAddress(val);
                                                      ref
                                                          .read(
                                                              jigAddressTestProvider
                                                                  .notifier)
                                                          .state = val;
                                                    },
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            fontSize! * 0.010,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Consumer(
                                              builder: (context, ref, child) {
                                                String mac =
                                                ref.watch(macAddressTestProvider);
                                                macaddresscontroller.text = mac;
                                                return Row(
                                                  children: [
                                                    Text(
                                                      "MAC Address : ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.0,
                                                          color: Colors.red),
                                                    ),
                                                    SizedBox(
                                                      width: fontSize * 0.15,
                                                      height: height * 0.05,
                                                      child: TextField(
                                                        maxLength: 10,
                                                        decoration: InputDecoration(
                                                          counterText: '',
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 10.0),
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 1.0)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color: Colors
                                                                              .white,
                                                                          width:
                                                                              1.0)),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color: Colors
                                                                              .white,
                                                                          width:
                                                                              1.0)),
                                                        ),
                                                        cursorColor: Colors.red,
                                                        controller:
                                                            macaddresscontroller,
                                                        onChanged: (val) {},
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                fontSize! * 0.010,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer_outlined,
                                                  size: 30,
                                                  color: Colors.blueGrey,
                                                ),
                                                StreamBuilder<int>(
                                                  stream:
                                                      stopWatchTimer.rawTime,
                                                  initialData: stopWatchTimer
                                                      .rawTime.value,
                                                  builder: (context, snapshot) {
                                                    final value =
                                                        snapshot.data!;
                                              displayTime =
                                                        StopWatchTimer
                                                            .getDisplayTime(
                                                                value,
                                                                hours: true,
                                                                milliSecond:
                                                                    false);

                                                    List<String> timeParts = displayTime.split(':'); // split the raw time value into its individual parts
                                                    int hours = int.parse(timeParts[0]); // parse the hours part as an integer
                                                    int minutes = int.parse(timeParts[1]); // parse the minutes part as an integer
                                                    int seconds = int.parse(timeParts[2]); // parse the seconds part as an integer
                                                     totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

                                                    return Text(
                                                      displayTime,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize:
                                                              fontSize * 0.015,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ind3[k][0].testStatus.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Consumer(
                                            builder: (context, ref, child) {
                                          bool status =
                                              ref.watch(testStartedProvider);

                                          if (ind3[k][0].isOnline == "1" && isPressed == true) {
                                            value = true;
                                          }else{
                                            value = false;
                                          }
                                          return Visibility(
                                            visible: value,
                                            child: ElevatedButton(
                                                child: Text("START ".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14)),
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
                                                            side: BorderSide(color: Colors.black)))),
                                                onPressed: () async {
                                                  print(
                                                      "ispressed---------------------> ${isPressed}");
                                                  jigAddress =
                                                      await ApplicationClass().getStringFormSharePreferences('Jig') ?? '';
                                                  if (jigAddress.isNotEmpty) {
                                                    serverIp = jigAddress;
                                                  }
                                                  if (jigAddress.isEmpty) {
                                                    final snackBar = SnackBar(
                                                      content: const Text(
                                                          'Please Enter the Test Jig Address'),
                                                      backgroundColor:
                                                          (Colors.black),
                                                    );
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                  } else if (ref.read(serialNoTestProvider.notifier).state.isEmpty) {
                                                    final snackBar = SnackBar(
                                                      content: const Text(
                                                          'Please Enter the Test Serial No'),
                                                      backgroundColor:
                                                          (Colors.black),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  } else {
                                                    setState(() {
                                                      isPressed = false;
                                                      isNow = true;
                                                    });

                                                    serialnocontroller.text = ref.read(serialNoTestProvider.notifier).state;
                                                    if (onlineTestIds.isNotEmpty) {
                                                      print(onlineTestIds);
                                                      Future.delayed(const Duration(microseconds: 1000), () {
                                                        splitExcelOnlineTestData(
                                                            onlineTestIds);
                                                      });

                                                      ref.read(testStartedProvider.notifier).state = true;


                                                    }
                                                  }
                                                }),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(' '),
                                      Expanded(
                                        child: Container(
                                          height: 20.0,
                                          width: 10.0,
                                          child: Center(
                                              child: Text("Test Id",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 15.0,
                                                      color: Colors.black))),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20.0,
                                          width: 10.0,
                                          child: Center(
                                              child: Text("Test",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black))),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20.0,
                                          width: 10.0,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Option",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ],
                                          )),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('')
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20.0,
                                          width: 10.0,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Result",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
//===============================================  first test listview builder =========================================================
                              Expanded(
                                flex: 4,
                                child: Consumer(builder: (context, ref, child) {
                                  ref.watch(tcpReceiveDataNotifier).id.when(
                                      data: (data) {
                                        if (data.isNotEmpty &&
                                            data != 'TimeOut') {
                                          Future.delayed(
                                              const Duration(milliseconds: 5),
                                              () {
                                            ref.refresh(tcpReceiveDataNotifier);
                                            if (testList.length - 1 > i) {
                                              i++;
                                              ref
                                                  .read(tcpSendDataNotifier
                                                      .notifier)
                                                  .sendPacket(
                                                      testList[i]
                                                          .packet
                                                          .toString(),
                                                      testList[i]
                                                          .taskNo
                                                          .toString());
                                            }
                                          });
                                        }
                                      },
                                      error: (e, s) {},
                                      loading: () {});

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 500,
                                            color: Color(0xFFd9d8d7),
                                            child: ListView.builder(
                                                controller: ScrollController(),
                                                //controller: _controller,

                                                itemCount: ind3[k].length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  if (!isOnlineTestStarted) {
                                                    isOnlineTestStarted = true;
                                                  }
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 10),
                                                      () {
                                                    onlineTestIds.clear();
                                                    for (int i = 0; i < ind3[k].length; i++) {
                                                      switch (ind3[k][i].type.toString()) {
                                                        case 'FAILACK':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + ind3[k][i].pktType!.toString() +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetId!.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testNumber);
                                                          break;
                                                        case 'SERIALNO':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + ind3[k][i].pktType.toString() +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetId!.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testNumber);
                                                          break;
                                                        case 'MAC':
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      25), () {
                                                            onlineTestIds[i] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].pktType.toString() +
                                                                    PacketControl.splitChar +
                                                                    ApplicationClass().formDigits(3, ind3[k][i].packetId!.toString())! +
                                                                    PacketControl.endPacket,
                                                                ind3[k][i].testNumber);
                                                          });
                                                          break;
                                                        case 'UNIT':
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      20), () {
                                                            onlineTestIds[i] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].pktType.toString() +
                                                                    PacketControl.splitChar +
                                                                    ApplicationClass().formDigits(3, ind3[k][i].packetId!.toString())! +
                                                                    PacketControl.endPacket,
                                                                ind3[k][i].testNumber);
                                                          });
                                                          break;
                                                        case 'UNITCAL':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + PacketControl.readPacket +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetId.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testNumber);
                                                          break;
                                                        case 'UNITACK':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + ind3[k][i].pktType.toString() +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetId.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testNumber);
                                                          break;
                                                          case 'UNITREMARK':
                                                          if (ind3[k][i].isOnline == "0"? false : true) {
                                                                onlineTestIds[i] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].pktType.toString() + PacketControl.splitChar +
                                                                ApplicationClass().formDigits(3, ind3[k][i].packetId.toString())! + PacketControl.endPacket,
                                                                ind3[k][i].testNumber!);
                                                                }
                                                                break;
                                                          case 'USERACK':
                                                            onlineTestIds[index] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].pktType.toString() + PacketControl.splitChar +
                                                                    ApplicationClass().formDigits(3, ind3[k][i].packetId!)! + PacketControl.endPacket,
                                                                ind3[k][i].testNumber!
                                                            );
                                                            break;


                                                      }
                                                    }
                                                  });

                                                  return getAllTest(ind3[k], index);
                                                })),
                                      ],
                                    ),
                                  );
                                }),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, bottom: 15),
                                child: ElevatedButton(
                                    child: Text("NEXT TEST".toUpperCase(),
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


                                      if(int.parse(serialnocontroller.text)  < startserialno || int.parse(serialnocontroller.text)  > endserialno ){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("IN-valid Serial No!!! ")));

                                      }else{
                                        if (test.isNotEmpty) {
                                          print("print test k-----------------> ${test}");
                                          for(int i=0;i<test[0].length; i++){
                                            ref.read(updateTestNotifier.notifier).updatetTest({
                                              "test_id": test[0][i].testId,
                                              "task_id": test[0][i].taskId,
                                              "test_stage": int.parse(widget.stages.toString()),
                                              "test_status": test[0][i].testStatus,
                                              "pass": test[0][i].displayResult == "PASS" ? 1 : 0,//pass
                                              "fail": test[0][i].displayResult == "FAIL" ? 1 : 0,//fail
                                              "status": test[0][i].displayResult == "PASS" ? "PASS": "FAIL",//satuts
                                              "flg": 1,
                                              "mac_address": null,
                                              "test_type": test[0][i].testType ,
                                              "test_date": test[0][i].testDate,
                                              "hours_taken": totalSeconds,
                                              "test_number": test[0][i].testNumber,
                                              "test_Name": test[0][i].testName,
                                              "isOnline": test[0][i].isOnline,
                                              "type": test[0][i].type,
                                              "packetID": test[0][i].packetId,
                                              "pkt_Type": test[0][i].pktType,
                                              "user_Entry": test[0][i].userEntry,
                                              "wifi_Result": test[0][i].wifiResult,
                                              "pass_Crieteria": test[0][i].passCrieteria,
                                              "remarks": test[0][i].remarks,
                                              "serial_no": serialnocontroller.text

                                            });
                                          }

                                          for(var ele in test[0]){

                                            if(ele.result == null && ele.displayResult == "UNDEFINED" ){
                                              return showfailedTest();
                                            }
                                            else if(ele.remarks == null && ele.displayResult == "FAIL"){
                                              return showRemarks();
                                            }



                                          }

                                          for(var element in test[0]){
                                            element.result = "";
                                            element.displayResult = "";
                                          }
                                          test.clear();

                                        }
                                        setState(() {
                                          if ((ind3.length) - 1 > k ) {
                                            k++;
                                            {
                                              print("hello nancyy!!!!!!!!!!!");

                                              if(isNow == true){
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1000), () {
                                                  splitExcelOnlineTestData(
                                                      onlineTestIds);
                                                });
                                              }
                                            }

                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TestCompleted(tasks: widget.tsk,)));
                                            stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                                            Helper.classes = "TEST";
                                          }

                                          if (test.isEmpty) {

                                            test.add(ind3[k]);

                                          }
                                          isEast = false;
                                        });


                                        for(int i=0; i< uniquelist.length; i++){
                                          ref.read(addResultNotifier.notifier).addResult( {
                                            "test_id": uniquelist[i].testId,
                                            "spend_time": uniquelist[i].spendTime,
                                            "status": uniquelist[i].status.toString(),
                                            "flg": 1
                                          });
                                        }
                                        generalController.clear();
                                        for(int i=0;i<100;i++){
                                          generalController.add(TextEditingController(text: ""));
                                        }
                                      }

                                      /* Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => TestScreenPage()));*/
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
        ],
      ),
    );
  }

  getAllTest(List<Testing> radio, int index) {





    if(radio[index].type.toString() == "FLAG" || radio[index].type.toString() == "SERIALNO" ){

    }else{
      Results tt = Results(
          testId: radio[index].testId,
          status: radio[index].displayResult.toString(),
          flg: radio[index].flg,
          spendTime: totalSeconds

      );
      if(radio[index].displayResult.toString() != "UNDEFINED"){
        ted.add(tt);
      }

      var seen = Set<String>();

      uniquelist = ted.where((student) => seen.add(student.testId.toString())).toList();

    }







/*
    if( Helper.isRemarks == "Lol")
      {
        radio[index].displayResult.toString() == "null";
        radio[index].displayResult.toString() == "PASS";
      }*/

    if (isEast == false) {
      radio[index].radiotype = "";
      //radio[index].displayResult.toString() == "null";
      //radio[index].displayResult.toString() == "PASS";
    }
    for (var firstElement in Helper.selectedTest) {

      if (firstElement.isNotEmpty) {
        for (var secondElement in firstElement) {
          if (secondElement != null) {
            if (testlist != null) {
              testlist!.add(secondElement);
            }
          }
        }
      }
    }
    if (isEast == false) {
      radio[index].radiotype = "";
      testlist![index].radiotype = "";
    }
    bool changeUi = false;

    dynamic testType = Text("error occured");

    var boxColor = Colors.yellow;
    var statusText = 'InQueue';
    var progressVisibility = true;

    switch (radio[index].type.toString()) {
//**********************************************FLAG TEST ********************************************************************
      case 'FLAG':
        testType = Row(
          children: [
            Radio(
              value: "01",
              groupValue: radio[index].radiotype,
              onChanged: (value) {
                setState(() {
                  print("first---------> ${radio[index].userEntry!.split('/')[0]}");
                  print("second---------> ${radio[index].userEntry!.split('/')[1]}");




                     if(radio[index].userEntry!.split("/")[0].toString() == "YES ")
                       {
                         userEntry = "YES";
                         if(userEntry == radio[index].passCrieteria){
                           radio[index].setResult("PASS");
                           radio[index].setDisplayResult('PASS');

                         }
                         else {
                           radio[index].setResult("FAIL");
                           radio[index].setDisplayResult('FAIL');
                         }
                       }else if(radio[index].userEntry!.split("/")[0].toString()   == "OK")
                       {
                         userEntry = "OK";

                         if(userEntry == radio[index].passCrieteria)
                         {
                           radio[index].setResult("PASS");
                           radio[index].setDisplayResult('PASS');
                         }  else {
                           radio[index].setResult("FAIL");
                           radio[index].setDisplayResult('FAIL');
                         }

                        }else if(radio[index].userEntry!.split("/")[0].toString()   == "SHORT")
                     {
                       userEntry = "SHORT";

                       if(userEntry == radio[index].passCrieteria)
                       {
                         radio[index].setResult("PASS");
                         radio[index].setDisplayResult('PASS');
                       }  else {
                         radio[index].setResult("FAIL");
                         radio[index].setDisplayResult('FAIL');
                       }

                     }
                     else if(radio[index].userEntry!.split("/")[0].toString()   == "PASS")
                     {
                       userEntry = "PASS";

                       if(userEntry == radio[index].passCrieteria)
                       {
                         radio[index].setResult("PASS");
                         radio[index].setDisplayResult('PASS');
                       }  else {
                         radio[index].setResult("FAIL");
                         radio[index].setDisplayResult('FAIL');
                       }

                     }else if(radio[index].userEntry!.split("/")[0].toString() == "YES")
                  {
                    userEntry = "YES";
                    if(userEntry == radio[index].passCrieteria){
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');

                    }
                    else {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }
                  }
/*

                  if(uniquelist.isNotEmpty){
                    for(int i=0; i<uniquelist.length; i++){
                      uniquelist[i].status = radio[index].displayResult.toString();
                    }
                  }

*/

                  Results tt = Results(
                      testId: radio[index].testId,
                      status: radio[index].displayResult.toString(),
                      flg: radio[index].flg,
                      spendTime: totalSeconds

                  );
                  if(ted.isEmpty){
                    if(radio[index].displayResult.toString() != "UNDEFINED"){
                      ted.add(tt);
                    }
                  }else{
                    for(int i=0; i<ted.length; i++){
                      if(ted[i].testId == radio[index].testId){
                        ted.remove(ted[i]);
                      }
                    }
                    ted.add(tt);

                  }

                  var seen = Set<String>();

                  uniquelist = ted.where((student) => seen.add(student.testId.toString())).toList();




                  radio[index].radiotype = value.toString();
                  switch (value) {
                    case '01':
                      choice = value.toString();
                      isEast = true;
                      break;
                    case '02':
                      choice = value.toString();
                      isEast = true;
                      break;
                    default:
                      choice = null;
                  }

                  debugPrint(choice); //Debug the choice in console

                  Helper.classes = "DEMO";


                });
              },
            ),
            Text(radio[index].userEntry!.split('/')[0],
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                    color: Colors.black)),
            SizedBox(
              width: 5,
            ),
            Radio(
              value: "02",
              groupValue: radio[index].radiotype,
              onChanged: (value) {
                setState(() {
                  print("first---------> ${radio[index].userEntry!.split('/')[0]}");
                  print("second---------> ${radio[index].userEntry!.split('/')[1]}");

                  if(radio[index].userEntry!.split("/")[0].toString() == "YES ")
                  {
                    userEntry = "NO";
                    if(userEntry == radio[index].passCrieteria){
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');

                    }
                    else {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }
                  }else  if(radio[index].userEntry!.split("/")[0].toString() == "OK" )
                  {
                    userEntry = "NOK";

                    if(userEntry == radio[index].passCrieteria)
                    {
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');
                    }  else {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }

                  }else  if(radio[index].userEntry!.split("/")[0].toString() == "SHORT")
                  {
                    userEntry = "NO SHORT";

                    if(userEntry == radio[index].passCrieteria)
                    {
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');
                    }  else {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }

                  }
                  else if(radio[index].userEntry!.split("/")[0].toString()   == "PASS")
                  {
                    userEntry = "FAIL";

                    if(userEntry == radio[index].passCrieteria)
                    {
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');
                    }  else {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }

                  }else if(radio[index].userEntry!.split("/")[0].toString() == "YES")
                  {
                    userEntry = "NO";
                    if(userEntry == radio[index].passCrieteria){
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');

                    }
                    else {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }
                  }

                 /* if(uniquelist.isNotEmpty){
                    for(int i=0; i<uniquelist.length; i++){
                      uniquelist[i].status = radio[index].displayResult.toString();
                    }
                  }*/


                  Results tt =  Results(
                      testId: radio[index].testId,
                      status: radio[index].displayResult.toString(),
                      flg: radio[index].flg,
                      spendTime: totalSeconds

                  );
                  if(ted.isEmpty){
                    if(radio[index].displayResult.toString() != "UNDEFINED"){
                      ted.add(tt);
                    }
                  }else{
                    for(int i=0; i<ted.length; i++){
                      if(ted[i].testId == radio[index].testId){
                        ted.remove(ted[i]);
                      }
                    }
                    ted.add(tt);

                  }

                  var seen = Set<String>();

                  uniquelist = ted.where((student) => seen.add(student.testId.toString())).toList();



                  radio[index].radiotype = value.toString();
                  switch (value) {
                    case '01':
                      choice = value.toString();

                      isEast = true;
                      break;
                    case  '02':
                      choice = value.toString();

                      isEast = true;
                      break;
                    default:
                      choice = null;
                  }
                  debugPrint(choice);
                  Helper.classes = "DEMO";
                });
              },
            ),
            Text(radio[index].userEntry!.split('/')[1],
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                    color: Colors.black)),
          ],
        );
        break;
//**********************************************VALUE TEST ********************************************************************
      case 'Value':
        testType = IntrinsicWidth(
          stepWidth: fontSize * 0.1,
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: TextField(
                  cursorColor: Colors.red,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black),
                  maxLength: 20,
                  onChanged: (val) {
                    print("print val------> ${val}");
                    print("print val------> ${radio[index].passCrieteria}");

                    setState(() {
                      if (val.isEmpty) {
                        radio[index].setDisplayResult('UNDEFINED');
                      }
                      if (radio[index].passCrieteria!.contains('-')) {
                        List<String> arr =
                            radio[index].passCrieteria!.split('-'); // 115 < 125
                        num value, leftExpValue, rightExpValue;
                        if (radio[index].passCrieteria!.contains('.')) {
                          value = double.parse(val.trim());
                          leftExpValue = double.parse(arr[0].trim());
                          rightExpValue = double.parse(arr[1].trim());
                        } else {
                          value = int.parse(val.trim());
                          leftExpValue = int.parse(arr[0].trim());
                          rightExpValue = int.parse(arr[1].trim());
                        }

                        if (value > leftExpValue && value < rightExpValue) {
                          radio[index].setDisplayResult('PASS');
                        } else {
                          radio[index].setDisplayResult('FAIL');
                        }
                      }
                      else if (radio[index].passCrieteria!.contains('-')) {
                        List<String> arr =
                            radio[index].passCrieteria!.split('-'); // 115 > 125

                        num value, leftExpValue, rightExpValue;
                        if (radio[index].passCrieteria!.contains('.')) {
                          value = double.parse(val.trim());
                          leftExpValue = double.parse(arr[0].trim());
                          rightExpValue = double.parse(arr[1].trim());
                        } else {
                          value = int.parse(val.trim());
                          leftExpValue = int.parse(arr[0].trim());
                          rightExpValue = int.parse(arr[1].trim());
                        }

                        if (value < leftExpValue && value > rightExpValue) {
                          radio[index].setDisplayResult('PASS');
                        } else {
                          radio[index].setDisplayResult('FAIL');
                        }
                      }

                    });

                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.black12,
                      filled: true,
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(6.0)))),
                ),
              ),
              Row(
                children: [
                  Text("In ",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black)),
                ],
              ),
            ],
          ),
        );
        break;
//***********************************************FAILACK TEST****************************************************************
      case 'FAILACK':
        if (radio[index].result == 'PASS') {
          boxColor = Colors.green;
          statusText = 'COMPLETED';
          progressVisibility = false;
        } else if (radio[index].result == 'TimeOut') {
          boxColor = Colors.indigo;
          statusText = 'Time out';
          progressVisibility = false;
          radio[index].setRemarks("Failed");
        } else if (radio[index].result == 'FAIL') {
          radio[index].setRemarks("Failed");
          Future.delayed(const Duration(milliseconds: 1), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreenPage()));
          });
          Future.delayed(const Duration(milliseconds: 3), () {
            popDialog(
                title: 'Connection Failed',
                msg: 'Connection error please restart your testJig',
                context: context);
          });
        }
        else {
          if (ref.read(testStartedProvider.notifier).state) {
            if (ref.read(lastTestSentProvider.notifier).state ==
                radio[index].testNumber) {
              boxColor = Colors.yellow;
              statusText = 'TESTING';
              progressVisibility = true;

            } else {
              boxColor = Colors.orange;
              statusText = 'IN QUEUE';
              progressVisibility = true;


            }
          } else {
            boxColor = Colors.yellow;
            statusText = 'Yet Stared';
            progressVisibility = false;
          }

        }
      /*  print("GOOGLE LOOPED");

        if(radio[index].displayResult != "UNDEFINED"){
          ted.add(radio[index].testId.toString());
          print(ted.toString());
          var seen = Set<String>();
          List<String> uniquelist = ted.where((student) => seen.add(student.toString())).toList();
          print("uniqu ----> ${uniquelist}");

          for(var ff in uniquelist){
            ref.read(addResultNotifier.notifier).addResult({
              "test_id": int.parse(ff.toString()),
              "spend_time": 0,
              "status": radio[index].displayResult.toString(),
              "flg": 1
            });

          }


          print(ted.length);
          print("ted----------> ${ted.toString()}");



        }
        */

        /*switch (radio[index].result) {
              case 'PASS':
                boxColor = Colors.green;
                statusText = 'COMPLETED';
                progressVisibility = false;
                */
        /*canContinueTest = true;*/
        /*
                break;

              case 'TimeOut':
                boxColor = Colors.indigo;
                statusText = 'Time out';
                progressVisibility = false;
                radio[index].setRemarks("Failed");

                break;

              case 'FAIL':
                radio[index].setRemarks("Failed");
                Future.delayed(const Duration(milliseconds: 1), () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SecondTaskViewPage()));

                });
                Future.delayed(const Duration(milliseconds: 3), () {
                  popDialog(
                      title: 'Connection Failed',
                      msg: 'Connection error please restart your testJig',
                      context: context);
                });
                break;

              default:
                if (ref
                    .read(testStartedProvider.notifier)
                    .state) {
                  if (ref
                      .read(lastTestSentProvider.notifier)
                      .state ==
                      radio[index].testnumber) {
                    boxColor = Colors.yellow;
                    statusText = 'TESTING';
                    progressVisibility = true;
                  } else {
                    boxColor = Colors.orange;
                    statusText = 'IN QUEUE';
                    progressVisibility = true;
                  }
                } else {
                  boxColor = Colors.yellow;
                  statusText = 'Yet Stared';
                  progressVisibility = false;
                }
                break;
            }*/
        testType = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.85), blurRadius: 3)
              ],
              color: boxColor),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
                child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text(statusText,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black)),
                ),
                Visibility(
                  visible: progressVisibility,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        )),
                  ),
                )
              ],
            )),
          ),
        );
        break;
//************************************************SERIAL NO***********************************************************************

      case 'SERIALNO':
        // var boxColor = Colors.yellow;
        // var statusText = 'InQueue';
        // var progressVisibility = true;
        switch (radio[index].result) {
          case 'TimeOut':
            boxColor = Colors.indigo;
            statusText = 'Time out';
            progressVisibility = false;
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;
          case 'PASS':
            boxColor = Colors.green;
            statusText = 'COMPLETED';
            progressVisibility = false;
            /*canContinueTest = true;*/
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;
          case 'FAIL':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;
          case 'USERACK':
            boxColor = Colors.green;
            statusText = 'COMPLETED';
            progressVisibility = false;
            changeUi = true;
            testType =
            Row(
              children: [
                Radio(
                  value: "01",
                  groupValue: radio[index].radiotype,
                  onChanged: (value) {
                    setState(() {
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');



                      radio[index].radiotype = value.toString();
                      switch (value) {
                        case '01':
                          choice = value.toString();
                          isEast = true;
                          break;
                        case '02':
                          choice = value.toString();
                          isEast = true;
                          break;
                        default:
                          choice = null;
                      }
                      debugPrint(choice); //Debug the choice in console

                      Helper.classes = "DEMO";

                    });
                  },
                ),
                Text(radio[index].userEntry!.split('/')[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black)),
                SizedBox(
                  width: 5,
                ),
                Radio(
                  value: "02",
                  groupValue: radio[index].radiotype,
                  onChanged: (value) {
                    setState(() {
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');


                        String pck = "SST*" +
                            PacketControl.writePacket +
                            PacketControl.splitChar +
                            '003' +
                            PacketControl.splitChar +
                            ref
                                .read(
                                serialNoTestProvider.notifier)
                                .state +
                            "*ED";
                        ref
                            .read(
                            lastPacketSentProvider.notifier)
                            .state = '003';
                        ref.read(tcpProvider).sendPackets(
                            pck);
                        print("pck-----------------> $pck");



                      radio[index].radiotype = value.toString();
                      switch (value) {
                        case '01':
                          choice = value.toString();

                          isEast = true;
                          break;
                        case '02':
                          choice = value.toString();

                          isEast = true;
                          break;
                        default:
                          choice = null;
                      }
                      debugPrint(choice);
                      Helper.classes = "DEMO";
                    });
                  },
                ),
                Text(radio[index].userEntry!.split('/')[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black)),

                Text(
                 "  -${radio[index].userAckValue!.toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.black),
                )
              ],
            );

               /* Row(
              children: [
                SizedBox(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index1) {
                          print(
                              "nan----------------..>${radio[index].userentry!.split('/')[index1]}");
                          print(
                              "nanCYADES----------------..>${radio[index].testname}");
                          print(
                              "nantest----------------..>${radio[index].type}");
                          print("index----------------..>${index}");

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: radio[index]
                                      .userentry!
                                      .split('/')[index1],
                                  groupValue: radio[index].result,
                                  onChanged: (value) {
                                    print(
                                        "nancy----------------..>${radio[index].userentry}");
                                    radio[index].setResult(value);
                                    radio[index].setDisplayResult(
                                        value!.trim().toString() ==
                                                radio[index].passcrieteria
                                            ? 'PASS'
                                            : 'UPDATED');

                                    if (value == 'PASS') {
                                    } else {
                                      if (testList.length == i) {
                                        String pck = "SST*" +
                                            PacketControl.writePacket +
                                            PacketControl.splitChar +
                                            '003' +
                                            PacketControl.splitChar +
                                            ref
                                                .read(serialNoTestProvider
                                                    .notifier)
                                                .state +
                                            "*ED";
                                        ref
                                            .read(
                                                lastPacketSentProvider.notifier)
                                            .state = '003';
                                        ref.read(tcpProvider).sendPackets(pck);
                                      } else {}
                                    }

                                  },
                                ),
                                Text(
                                  radio[index].userentry!.split('/')[index1],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                    ' - ' + radio[index].userAckValue.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );*/
            break;
          default:
            if (ref.read(testStartedProvider.notifier).state) {
              if (ref.read(lastTestSentProvider.notifier).state ==
                  radio[index].testNumber) {
                boxColor = Colors.yellow;
                statusText = 'TESTING';
                progressVisibility = true;
              } else {
                boxColor = Colors.orange;
                statusText = 'IN QUEUE';
                progressVisibility = true;
              }
            } else {
              boxColor = Colors.yellow;
              statusText = 'Yet Stared';
              progressVisibility = false;
            }
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;
        }
        break;

//*******************************************************UNIT TEST***************************************************************
      case 'UNIT':
        var boxColor = Colors.yellow;
        var statusText = 'InQueue';
        var progressVisibility = true;

        switch (radio[index].result) {
          case 'TimeOut':
            boxColor = Colors.indigo;
            statusText = 'Time out';
            progressVisibility = false;
            radio[index].setRemarks("Failed");
            break;

          case 'PASS':
            boxColor = Colors.green;
            statusText = 'COMPLETED';
            progressVisibility = false;
            break;

          case 'FAIL':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            break;

          case 'USERACK':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            changeUi = true;
            testType = Row(
              children: [
                Radio(
                  value: "01",
                  groupValue: radio[index].radiotype,
                  onChanged: (value) {
                    setState(() {
                      radio[index].radiotype = value.toString();
                      switch (value) {
                        case '01':
                          choice = value.toString();
                          isEast = true;
                          break;
                        case '02':
                          choice = value.toString();
                          isEast = true;
                          break;
                        default:
                          choice = null;
                      }
                      debugPrint(choice); //Debug the choice in console

                      Helper.classes = "DEMO";

                    });
                  },
                ),
                Text(radio[index].userEntry!.split('/')[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black)),
                SizedBox(
                  width: 5,
                ),
                Radio(
                  value: "02",
                  groupValue: radio[index].radiotype,
                  onChanged: (value) {
                    setState(() {
                      radio[index].radiotype = value.toString();
                      switch (value) {
                        case '01':
                          choice = value.toString();
                          isEast = true;
                          break;
                        case '02':
                          choice = value.toString();
                          isEast = true;
                          break;
                        default:
                          choice = null;
                      }
                      debugPrint(choice);
                      Helper.classes = "DEMO";

                    });
                  },
                ),
                Text(radio[index].userEntry!.split('/')[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black)),
              ],
            );
            break;

          default:
            if (ref.read(testStartedProvider.notifier).state) {
              if (ref.read(lastTestSentProvider.notifier).state ==
                  radio[index].testNumber) {
                boxColor = Colors.yellow;
                statusText = 'TESTING';
                progressVisibility = true;
              } else {
                boxColor = Colors.orange;
                statusText = 'IN QUEUE';
                progressVisibility = true;

              }
            } else {
              boxColor = Colors.yellow;
              statusText = 'Yet Stared';
              progressVisibility = false;
            }
            break;
        }
        if (!changeUi) {
          testType = Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.85), blurRadius: 3)
                ],
                color: boxColor),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(statusText,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 13.0,
                            color: Colors.black)),
                  ),
                  Visibility(
                    visible: progressVisibility,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      child: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.blue,
                          )),
                    ),
                  )
                ],
              )),
            ),
          );
        }
        break;

//*****************************************************MAC*******************************************************************************************************
      case 'MAC':
        var boxColor = Colors.yellow;
        var statusText = 'InQueue';
        var progressVisibility = true;

        switch (radio[index].result) {
          case 'TimeOut':
            boxColor = Colors.indigo;
            statusText = 'Time out';
            progressVisibility = false;
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;

          case 'PASS':
            boxColor = Colors.green;
            statusText = 'COMPLETED';
            progressVisibility = false;
            /*canContinueTest = true;*/


            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;

          case 'USERID':
            boxColor = Colors.green;
            statusText = 'NO MAC ID';
            progressVisibility = false;
            testType = Row(
              children: [
                SizedBox(
                  width: 150.0,
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    controller: mac,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      // errorText: validation ? 'can\t be empty' : null ,
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: "Enter Mac",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (values) {
                      setState(() {});
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (mac.text.length >= 18) {
                      String pck = "SST*" +
                          PacketControl.writePacket +
                          PacketControl.splitChar +
                          '005' +
                          PacketControl.splitChar +
                          mac.text +
                          "*ED";
                      ref.read(lastPacketSentProvider.notifier).state = pck;
                      ref.read(tcpProvider).sendPackets(pck);
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('MAC ID Length must 15 digits'),
                        backgroundColor: (Colors.black),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.85),
                                blurRadius: 3)
                          ],
                          color: boxColor),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                            child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: Text('SAVE ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0,
                                      color: Colors.black)),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                )
              ],
            );

            break;

          case 'FAIL':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;

          default:
            if (ref.read(testStartedProvider.notifier).state) {
              if (ref.read(lastTestSentProvider.notifier).state ==
                  radio[index].testNumber) {
                boxColor = Colors.yellow;
                statusText = 'TESTING';
                progressVisibility = true;
                testType = Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.85),
                            blurRadius: 3)
                      ],
                      color: boxColor),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(statusText,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                        Visibility(
                          visible: progressVisibility,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4.0, right: 4.0),
                            child: SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                )),
                          ),
                        )
                      ],
                    )),
                  ),
                );
              } else {
                boxColor = Colors.orange;
                statusText = 'IN QUEUE';
                progressVisibility = true;
                testType = Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.85),
                            blurRadius: 3)
                      ],
                      color: boxColor),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(statusText,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black)),
                        ),
                        Visibility(
                          visible: progressVisibility,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4.0, right: 4.0),
                            child: SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                )),
                          ),
                        )
                      ],
                    )),
                  ),
                );
              }
            } else {
              boxColor = Colors.yellow;
              statusText = 'Yet Stared';
              progressVisibility = false;
              testType = Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.85), blurRadius: 3)
                    ],
                    color: boxColor),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Text(statusText,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0,
                                color: Colors.black)),
                      ),
                      Visibility(
                        visible: progressVisibility,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 4.0),
                          child: SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blue,
                              )),
                        ),
                      )
                    ],
                  )),
                ),
              );
            }
            break;
        }
        break;

//**************************************************UNITCAL***************************************************************************
      case 'UNITCAL':
        var boxColor = Colors.yellow;
        var statusText = 'InQueue';
        var progressVisibility = true;

        switch (radio[index].result) {
          case 'TimeOut':
            radio[index].setRemarks("Failed");
            boxColor = Colors.indigo;
            statusText = 'Time out';
            progressVisibility = false;
            break;
          case 'PASS':
            boxColor = Colors.green;
            statusText = 'COMPLETED';
            progressVisibility = false;
            break;
          case 'FAIL':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            break;
          default:
            if (ref.read(testStartedProvider.notifier).state) {
              if (ref.read(lastTestSentProvider.notifier).state ==
                  radio[index].testNumber) {
                boxColor = Colors.yellow;
                statusText = 'TESTING';
                progressVisibility = true;
              } else {
                boxColor = Colors.orange;
                statusText = 'IN QUEUE';
                progressVisibility = true;
              }
            } else {
              boxColor = Colors.yellow;
              statusText = 'Yet Stared';
              progressVisibility = false;
            }
            break;
        }
        testType = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.85), blurRadius: 3)
              ],
              color: boxColor),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
                child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text(statusText,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black)),
                ),
                Visibility(
                  visible: progressVisibility,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        )),
                  ),
                )
              ],
            )),
          ),
        );
        break;

//*****************************************************UNITACK*******************************************************************************************************

      case 'UNITACK':
        var boxColor = Colors.yellow;
        var statusText = 'InQueue';
        var progressVisibility = true;

        switch (radio[index].result) {
          case 'TimeOut':
            boxColor = Colors.indigo;
            statusText = 'Time out';
            progressVisibility = false;
            radio[index].setRemarks("Failed");

            break;

          case 'FAIL':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;

          case 'PASS':
            boxColor = Colors.green;
            statusText = 'COMPLETED';
            progressVisibility = false;
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;
          case 'USERACK':
            boxColor = Colors.red;
            statusText = 'COMPLETED';
            progressVisibility = false;
            changeUi = true;
            testType = Row(
              children: [
                Radio(
                  value: "01",
                  groupValue: radio[index].radiotype,
                  onChanged: (value) {
                    setState(() {
                      if(radio[index].userEntry!.split("/")[0].toString()   == "PASS")
                      {
                        userEntry = "PASS";

                        if(userEntry == radio[index].passCrieteria)
                        {
                          radio[index].setResult("PASS");
                          radio[index].setDisplayResult('PASS');
                        }  else {
                          radio[index].setResult("FAIL");
                          radio[index].setDisplayResult('FAIL');
                        }

                      }
                      radio[index].radiotype = value.toString();
                      switch (value) {
                        case '01':
                          choice = value.toString();
                          isEast = true;
                          break;
                        case '02':
                          choice = value.toString();
                          isEast = true;
                          break;
                        default:
                          choice = null;
                      }
                      debugPrint(choice); //Debug the choice in console

                      Helper.classes = "DEMO";
                    });
                  },
                ),
                Text(radio[index].userEntry!.split('/')[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black)),
                SizedBox(
                  width: 5,
                ),
                Radio(
                  value: "02",
                  groupValue: radio[index].radiotype,
                  onChanged: (value) {
                    setState(() {
                      if(radio[index].userEntry!.split("/")[0].toString()   == "PASS")
                      {
                        userEntry = "FAIL";

                        if(userEntry == radio[index].passCrieteria)
                        {
                          radio[index].setResult("PASS");
                          radio[index].setDisplayResult('PASS');
                        }  else {
                          radio[index].setResult("FAIL");
                          radio[index].setDisplayResult('FAIL');
                        }

                      }
                      radio[index].radiotype = value.toString();
                      switch (value) {
                        case '01':
                          choice = value.toString();
                          isEast = true;
                          break;
                        case '02':
                          choice = value.toString();
                          isEast = true;
                          break;
                        default:
                          choice = null;
                      }
                      debugPrint(choice);
                      Helper.classes = "DEMO";
                    });
                  },
                ),
                Text(radio[index].userEntry!.split('/')[1],
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black)),
              ],
            );
            break;

          default:
            if (ref.read(testStartedProvider.notifier).state) {
              if (ref.read(lastTestSentProvider.notifier).state ==
                  radio[index].testNumber) {
                boxColor = Colors.yellow;
                statusText = 'TESTING';
                progressVisibility = true;
              } else {
                boxColor = Colors.orange;
                statusText = 'IN QUEUE';
                progressVisibility = true;
              }
            } else {
              boxColor = Colors.yellow;
              statusText = 'Yet Stared';
              progressVisibility = false;
            }
            testType = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.85), blurRadius: 3)
                  ],
                  color: boxColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black)),
                    ),
                    Visibility(
                      visible: progressVisibility,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            )),
                      ),
                    )
                  ],
                )),
              ),
            );
            break;
        }
        break;

//*****************************************************UNITREMARK*******************************************************************************************************
      case 'UNITREMARK':
        var boxColor = Colors.yellow;
        var statusText = 'InQueue';
        var progressVisibility = true;
        if (radio[index].isOnline == "0" ? false : true) {
          switch (radio[index].result) {
            case 'TimeOut':
              boxColor = Colors.indigo;
              statusText = 'Time out';
              progressVisibility = false;
              break;

            case 'PASS':
              boxColor = Colors.green;
              statusText = 'COMPLETED';
              progressVisibility = false;
              /*canContinueTest = true;*/
              break;

            case 'FAIL':
              boxColor = Colors.red;
              statusText = 'COMPLETED';
              progressVisibility = false;
              break;

            default:
              if (ref
                  .read(testStartedProvider.notifier)
                  .state) {
                if (ref
                    .read(lastTestSentProvider.notifier)
                    .state ==
                    radio[index].testNumber) {
                  boxColor = Colors.yellow;
                  statusText = 'TESTING';
                  progressVisibility = true;
                } else {
                  boxColor = Colors.orange;
                  statusText = 'IN QUEUE';
                  progressVisibility = true;
                }
              } else {
                boxColor = Colors.yellow;
                statusText = 'Yet Stared';
                progressVisibility = false;
              }
              break;
          }
          testType = Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.85), blurRadius: 3)
                ],
                color: boxColor),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Text(statusText,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0,
                                color: Colors.black)),
                      ),
                      Visibility(
                        visible: progressVisibility,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 4.0),
                          child: SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blue,
                              )),
                        ),
                      )
                    ],
                  )),
            ),
          );
        } else {
          boxColor = Colors.red;
          statusText = 'COMPLETED';
          progressVisibility = false;
          changeUi = true;
          testType = Row(
            children: [
              Radio(
                value: "01",
                groupValue: radio[index].radiotype,
                onChanged: (value) {
                  setState(() {
                    radio[index].setResult("PASS");
                    radio[index].setDisplayResult('PASS');
                    radio[index].radiotype = value.toString();
                    switch (value) {
                      case '01':
                        choice = value.toString();
                        isEast = true;
                        break;
                      case '02':
                        choice = value.toString();
                        isEast = true;
                        break;
                      default:
                        choice = null;
                    }
                    debugPrint(choice); //Debug the choice in console

                    Helper.classes = "DEMO";
                  });
                },
              ),
              Text(radio[index].userEntry!.split('/')[0],
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black)),
              SizedBox(
                width: 5,
              ),
              Radio(
                value: "02",
                groupValue: radio[index].radiotype,
                onChanged: (value) {
                  setState(() {
                    radio[index].setResult("FAIL");
                    radio[index].setDisplayResult('FAIL');
                    radio[index].radiotype = value.toString();
                    switch (value) {
                      case '01':
                        choice = value.toString();
                        isEast = true;
                        break;
                      case '02':
                        choice = value.toString();
                        isEast = true;
                        break;
                      default:
                        choice = null;
                    }
                    debugPrint(choice);
                    Helper.classes = "DEMO";
                  });
                },
              ),
              Text(radio[index].userEntry!.split('/')[1],
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black)),
            ],
          );
        }
        break;




    }
    return Column(
      children: [
        Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(
                          child: Text(radio[index].testNumber.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(
                          child: Text(radio[index].testName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //height: 20.0,
                      //width: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [testType],
                      ),
                    ),
                  ),

                  Expanded(
                    child: (){
                      return  Consumer(
                        builder: (context, ref, child) {


                             indices = index;

                          ref.watch(counterModelProvider);
                          return Container(
                              child: (radio[index].displayResult.toString() == "PASS" ||
                                  radio[index].displayResult.toString() == "UNDEFINED" ||
                                  radio[index].displayResult.toString() == "") ?
                              Text("")
                                  : TextField(
                                controller: generalController[index],
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  hintText: "Remarks",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.black),
                                  ),
                                ),
                                onChanged: (values) {
                                  setState(() {
                                    radio[index].setRemarks(values);
                                  });
                                  print("value is ${values}");
                                },

                              )
                          );
                        }
                      );
                    }()

                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child:

                          () {
                      /*  if (radio[index].type == "FLAG") {
                          if (radio[index].radiotype == "01") {
                            if (radio[index].userentry!.split('/')[0] == "YES ") {
                              radio[index].radiotype = "YES";
                            } else {
                              radio[index].radiotype = "SHORT";
                            }
                            if (radio[index].radiotype !=
                                radio[index].passcrieteria) {
                              radio[index].radiotype = "01";
                              return Text(
                                  radio[index].userentry!.split('/')[0] == "OK"
                                      ? "PASS"
                                      : "FAIL",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0,
                                      color: Colors.black));
                            }
                          } else if (radio[index].radiotype == "02") {
                            if (radio[index].userentry!.split('/')[1] == "NO") {
                              radio[index].radiotype = "NO";
                            } else {
                              radio[index].radiotype = "NO SHORT";
                            }
                            if (radio[index].radiotype ==
                                    radio[index].passcrieteria ||
                                radio[index].radiotype !=
                                    radio[index].passcrieteria) {
                              radio[index].radiotype = "02";
                              print(
                                  'print userentry-----> ${radio[index].userentry!.split('/')[1].toString()}');
                              return Text(
                                  radio[index].userentry!.split('/')[0] == "OK"
                                      ? "FAIL"
                                      : "PASS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0,
                                      color: Colors.black));
                            } else {
                              return Text("FAIL");
                            }
                          } else {
                            return Text("");
                          }
                        }
                        if (radio[index].type == "Value") {
                          if (radio[index].displayResult.toString() == "FAIL") {
                            return Text("FAIL",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black));
                          } else if (radio[index].displayResult.toString() ==
                              "PASS") {
                            return Text("PASS",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black));
                          } else if (radio[index].displayResult.toString() ==
                              "UNDEFINED") {
                            return Text(" ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black));
                          } else {
                            return Text("",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.0,
                                    color: Colors.black));
                          }
                        }*/


/*
                            if(radio[index].isOnline == '1'){
                                if(radio[index].displayResult.toString() != "UNDEFINED" ){
                                  Results tst = Results(
                                    resultId: 0,
                                    testId:  radio[index].testId,
                                    spendTime:  0,
                                    status:  radio[index].displayResult,
                                    flg:  1,
                                  );
                                  if(reslt.isEmpty){
                                    reslt.add(tst);
                                  }
                                  else{
                                    for(int i=0; i<reslt.length; i++){
                                      if(reslt[i].testId !=  radio[index].testId){
                                        reslt.add(tst);
                                      }
                                    }
                                  }
                                  print(reslt);
                                }

                            }*/







                           /* ref.read(addResultNotifier.notifier).addResult( {
                              "test_id": radio[index].testId.toString(),
                              "spend_time": displayTime,
                              "status": radio[index].displayResult.toString(),
                              "flg": 1
                            });*/
                            return Text(
                                radio[index].displayResult.toString() == "UNDEFINED"
                                    ? ""
                                    : radio[index].displayResult.toString(),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black));



                      }()),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 15),
      curve: Curves.fastOutSlowIn,
    );
  }

  splitExcelOnlineTestData(Map<int, OnlineTestModel> testMap) {
    testList.clear();
    i = 0;
    testMap.forEach((key, value) {
      testList.add(value);
      print(value.packet);
    });
    if (testList.isNotEmpty) {
      Future.delayed(const Duration(seconds: 6), () {
        ref.read(tcpSendDataNotifier.notifier).sendPacket(
            testList[i].packet.toString(), testList[i].taskNo.toString());

        print("tcp notifer --------> ${ref.read(tcpSendDataNotifier.notifier).state}");
      });
    }
  }

  saveJigAddress(String ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Jig', ip);
  }

  showfailedTest() {
    return showDialog(
        context: context,
        builder: (c) => AlertDialog(
              title: Text("Test incomplete"),
              content: Text(
                  "seems some tests are not completed \n please check it before submit"),
              actions: [
                TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  }

  showRemarks() {
    return showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: Text("Remark incomplete"),
          content: Text(
              "seems some remarks are not mentioned \n please check it before submit"),
          actions: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ));
  }
}

class RadioItem {
  String? testTitle;
  bool? isSelected = false;

  RadioItem({this.testTitle, this.isSelected});

  selectradio(bool val) {
    isSelected = val;
  }
}
