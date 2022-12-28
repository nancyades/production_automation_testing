
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_automation_testing/noofpages/Users/addusers.dart';

import '../../DashBoard/src/ProjectCardOverview.dart';
import '../../DashBoard/src/tabs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Database/database.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isShow = false;
  var selectRole= "Super Admin";
  List<String> roles = ['Super Admin', 'Design Admin', 'Test Admin', 'Design User', 'Test User'];

  @override
  void initState(){
    PatDataBase().initializedDB();
    super.initState();
  }


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
                          flex: 3,
                          child: Container(
                            height: 20.0,
                            width: 10.0,
                            child: Center(child: Text("User",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.black ))),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: DropdownButton(
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 40.0),
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
                                print("Index==>"+selectRole);
                                //List<FirstClass> emptylist = [];

                              });
                            },
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
                                          Text("Nancy"),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )

                                        ],
                                      ),
                                    ));
                              }
                          ),
                        ),

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
              child: AddUsers()),
        ),
      ],
    );
  }
}
