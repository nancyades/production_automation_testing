import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:production_automation_testing/Helper/application_class.dart';
import 'package:production_automation_testing/Helper/packet_control.dart';
import 'package:production_automation_testing/Model/testmodel.dart';
import 'package:production_automation_testing/Provider/tcpprovider/tcp_provider_receive_data.dart';
import 'package:production_automation_testing/Provider/testProvider.dart';
import 'package:production_automation_testing/noofpages/Test/firsrtaskviewpage.dart';
import 'package:production_automation_testing/noofpages/Test/secondtaskviewpage.dart';
import 'package:production_automation_testing/noofpages/TestCompleted/test_completed.dart';
import 'package:production_automation_testing/noofpages/dashboardscreenpage.dart';
import 'package:production_automation_testing/noofpages/Task/taskpage.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/workorderscreenpage.dart';
import 'package:production_automation_testing/noofpages/Product/product.dart';
import 'package:production_automation_testing/noofpages/setting/settingpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Helper/AppClass.dart';
import '../../Helper/helper.dart';
import '../../Model/readexcel/readecel.dart';
import '../../NavigationBar/src/company_name.dart';
import '../../NavigationBar/src/navbar.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/generalProvider.dart';
import '../../Provider/tcpprovider/tcp_provider_send_data.dart';
import '../../service/tcpclient.dart';
import '../Users/user.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreenPage extends ConsumerStatefulWidget {
  dynamic testtype;

  TestScreenPage({Key? key, this.testtype}) : super(key: key);

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

  TextEditingController mac = TextEditingController();

  String? choice;

  bool isEast = false;

  bool isCommunicate = false;

  List<List<FirstTest>> test = [];

  int k = 0;
  bool isOnlineTestStarted = false;
  Map<int, OnlineTestModel> onlineTestIds = {};
  List<OnlineTestModel> testList = [];
  int i = 0;

  List<FirstTest>? testlist = [];

  bool value = true;

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
  }

  String? receivedData;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
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
    List<List<FirstTest>> ind2 = [];
    List<List<FirstTest>> ind3 = [];
    List<FirstTest> ss = <FirstTest>[];
    int j = 0;

    for (int i = 0; i < alltest.length; i++) {
      if (widget.testtype[0].length > j) {
        if (alltest[i].testtype != "" && alltest[i].testtype != "Title"
            //&& widget.testtype[0][j].toString() == alltest![i].testtype.toString()
            ) {
          ind.add(i);
          //j++;

          if (ss.length != 0) {
            ind2.add(ss);
            ss = <FirstTest>[];
          }
          ss.add(alltest[i]);
        } else if (alltest[i].testtype != "Title") {
          ss.add(alltest[i]);
        }
      }
    }

    ind2.add(ss);

    for (int i = 0; i < ind2.length; i++) {
      List<FirstTest> list1 = <FirstTest>[];
      list1 = ind2[i].toList();

      if (widget.testtype[0].length > j) {
        if (widget.testtype[0][j].toString() == list1[0].testtype.toString()) {
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
                    padding: const EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                             // ref.refresh(gettesttypeNotifier);
                              Navigator.of(context).pop();
                              Helper.classes = "TEST";
                            },
                            icon: Icon(Icons.arrow_back_outlined)),
                        Text(
                          "Product Test",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
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
                                            Row(
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
                                                    final displayTime =
                                                        StopWatchTimer
                                                            .getDisplayTime(
                                                                value,
                                                                hours: true,
                                                                milliSecond:
                                                                    false);
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
                                          ind3[k][0].testtype.toString(),
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

                                          if (ind3[k][0].isonline == "1" && isPressed == true) {
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
                                                              PacketControl.startPacket + ind3[k][i].packettype!.toString() +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetid!.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testnumber);
                                                          break;
                                                        case 'SERIALNO':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + ind3[k][i].packettype.toString() +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetid!.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testnumber);
                                                          break;
                                                        case 'MAC':
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      25), () {
                                                            onlineTestIds[i] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].packettype.toString() +
                                                                    PacketControl.splitChar +
                                                                    ApplicationClass().formDigits(3, ind3[k][i].packetid!.toString())! +
                                                                    PacketControl.endPacket,
                                                                ind3[k][i].testnumber);
                                                          });
                                                          break;
                                                        case 'UNIT':
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      20), () {
                                                            onlineTestIds[i] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].packettype.toString() +
                                                                    PacketControl.splitChar +
                                                                    ApplicationClass().formDigits(3, ind3[k][i].packetid!.toString())! +
                                                                    PacketControl.endPacket,
                                                                ind3[k][i].testnumber);
                                                          });
                                                          break;
                                                        case 'UNITCAL':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + PacketControl.readPacket +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetid.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testnumber);
                                                          break;
                                                        case 'UNITACK':
                                                          onlineTestIds[i] = OnlineTestModel(
                                                              PacketControl.startPacket + ind3[k][i].packettype.toString() +
                                                                  PacketControl.splitChar +
                                                                  ApplicationClass().formDigits(3, ind3[k][i].packetid.toString())! +
                                                                  PacketControl.endPacket,
                                                              ind3[k][i].testnumber);
                                                          break;
                                                          case 'UNITREMARK':
                                                          if (ind3[k][i].isonline == "0"? false : true) {
                                                                onlineTestIds[index] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].packettype + PacketControl.splitChar +
                                                                ApplicationClass().formDigits(3, ind3[k][i].packetid)! + PacketControl.endPacket,
                                                                ind3[k][i].testnumber!);
                                                                }
                                                                break;
                                                          case 'USERACK':
                                                            onlineTestIds[index] = OnlineTestModel(
                                                                PacketControl.startPacket + ind3[k][i].packettype + PacketControl.splitChar +
                                                                    ApplicationClass().formDigits(3, ind3[k][i].packetid!)! + PacketControl.endPacket,
                                                                ind3[k][i].testnumber!
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

                                        if (test.isNotEmpty) {
                                          print("print test k-----------------> ${test}");
                                          for(var ele in test[0]){
                                            if(ele.isonline == "0"){
                                              if(ele.result == null && ele.displayResult == null ){
                                                return showfailedTest();
                                              }
                                              else if(ele.result == "" && ele.displayResult == ""){
                                                return showfailedTest();
                                              }
                                              else if(ele.remarks == "" && ele.displayResult == "FAIL"){
                                                return showRemarks();
                                              }
                                            }else{
                                              if(ele.remarks == "" && ele.displayResult == "FAIL"){
                                                return showRemarks();
                                              }

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


                                       /*   if(ind3[k][0].isonline == "1" ){
                                            if (ref.read(serialNoTestProvider.notifier).state.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Please Enter the Test Serial No'),
                                                backgroundColor:
                                                (Colors.black),
                                              );
                                              ScaffoldMessenger.of(
                                                  context)
                                                  .showSnackBar(snackBar);

                                            }

                                            else {
                                                Future.delayed(const Duration(microseconds: 1000), () {
                                                  splitExcelOnlineTestData(
                                                      onlineTestIds);
                                                });
                                                ref.read(testStartedProvider.notifier).state = true;
                                            }
                                           *//* Future.delayed(
                                                const Duration(
                                                    milliseconds: 1000), () {
                                              splitExcelOnlineTestData(
                                                  onlineTestIds);
                                            });*//*

                                          }

*/



                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TestCompleted()));
                                          Helper.classes = "TEST";
                                        }

                                        if (test.isEmpty) {

                                          test.add(ind3[k]);

                                        }
                                        isEast = false;
                                      });
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

  getAllTest(List<FirstTest> radio, int index) {

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
                  if(radio[index].testtype == 'FLAG'){
                    if(radio[index].userentry == "OK/NOK" ){
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');
                    }else{
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }
                  }else {
                    radio[index].setResult("FAIL");
                    radio[index].setDisplayResult('FAIL');



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
            Text(radio[index].userentry!.split('/')[0],
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
                  if(radio[index].testtype == 'FLAG'){
                    if(radio[index].userentry == "OK/NOK"){
                      radio[index].setResult("FAIL");
                      radio[index].setDisplayResult('FAIL');
                    }else{
                      radio[index].setResult("PASS");
                      radio[index].setDisplayResult('PASS');

                    }
                  }else {
                    radio[index].setResult("PASS");
                    radio[index].setDisplayResult('PASS');
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
            Text(radio[index].userentry!.split('/')[1],
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
                    print("print val------> ${radio[index].passcrieteria}");

                    setState(() {
                      if (val.isEmpty) {
                        radio[index].setDisplayResult('UNDEFINED');
                      }
                      if (radio[index].passcrieteria!.contains('-')) {
                        List<String> arr =
                            radio[index].passcrieteria!.split('-'); // 115 < 125
                        num value, leftExpValue, rightExpValue;
                        if (radio[index].passcrieteria!.contains('.')) {
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
                      } else if (radio[index].passcrieteria!.contains('-')) {
                        List<String> arr =
                            radio[index].passcrieteria!.split('-'); // 115 > 125

                        num value, leftExpValue, rightExpValue;
                        if (radio[index].passcrieteria!.contains('.')) {
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
                MaterialPageRoute(builder: (context) => SecondTaskViewPage()));
          });
          Future.delayed(const Duration(milliseconds: 3), () {
            popDialog(
                title: 'Connection Failed',
                msg: 'Connection error please restart your testJig',
                context: context);
          });
        } else {
          if (ref.read(testStartedProvider.notifier).state) {
            if (ref.read(lastTestSentProvider.notifier).state ==
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
        }
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
                Text(radio[index].userentry!.split('/')[0],
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
                Text(radio[index].userentry!.split('/')[1],
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
                Text(radio[index].userentry!.split('/')[0],
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
                Text(radio[index].userentry!.split('/')[1],
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
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      // errorText: validation ? 'can\t be empty' : null ,
                      hintStyle: TextStyle(color: Colors.white24),
                      hintText: "Enter Mac",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
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
                  radio[index].testnumber) {
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
                Text(radio[index].userentry!.split('/')[0],
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
                Text(radio[index].userentry!.split('/')[1],
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
        if (radio[index].isonline == "0" ? false : true) {
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
              Text(radio[index].userentry!.split('/')[0],
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
              Text(radio[index].userentry!.split('/')[1],
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black)),
            ],
          );
        }
        break;




    }
    return Card(
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
                      child: Text(radio[index].testnumber.toString(),
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
                      child: Text(radio[index].testname.toString(),
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
                  return  Container(
                      child: (radio[index].displayResult.toString() == "PASS" ||
                          radio[index].displayResult.toString() == "null" ||
                          radio[index].displayResult.toString() == "") ?
                      Text("")
                          : TextField(
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

                        return Text(
                            radio[index].displayResult.toString() == "null"
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
        ));
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
