import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/noofpages/Users/addusers.dart';
import '../../DashBoard/src/ProjectCardOverview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../DashBoard/src/cardcount/usercount.dart';
import '../../Database/Curd_operation/HiveModel/usermanagement.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/boxes.dart';
import '../../Database/Curd_operation/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Model/APIModel/usermodel.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../Provider/post_provider/user_provider.dart';

class UserPage extends ConsumerStatefulWidget {
  UserPage({Key, key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

int? key;
UserManagementmodel? data;
List<UserManagementmodel>? datamodels;

Users user = Users();

class _UserPageState extends ConsumerState<UserPage> {
  bool _isShow = false;
  var selectRole = "Super Admin";
  List<String> roles = [
    'Super Admin',
    'Design Admin',
    'Test Admin',
    'Design User',
    'Test User'
  ];

  bool all = true;
  bool active = false;
  bool inactive = false;
  int looping = 0;

  bool useres = true;

  bool search = true;

  List<dynamic>? allusers;
  List<UserManagementmodel> use = [];

  @override
  void initState() {
    Helper.classes = 'userlist';
    //ref.refresh(getUserNotifier);
  }

  Map<String, double> dataMap = {
    'super Admiin': 3,
    'design Admin': 3,
    'test Admin': 2,
    'design user': 6,
    'test user': 4
  };
  List<Color> colorList = [
    Color(0xfffccaca),
    Color(0xfffcf2ca),
    Color(0xffcafcd0),
    Color(0xffcae2fc),
    Color(0xfffccaf9),
  ];

  Widget UserPiechart() {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 20,
      centerText: "Users",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        // legendShape: _BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }

  var designUser;
  List<Users> glossarListOnSearch = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ref.watch(getUserNotifier).when(data: (datum) {
      var activevalue = datum.where((element) => element.flg == 1).toList();

      var inactivevalue = datum.where((element) => element.flg == 0).toList();
      if (Helper.sharedRoleId == "Design Admin") {
        designUser =
            datum.where((element) => element.role == "Design User").toList();
        var activedesignuser =
            designUser.where((element) => element.flg == 1).toList();
        var inactivedesignuser =
            designUser.where((element) => element.flg == 0).toList();

        activevalue = activedesignuser;
        inactivevalue = inactivedesignuser;
        datum = designUser;
      } else if (Helper.sharedRoleId == "Test Admin") {
        var testUser =
            datum.where((element) => element.role == "Test User").toList();
        var activetestuser =
            testUser.where((element) => element.flg == 1).toList();
        var inactivetestuser =
            testUser.where((element) => element.flg == 0).toList();

        activevalue = activetestuser;
        inactivevalue = inactivetestuser;
        datum = testUser;
      }

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
                          "User Management",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(15),
                          onPressed: () {
                            setState(() {
                              user.name = "";
                              user.empId = "";
                              user.emailid = "";
                              user.password = "";
                              user.phoneno = "";
                              user.flg = 0;

                              /* AddUsers(user: user);
                                    Allvalues.name =
                                    " ";
                                    Allvalues.emp_id =
                                    " ";
                                    Allvalues.email =
                                    "";
                                    Allvalues.password =
                                    "";
                                    Allvalues.phoneno =
                                    " ";
                                    Allvalues.isActive =
                                    false;
                                    Allvalues.key = 0;*/
                              _isShow = !_isShow;
                              useres = !useres;
                              search = !search;
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
                  Consumer(builder: (context, ref, child) {
                    return ref.watch(getUserCountNotifier).when(data: (count) {
                      if (count.isNotEmpty) {
                        dataMap["super Admiin"] =
                            double.parse(count[0].superAdmin.toString());
                        dataMap["design Admin"] =
                            double.parse(count[0].designAdmin.toString());
                        dataMap["test Admin"] =
                            double.parse(count[0].testAdmin.toString());
                        dataMap["design user"] =
                            double.parse(count[0].designUser.toString());
                        dataMap["test user"] =
                            double.parse(count[0].testUser.toString());
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 5.0),
                        height: 218.0,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(children: [
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
                                                                  "${count[0].userCount}%",
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
                                                                  "${count[0].superAdmin}%",
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
                                                                  "Super Admin",
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
                                    ]),
                                    Column(children: [
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
                                                                  "${count[0].designAdmin}%",
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
                                                              Text("Dsign Admin",
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
                                                        color: Colors.amber,
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
                                                                  "${count[0].testAdmin}%",
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
                                                              Text("Test Admin",
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
                                                            Icons.task,
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
                                                        color: Colors.blue,
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
                                    ]),
                                    Column(children: [
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
                                                                  "${count[0].designUser}%",
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
                                                              Text("Dsign User",
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
                                                                  "${count[0].testUser}%",
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
                                                              Text("Test User",
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
                                                            Icons.task,
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
                                                        color: Colors.purple,
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
                                    ])
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: useres,
                              child: Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    UserPiechart(),
                                  ],
                                ),
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
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 32.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  highlightColor: Colors.amberAccent,
                                  onPressed: () {
                                    ref.refresh(getUserNotifier);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                  )),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffFFAAA1E),
                                            ),
                                            child: Center(
                                              child: Text(
                                                datum.length.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("All".toUpperCase(),
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
                                      all = true;
                                      active = false;
                                      inactive = false;
                                    });
                                  }),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffFFAAA1E),
                                            ),
                                            child: Center(
                                              child: Text(
                                                activevalue.length.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("Active".toUpperCase(),
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
                                      all = false;
                                      active = true;
                                      inactive = false;
                                    });
                                  }),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffFFAAA1E),
                                            ),
                                            child: Center(
                                              child: Text(
                                                inactivevalue.length.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("in-active".toUpperCase(),
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
                                      all = false;
                                      active = false;
                                      inactive = true;
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              Visibility(
                                visible: search,
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    //MediaQuery.of(context).size.width * 0.25,
                                    height: 30,
                                    child: TextField(
                                        controller: _textEditingController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.search),
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
                                        onChanged: (value) {
                                          setState(() {
                                            glossarListOnSearch = datum
                                                .where((element) => element
                                                    .name!
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase()))
                                                .toList();
                                          });
                                        })),
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
                  SizedBox(
                    height: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: Color(0xff8fcceb),
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
                                        child: Text("Emp Id",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text("Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text("Email",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text("phone no",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text("Role",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text("Rating",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                icon: _isShow == true
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(''))
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Icon(Icons.keyboard_arrow_down)),
                                items: roles.map<DropdownMenuItem<String>>(
                                    (String setlist) {
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
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 500,
                            child: ValueListenableBuilder<
                                    Box<UserManagementmodel>>(
                                valueListenable:
                                    Usersvalue.getUsers().listenable(),
                                builder: (context,
                                    Box<UserManagementmodel> items, _) {
                                  List<int> keys;
                                  keys = items.keys.cast<int>().toList();
                                  datamodels = items.values
                                      .toList()
                                      .cast<UserManagementmodel>();

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 490,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            color: Color(0xffcbdff2),
                                            elevation: 15,
                                            child: _textEditingController
                                                        .text.isNotEmpty &&
                                                    glossarListOnSearch.isEmpty
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
                                                    itemCount: //allusers!.length,
                                                        () {
                                                    if (all == true) {
                                                      //return keys.length;
                                                      return _textEditingController
                                                              .text.isNotEmpty
                                                          ? glossarListOnSearch
                                                              .length
                                                          : datum.length;
                                                    } else if (active == true) {
                                                      // active = false;
                                                      return _textEditingController
                                                              .text.isNotEmpty
                                                          ? glossarListOnSearch
                                                              .length
                                                          : activevalue.length;
                                                    } else if (inactive ==
                                                        true) {
                                                      // inactive = false;
                                                      return _textEditingController
                                                              .text.isNotEmpty
                                                          ? glossarListOnSearch
                                                              .length
                                                          : inactivevalue
                                                              .length;
                                                    } else {
                                                      return 0;
                                                    }
                                                  }(), itemBuilder:
                                                        (BuildContext ctxt,
                                                            int index) {
                                                    return () {
                                                      if (all == true) {
                                                        return getListItems(
                                                            datum, index);
                                                      } else if (active ==
                                                          true) {
                                                        return getActiveItems(
                                                            datum, index);
                                                      } else if (inactive ==
                                                          true) {
                                                        return getInActiveItems(
                                                            datum, index);
                                                      } else {
                                                        return getListItems(
                                                            datum, index);
                                                      }
                                                    }();
                                                  }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
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
          Visibility(
            visible: _isShow,
            child: Expanded(
                flex: 5,
                child: AddUsers(
                  user: user,
                )),
          ),
        ],
      );
    }, error: (e, s) {
      return Text(e.toString());
    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });
  }

  getListItems(List<Users> items, int index) {
    // List<int> keys;
    // keys = items.keys.cast<int>().toList();
    // final datamodels = items.values.toList().cast<UserManagementmodel>();
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
                                  items[index].flg == 1
                                      //datamodels[index].flg == true
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  _textEditingController.text.isNotEmpty
                                      ? glossarListOnSearch[index].empId!
                                      : items[index].empId.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  _textEditingController.text.isNotEmpty
                                      ? glossarListOnSearch[index].name!
                                      : items[index].name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  _textEditingController.text.isNotEmpty
                                      ? glossarListOnSearch[index].emailid!
                                      : items[index].emailid.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  _textEditingController.text.isNotEmpty
                                      ? glossarListOnSearch[index].phoneno!
                                      : items[index].phoneno.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  _textEditingController.text.isNotEmpty
                                      ? glossarListOnSearch[index].role!
                                      : items[index].role.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
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
                              // setState(() {
                              /*           if(_isShow == false){
                                  _isShow = true;

                                }
                                Usermodel user = Usermodel(
                                  name:  datamodels[index].name,
                                  emp_id: datamodels[index].emp_id,
                                  email: datamodels[index].email,
                                  phoneno: datamodels[index].phoneno,
                                  isActive: datamodels[index].isActive,
                                );
                                AddUsers(
                                  index: index,
                                  usermodel: user ,
                                );

                              });*/

                              setState(() {
                                if (_textEditingController.text.isNotEmpty) {
                                  user.userId =
                                      glossarListOnSearch[index].userId;
                                  user.name = glossarListOnSearch[index]
                                      .name
                                      .toString();
                                  user.empId = glossarListOnSearch[index]
                                      .empId
                                      .toString();
                                  user.emailid = glossarListOnSearch[index]
                                      .emailid
                                      .toString();
                                  user.password = glossarListOnSearch[index]
                                      .password
                                      .toString();
                                  user.phoneno = glossarListOnSearch[index]
                                      .phoneno
                                      .toString();
                                  user.flg = glossarListOnSearch[index].flg == 0
                                      ? 0
                                      : 1;
                                  user.role = glossarListOnSearch[index]
                                      .role
                                      .toString();
                                } else {
                                  user.userId = items[index].userId;
                                  user.name = items[index].name.toString();
                                  user.empId = items[index].empId.toString();
                                  user.emailid = items[index].emailid.toString();
                                  user.password = items[index].password.toString();
                                  user.phoneno = items[index].phoneno.toString();
                                  user.flg = items[index].flg == 0 ? 0 : 1;
                                  user.role = items[index].role.toString();
                                }

                                AddUsers(user: user);

                                /* Allvalues.user_id = items[index].userId;
                                Allvalues.name = items[index].name.toString();
                                Allvalues.emp_id = items[index].empId.toString();
                                Allvalues.email = items[index].emailid.toString();
                                Allvalues.password = items[index].password.toString();
                                Allvalues.phoneno = items[index].phoneno.toString();
                                Allvalues.isActive = items[index].flg == 0 ? false : true;
                                Allvalues.key = datamodels[index].key;
      */

                                useres = false;
                                _isShow = true;
                                search = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              print("object");
                              //User().deleteUser(datamodels![index]);
                              ref
                                  .read(updateUserNotifier.notifier)
                                  .updatetUser({
                                "user_id": items[index].userId,
                                "emp_id": items[index].empId.toString(),
                                "name": items[index].name.toString(),
                                "password": items[index].password.toString(),
                                "avatar_id": null,
                                "emailid": items[index].emailid.toString(),
                                "phoneno": items[index].phoneno.toString(),
                                "role": items[index].role.toString(),
                                "created_by": 0,
                                "updated_by": 0,
                                "created_date": null,
                                "updated_date": null,
                                "flg": 0
                              });
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

  getActiveItems(List<Users> items, int index) {
    var activevalue = items.where((element) => element.flg == 1).toList();
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
                                  color: (){
                                    if(_textEditingController.text.isNotEmpty){
                                      return glossarListOnSearch[index].flg == 1
                                          ? Colors.green
                                          : Colors.red;
                                    }else{
                                      return activevalue[index].flg == 1
                                          ? Colors.green
                                          : Colors.red;
                                    }
                                  }(),

                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].empId!
                                  : activevalue[index].empId.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].name!
                                  : activevalue[index].name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].emailid!
                                  : activevalue[index].emailid.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].phoneno!
                                  : activevalue[index].phoneno.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].role!
                                  : activevalue[index].role.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
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
                                if (_textEditingController.text.isNotEmpty) {
                                  user.userId =
                                      glossarListOnSearch[index].userId;
                                  user.name = glossarListOnSearch[index]
                                      .name
                                      .toString();
                                  user.empId = glossarListOnSearch[index]
                                      .empId
                                      .toString();
                                  user.emailid = glossarListOnSearch[index]
                                      .emailid
                                      .toString();
                                  user.password = glossarListOnSearch[index]
                                      .password
                                      .toString();
                                  user.phoneno = glossarListOnSearch[index]
                                      .phoneno
                                      .toString();
                                  user.flg = glossarListOnSearch[index].flg == 0
                                      ? 0
                                      : 1;
                                  user.role = glossarListOnSearch[index]
                                      .role
                                      .toString();
                                }else{
                                  user.userId = activevalue[index].userId;
                                  user.name = activevalue[index].name.toString();
                                  user.empId =
                                      activevalue[index].empId.toString();
                                  user.emailid =
                                      activevalue[index].emailid.toString();
                                  user.password =
                                      activevalue[index].password.toString();
                                  user.phoneno =
                                      activevalue[index].phoneno.toString();
                                  user.flg = activevalue[index].flg == 0 ? 0 : 1;
                                  user.role = activevalue[index].role.toString();
                                }


                                AddUsers(user: user);

                                _isShow = true;
                                useres = false;
                                search = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(updateUserNotifier.notifier)
                                  .updatetUser({
                                "user_id": activevalue[index].userId,
                                "emp_id": activevalue[index].empId.toString(),
                                "name": activevalue[index].name.toString(),
                                "password":
                                    activevalue[index].password.toString(),
                                "avatar_id": null,
                                "emailid":
                                    activevalue[index].emailid.toString(),
                                "phoneno":
                                    activevalue[index].phoneno.toString(),
                                "role": activevalue[index].role.toString(),
                                "created_by": 0,
                                "updated_by": 0,
                                "created_date": null,
                                "updated_date": null,
                                "flg": 0
                              });
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

  getInActiveItems(List<Users> items, int index) {
    var inactivevalue = items.where((element) => element.flg == 0).toList();
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
                                  color:(){
                                    if(_textEditingController.text.isNotEmpty){
                                     return glossarListOnSearch[index].flg == 1
                                          ? Colors.green
                                          : Colors.red;
                                    }else{
                                      return inactivevalue[index].flg == 1
                                          ? Colors.green
                                          : Colors.red;
                                    }

                                  }(),

                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].empId!
                                  : inactivevalue[index].empId.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].name!
                                  : inactivevalue[index].name.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].emailid!
                                  : inactivevalue[index].emailid.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].phoneno!
                                  : inactivevalue[index].phoneno.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(_textEditingController.text.isNotEmpty
                                  ? glossarListOnSearch[index].role!
                                  : inactivevalue[index].role.toString(),

                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
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
                                if (_textEditingController.text.isNotEmpty) {
                                  user.userId =
                                      glossarListOnSearch[index].userId;
                                  user.name = glossarListOnSearch[index]
                                      .name
                                      .toString();
                                  user.empId = glossarListOnSearch[index]
                                      .empId
                                      .toString();
                                  user.emailid = glossarListOnSearch[index]
                                      .emailid
                                      .toString();
                                  user.password = glossarListOnSearch[index]
                                      .password
                                      .toString();
                                  user.phoneno = glossarListOnSearch[index]
                                      .phoneno
                                      .toString();
                                  user.flg = glossarListOnSearch[index].flg == 0
                                      ? 0
                                      : 1;
                                  user.role = glossarListOnSearch[index]
                                      .role
                                      .toString();
                                }else{
                                  user.userId = inactivevalue[index].userId;
                                  user.name =
                                      inactivevalue[index].name.toString();
                                  user.empId =
                                      inactivevalue[index].empId.toString();
                                  user.emailid =
                                      inactivevalue[index].emailid.toString();
                                  user.password =
                                      inactivevalue[index].password.toString();
                                  user.phoneno =
                                      inactivevalue[index].phoneno.toString();
                                  user.flg =
                                  inactivevalue[index].flg == 0 ? 0 : 1;
                                  user.role =
                                      inactivevalue[index].role.toString();
                                }


                                AddUsers(user: user);

                                _isShow = true;
                                useres = false;
                                search = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(updateUserNotifier.notifier)
                                  .updatetUser({
                                "user_id": inactivevalue[index].userId,
                                "emp_id": inactivevalue[index].empId.toString(),
                                "name": inactivevalue[index].name.toString(),
                                "password":
                                    inactivevalue[index].password.toString(),
                                "avatar_id": null,
                                "emailid":
                                    inactivevalue[index].emailid.toString(),
                                "phoneno":
                                    inactivevalue[index].phoneno.toString(),
                                "role": inactivevalue[index].role.toString(),
                                "created_by": 0,
                                "updated_by": 0,
                                "created_date": null,
                                "updated_date": null,
                                "flg": 0
                              });
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
}
