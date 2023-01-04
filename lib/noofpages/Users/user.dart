import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/usermanagement.dart';
import 'package:production_automation_testing/noofpages/Users/addusers.dart';

import '../../DashBoard/src/ProjectCardOverview.dart';
import '../../DashBoard/src/tabs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/boxes.dart';
import '../../Database/Curd_operation/database.dart';
import '../../Provider/general_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  UserPage({Key, key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

int? key;
UserManagementmodel? data;
List<UserManagementmodel>? datamodels;

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

/*
  @override
  void dispose(){
   Hive.box('pat').close();
   super.dispose();
  }
*/

  Box<UserManagementmodel> active1 = Hive.box<UserManagementmodel>('pat');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserManagementmodel>>(
        valueListenable: Boxes.getUsers().listenable(),
        builder: (context, Box<UserManagementmodel> items, _) {
          List<int> keys;
          keys = items.keys.cast<int>().toList();
          datamodels = items.values.toList().cast<UserManagementmodel>();

          var activevalue = items.values
              .where((element) => element.isActive == true)
              .toList();

          var inactivevalue = items.values
              .where((element) => element.isActive == false)
              .toList();

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
                                  _isShow = !_isShow;
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
                        margin: EdgeInsets.only(top: 5.0),
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
                                icon: Feather.moon),
                            ProjectCardView(
                                color: Color(0xff6C6CE5),
                                projectName: 'Delivery Club',
                                percentComplete: '78%',
                                progressIndicatorColor: Colors.blue[200],
                                icon: Feather.truck),
                            ProjectCardView(
                                color: Color(0xffFAAA1E),
                                projectName: 'Travel Comrode',
                                percentComplete: '82%',
                                progressIndicatorColor: Colors.amber[200],
                                icon: Icons.local_airport),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 32.0),
                        child: Row(
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
                                    active = false;
                                    inactive = false;
                                  });
                                }),
                            SizedBox(
                              width: 15.0,
                            ),
                            ElevatedButton(
                                child: Text("Active".toUpperCase(),
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
                                    active = true;
                                    inactive = false;
                                  });
                                }),
                            SizedBox(
                              width: 15.0,
                            ),
                            ElevatedButton(
                                child: Text("In Active".toUpperCase(),
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
                                    active = false;
                                    inactive = true;
                                  });
                                }),
                          ],
                        ),
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
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
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
                                        Boxes.getUsers().listenable(),
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
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                color: Color(0xffcbdff2),
                                                elevation: 15,
                                                child: ListView.builder(
                                                    itemCount: () {
                                                  if (all == true) {
                                                    //all = false;
                                                    return keys.length;
                                                  } else if (active == true) {
                                                    // active = false;
                                                    return activevalue.length;
                                                  } else if (inactive == true) {
                                                    // inactive = false;
                                                    return inactivevalue.length;
                                                  } else {
                                                    return 0;
                                                  }
                                                }(), itemBuilder:
                                                        (BuildContext ctxt,
                                                            int index) {
                                                //  key = keys[index] as int;
                                                 /* data = () {
                                                    if(active == true) {
                                                      items.get(activevalue[index].key);
                                                    }else if (inactive == true) {
                                                      items.get(inactivevalue[index].key);
                                                    }else{ if(all == true)
                                                      items.get(key);
                                                    }
                                                  }();*/

                                                 // items.get(key);
                                                  return (){
                                                      if(all == true){
                                                      return  getListItems(items, index);
                                                    }else if(active == true){
                                                        return getActiveItems(items, index);
                                                      }else if(inactive == true){
                                                        return getInActiveItems(items, index);
                                                      }else{
                                                        return getListItems(items, index);
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
                child: Expanded(flex: 5, child: AddUsers()),
              ),
            ],
          );
        });
  }
