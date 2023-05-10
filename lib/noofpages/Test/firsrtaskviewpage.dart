import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/noofpages/Test/secondtaskviewpage.dart';

import '../../HomeScreen.dart';
import '../../NavigationBar/src/company_name.dart';
import '../../NavigationBar/src/testuser.dart';



class TestPage extends ConsumerStatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
  bool isSelected = false;
  var fontSize, height;





  @override
  Widget build(BuildContext context) {
    fontSize = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

      return Scaffold(
        body: Row (
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
                  Align(
                      alignment: Alignment.center,
                      child: TestuserNavBar()
                  ),
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
                        IconButton(onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HomeScreenPage()));
                        }, icon: Icon(Icons.arrow_back_outlined)),
                        Text(
                          "Task view",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.blueAccent,
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child:Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "WorkOrder Id : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('PSBE Workorder', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Quantity : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('2000', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Start serial no : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('101', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "End serial no : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('500', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Status : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('on going', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Created by : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('Ponmudi', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),

                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Created date : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Colors.red
                                ),
                              ),
                              Text('12-01-2023', style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black
                              ),),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              height: 20.0,
                              width: 10.0,
                              child: Center(
                                  child: Text("Product Id",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15.0,
                                          color: Colors.black))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 20.0,
                              width: 10.0,
                              child: Center(
                                  child: Text("Mac",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Status" ,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
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

                       Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  height: 500,
                                  color: Color(0xFFd9d8d7),
                                  child: ListView.builder(
                                      itemCount: 3,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        return getProduct();
                                      })
                              ),
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
        ],
    ),
      );
  }

  getProduct() {
    return GestureDetector(
      onTap: (){
        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecondTaskViewPage()));*/
      },
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 20.0,
                    width: 10.0,
                    child: Center(
                        child: Text("16 Zone",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0,
                                color: Colors.black))),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20.0,
                    width: 10.0,
                    child: Center(
                        child: Text("1245890568890084",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0,
                                color: Colors.black))),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20.0,
                    width: 10.0,
                    child: Center(
                        child: Text("in progress",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13.0,
                                color: Colors.black))),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