/*

  getactive(Box<UserManagementmodel> items){
    List<int> keys;
    keys = items.keys.cast<int>().toList();
    datamodels = items.values.toList().cast<UserManagementmodel>();
    final activevalue = items.values.where((element) => element.isActive == true);
    print('filteredvalues =========> $activevalue');
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
              child: ListView.builder(
                  itemCount: activevalue.length,
                  itemBuilder: (BuildContext ctxt,
                      int index) {
                    key = keys[index] as int;
                    data = items.get(key);
                    return getListItems(
                        items, index);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  getinactive(Box<UserManagementmodel> items){
    List<int> keys;
    keys = items.keys.cast<int>().toList();
    datamodels = items.values.toList().cast<UserManagementmodel>();
    final inactivevalue = items.values.where((element) => element.isActive == false);
    print('filteredvalues =========> $inactivevalue');
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
              child: ListView.builder(
                  itemCount: inactivevalue.length,
                  itemBuilder: (BuildContext ctxt,
                      int index) {
                    key = keys[index] as int;
                    data = items.get(key);
                    return getListItems(
                        items, index);
                  }),
            ),
          ),
        ],
      ),
    );
  }
*/

  getListItems(Box<UserManagementmodel> items, int index) {
    List<int> keys;
    keys = items.keys.cast<int>().toList();
    final datamodels = items.values.toList().cast<UserManagementmodel>();

    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: datamodels[index].isActive == true
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: Text(datamodels[index].emp_id.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(datamodels[index].name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(datamodels[index].email.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                    datamodels[index].phoneno.toString(),
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
                        /* Row(
                          children: [
                            Text('EMP ID :'),
                            Text(datamodels[index].emp_id.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("NAME :"),
                            Text(datamodels[index].name.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('EMAIL ID ;'),
                            Text(datamodels[index].email.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('PASSWORD ;'),
                            Text(datamodels[index].password.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Phone No'),
                            Text(datamodels[index].phoneno.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: datamodels[index].isActive == true
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle),
                            )
                          ],
                        ),*/
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
                                  Allvalues.name =
                                      datamodels[index].name.toString();
                                  Allvalues.emp_id =
                                      datamodels[index].emp_id.toString();
                                  Allvalues.email =
                                      datamodels[index].email.toString();
                                  Allvalues.password =
                                      datamodels[index].password.toString();
                                  Allvalues.phoneno =
                                      datamodels[index].phoneno.toString();
                                  Allvalues.isActive =
                                      datamodels[index].isActive;
                                  Allvalues.key = datamodels[index].key;

                                  _isShow = true;
                                });
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                DataBase().deleteUser(datamodels[index]);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ));
  }

  getActiveItems(Box<UserManagementmodel> items, int index) {

    var activevalue = items.values.where((element) => element.isActive == true).toList();

    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: activevalue[index].isActive == true
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Center(
                                child: Text(activevalue[index].emp_id.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(activevalue[index].name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(activevalue[index].email.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                    activevalue[index].phoneno.toString(),
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
                                  Allvalues.name =
                                      activevalue[index].name.toString();
                                  Allvalues.emp_id =
                                      activevalue[index].emp_id.toString();
                                  Allvalues.email =
                                      activevalue[index].email.toString();
                                  Allvalues.password =
                                      activevalue[index].password.toString();
                                  Allvalues.phoneno =
                                      activevalue[index].phoneno.toString();
                                  Allvalues.isActive =
                                      activevalue[index].isActive;
                                  Allvalues.key = activevalue[index].key;

                                  _isShow = true;
                                });
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                DataBase().deleteUser(activevalue[index]);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ));
  }

  getInActiveItems(Box<UserManagementmodel> items, int index) {
    var inactivevalue = items.values.where((element) => element.isActive == false).toList();
    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: inactivevalue[index].isActive == true
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: Text(inactivevalue[index].emp_id.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(inactivevalue[index].name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(inactivevalue[index].email.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.black)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                    inactivevalue[index].phoneno.toString(),
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
                                  Allvalues.name =
                                      inactivevalue[index].name.toString();
                                  Allvalues.emp_id =
                                      inactivevalue[index].emp_id.toString();
                                  Allvalues.email =
                                      inactivevalue[index].email.toString();
                                  Allvalues.password =
                                      inactivevalue[index].password.toString();
                                  Allvalues.phoneno =
                                      inactivevalue[index].phoneno.toString();
                                  Allvalues.isActive =
                                      inactivevalue[index].isActive;
                                  Allvalues.key = inactivevalue[index].key;

                                  _isShow = true;
                                });
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                DataBase().deleteUser(inactivevalue[index]);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

}
