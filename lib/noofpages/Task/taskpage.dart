import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:production_automation_testing/DashBoard/src/ProjectCardOverview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/Model/APIModel/usermodel.dart';
import 'package:production_automation_testing/Model/APIModel/workordermodel.dart';
import 'package:production_automation_testing/Provider/post_provider/task_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/taskdetails_provider.dart';
import 'package:production_automation_testing/noofpages/Task/src/tasklistitem.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/workorderscreenpage.dart';
import '../../DashBoard/src/cardcount/taskcount.dart';
import '../../DashBoard/src/tabs.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/APIModel/taskmodel.dart';
import '../../Provider/excelprovider.dart';
import 'assignpage.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  bool _isShow = false;

  var selectUsers = "";

  var selectProduct = "";


  var selectStatus = "open";
  List<String> Status = ['open', 'in progress', 'complete',];

  var selectWorkorder = "";
  List<String> workorders = [
    'PSBEWorkorder',
    '16ZoneWorkorder',
    'PSBE-EWorkorder',
    '32ZoneWorkorder'
  ];

  DateTime date = DateTime(2022, 12, 07);
  int? taskId = 0;
  int? userId = 0;
  String? username = "";
  int? assignId = 0;
  int? wolId = 0;
  String? workOrder;
  int? templateId = 0;
  String? templateName = "";
  String? productName = "";
  String? productCode = "";
  int? quantity = 0;
  String? startSerialNo = "";
  String? endSerialNo = "";
  String? status = "";
  String? testingStatus = "";
  dynamic startDate = "";
  dynamic endDate = "";
  int? welcomeCreatedBy = 0;
  String? createdBy = "";
  int? welcomeUpdatedBy = 0;
  String? updatedBy = "";
  dynamic createdDate = "";
  dynamic updatedDate = "";
  int? flg = 0;
  int? rating = 0;

  int e = 0;



  @override
  void initState(){
    ref.refresh(getTaskNotifier);
  }
  TaskModel task = TaskModel();

  @override
  Widget build(BuildContext context) {

    return  ref.watch(getTaskNotifier).when(data: (datum){
      return Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.63,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TASK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(15),
                          onPressed: () {
                            ref.refresh(getWorkorderNotifier);
                            setState(() {
                              _isShow = !_isShow;
                              Helper.cleartemplate = false;
                               Helper.dropDown = "SHOW";
                              task.taskId = 0;
                              task.userId = 0;
                              task.assignId = 0;
                              task.wolId = 0;
                              task.quantity = 0;
                              task.startSerialNo = "";
                              task.endSerialNo = "";
                              task.status = "";
                              task.testingStatus = "";
                              task.startDate = "";
                              task.endDate = "";
                              task.createdDate = "";
                              task.updatedDate = "";
                              task.flg = 0;
                              task.rating = 0;
                              Helper.editvalue = "noteditedvalue";
                              AssignTask(tasks: task);
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
                      return ref.watch(getTaskCountNotifier).when(data: (count){
                        return
                        /* Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.19,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: Color(0xffcbdff2),
                              //Colors.blueAccent,
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            TaskCardView(
                                                color: Color(0xffFF4C60),
                                                projectName: 'Task count',
                                                percentComplete: '${count[0].taskCount}%',
                                                peopleCount: count[0].taskCount,
                                                progressIndicatorColor: Colors.redAccent[100],
                                                icon: Feather.calendar
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text( "Task Count",   style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color:  Colors.black
                                                  ),)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            TaskCardView(
                                                color: Color(0xff6C6CE5),
                                                projectName: 'In-Progress',
                                                percentComplete: '${count[0].inprogress}%',
                                                peopleCount: count[0].inprogress,
                                                progressIndicatorColor: Colors.blue[200],
                                                icon: Feather.truck
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text( "In-Progress",   style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color:  Colors.black
                                                  ),)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            TaskCardView(
                                                color: Color(0xffFAAA1E),
                                                projectName: 'Complete',
                                                percentComplete: '${count[0].completed}%',
                                                peopleCount: count[0].completed,
                                                progressIndicatorColor: Colors.amber[200],
                                                icon: Icons.local_airport
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text( "Complete",   style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color:  Colors.black
                                                  ),)),
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
                        );*/
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                                  Card(
                                    elevation:12,
                                    child: Container(
                                      width:170,
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
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("${count[0].taskCount}%",  style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18.0,
                                                              color:  Colors.deepOrange.shade300
                                                          ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("All Task", style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12.0,
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
                                                     Icon(Icons.bar_chart)
                                                    ],
                                                  ),

                                                ),
                                              ],
                                            ),
                                          ),


                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width:168,
                                                height:36,
                                                decoration: BoxDecoration(
                                                    color: Colors.deepOrange,
                                                    shape: BoxShape.rectangle
                                                ),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('% change'),
                                                      Icon(Icons.call_made, size: 16,),
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
                                  width:170,
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
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${count[0].inprogress}%",  style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18.0,
                                                          color:  Colors.green.shade300
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("In-Progress", style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12.0,
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
                                                  Icon(Icons.incomplete_circle)
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),


                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width:168,
                                            height:36,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.rectangle
                                            ),
                                            child:  Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(Icons.call_made, size: 16,),
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
                                  width:170,
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
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${count[0].completed}%",  style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18.0,
                                                          color:  Colors.amber.shade300
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Completed", style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12.0,
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
                                                  Icon(Icons.thumb_up)
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),


                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width:168,
                                            height:36,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                shape: BoxShape.rectangle
                                            ),
                                            child:  Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(Icons.call_made, size: 16,),
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



                             /* TaskCardView(
                                  color: Color(0xffFF4C60),
                                  projectName: 'Task count',
                                  percentComplete: '${count[0].taskCount}%',
                                  peopleCount: count[0].taskCount,
                                  progressIndicatorColor: Colors.redAccent[100],
                                  icon: Feather.calendar),
                              TaskCardView(
                                  color: Color(0xff6C6CE5),
                                  projectName: 'In-Progress',
                                  percentComplete: '${count[0].inprogress}%',
                                  peopleCount: count[0].inprogress,
                                  progressIndicatorColor: Colors.blue[200],
                                  icon: Feather.truck),
                              TaskCardView(
                                  color: Color(0xffFAAA1E),
                                  projectName: 'Complete',
                                  percentComplete: '${count[0].completed}%',
                                  peopleCount: count[0].completed,
                                  progressIndicatorColor: Colors.amber[200],
                                  icon: Icons.local_airport),*/
                            ],
                          );

                      }, error: (e,s){
                        return Text(e.toString());
                      }, loading: (){
                        return CircularProgressIndicator();
                      });

                    }
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        color: Color(0xff8fcceb),
                                        //Colors.blueAccent,
                                        elevation: 10,
                                        child: Center(
                                            child: Text("TASK ASSIGN",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.black))),
                                      ),
                                    ),

                                    Card(
                                      elevation:10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              highlightColor: Colors.amberAccent,
                                              onPressed: (){
                                                ref.refresh(getTaskNotifier);

                                              }, icon: Icon(Icons.refresh,)),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text("Username",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                          Consumer(
                                            builder: (context, ref, child) {
                                             return ref.watch(getUserNotifier).when(data: (data){
                                               List<Users> testuser = data.where((element) => element.role == "Test User").toList();


                                               selectUsers =testuser.isEmpty? "": testuser[0].name.toString();
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
                                          Text("workorder",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                          Consumer(
                                            builder: (context, ref, child) {
                                             return ref.watch(getWorkorderNotifier).when(data: (data){
                                               List<WorkorderModel> workorder = data.where((element) => element.status == "Approved").toList();


                                               //selectWorkorder = workorder[0].workorderCode.toString();
                                               selectWorkorder = data.isEmpty ? "" :data[0].workorderCode.toString();

                                               return DropdownButton(
                                                 icon: Padding(
                                                   padding: const EdgeInsets.only(left: 8.0),
                                                   child: Icon(Icons.keyboard_arrow_down),
                                                 ),
                                                 items: data.map<DropdownMenuItem<String>>(
                                                         (WorkorderModel setlist) {
                                                       return DropdownMenuItem<String>(
                                                         value: setlist.workorderCode,
                                                         child: Text(setlist.workorderCode.toString()),
                                                       );
                                                     }).toList(),
                                                 value: selectWorkorder,
                                                 onChanged: (item) {

                                                   setState(() {
                                                     selectWorkorder = item.toString();
                                                     print("Index==>"+selectWorkorder);
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
                                          Text("product",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                          Consumer(

                                            builder: (context, ref, child) {
                                              return ref.watch(getProductNotifier).when(data: (data){

                                                selectProduct = data.isEmpty ? "":data[0].productName.toString();

                                                return DropdownButton(
                                                  icon: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Icon(Icons.keyboard_arrow_down),
                                                  ),
                                                  items: data.map<DropdownMenuItem<String>>(
                                                          (Productmodel setlist) {
                                                        return DropdownMenuItem<String>(
                                                          value: setlist.productName,
                                                          child: Text(setlist.productName.toString()),
                                                        );
                                                      }).toList(),
                                                  value: selectProduct,
                                                  onChanged: (item) {

                                                    setState(() {
                                                      selectProduct = item.toString();
                                                      print("Index==>"+selectProduct);
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
                                          Text("status",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                          DropdownButton(
                                            icon: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Icon(Icons.keyboard_arrow_down),
                                            ),
                                            items: Status.map<DropdownMenuItem<String>>(
                                                    (String setlist) {
                                                  return DropdownMenuItem<String>(
                                                    value: setlist,
                                                    child: Text(setlist.toString()),
                                                  );
                                                }).toList(),
                                            value: selectStatus,
                                            onChanged: (item) {

                                              setState(() {
                                                selectStatus = item.toString();
                                                print("Index==>"+selectStatus);
                                                //List<FirstClass> emptylist = [];

                                              });
                                            },
                                          ),


                                        ],
                                      ),
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
                                            Text(' '),
                                            Expanded(
                                              child: Container(
                                                height: 20.0,
                                                width: 10.0,
                                                child: Center(child: Text("Name",
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
                                                child: Center(child: Text("Product",
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
                                                child: Center(child: Text("Workorder",
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
                                                child: Center(child: Text("Quantity",
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
                                                child: Center(child: Text("Start Serial",
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
                                                child: Center(child: Text("End Serial",
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
                                                child: Center(child: Text("Status",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            controller: ScrollController(),
                                            itemCount: datum.length,
                                            itemBuilder: (BuildContext ctxt, int index) {
                                              return
                                                InkWell(
                                                  onTap: (){

                                                    setState(() {

                                                     /* taskId= datum[index].taskId;
                                                      userId= datum[index].userId;
                                                      username = datum[index].username;
                                                      assignId= datum[index].assignId;
                                                      wolId= datum[index].wolId;
                                                      workOrder = datum[index].workOrder.toString();
                                                      templateId = datum[index].templateId;
                                                      templateName = datum[index].templateName;
                                                      productName = datum[index].productName;
                                                      productCode = datum[index].productCode;
                                                      quantity= datum[index].wolId;
                                                      startSerialNo= datum[index].startSerialNo;
                                                      endSerialNo= datum[index].endSerialNo;
                                                      status= datum[index].status;
                                                      testingStatus= datum[index].testingStatus;
                                                      startDate= datum[index].startDate;
                                                      endDate= datum[index].endDate;
                                                      welcomeCreatedBy = datum[index].welcomeCreatedBy;
                                                      createdBy= datum[index].createdBy;
                                                      updatedBy= datum[index].updatedBy;
                                                      welcomeUpdatedBy = datum[index].welcomeUpdatedBy;
                                                      createdDate= datum[index].createdDate;
                                                      updatedDate= datum[index].updatedDate;
                                                      flg= datum[index].flg;
                                                      rating= datum[index].rating;*/




                                                      Helper.cleartemplate = false;
                                                      task.taskId = datum[index].taskId;
                                                      task.userId = datum[index].userId;
                                                      task.assignId = datum[index].assignId;
                                                      task.wolId = datum[index].wolId;
                                                      task.quantity = datum[index].quantity;
                                                      task.startSerialNo = datum[index].startSerialNo;
                                                      task.endSerialNo = datum[index].endSerialNo;
                                                      task.status = datum[index].status;
                                                      task.testingStatus = datum[index].testingStatus;
                                                      task.startDate = datum[index].startDate;
                                                      task.endDate = datum[index].endDate;
                                                      task.createdDate = datum[index].createdDate;
                                                      task.updatedDate = datum[index].updatedDate;
                                                      task.flg = datum[index].flg;
                                                      task.rating = datum[index].rating;
                                                      task.workorderid = datum[index].workorderid;
                                                      task.productid =datum[index].productid;
                                                      task.username = datum[index].username;

                                                      List<Testing> test = [];




                                                      for(int i = 0; i< datum[index].testing!.length; i++){
                                                      if(task.taskId == datum[index].testing![i].taskId){
                                                        Testing wlist = Testing(
                                                          testId: datum[index].testing![i].taskId,
                                                          taskId: datum[index].testing![i].taskId,
                                                          testStage: datum[index].testing![i].testStage,
                                                          testStatus: datum[index].testing![i].testStatus,
                                                          pass: datum[index].testing![i].pass,
                                                          fail: datum[index].testing![i].fail,
                                                          status: datum[index].testing![i].status,
                                                          flg: datum[index].testing![i].flg,
                                                          macAddress: datum[index].testing![i].macAddress,
                                                          testType: datum[index].testing![i].testType,
                                                          testDate: datum[index].testing![i].testDate,
                                                          hoursTaken: datum[index].testing![i].hoursTaken,
                                                          testNumber: datum[index].testing![i].testNumber,
                                                          isSelected: false,
                                                        );
                                                        test.add(wlist);
                                                      }
                                                      }
                                                      var seen = Set<String>();
                                                      List<Testing> uniquelist = test.where((student) => seen.add(student.testStatus.toString())).toList();




                                                      task.testing = uniquelist;
                                                      //task.testing =
                                                      AssignTask(tasks: task);
                                                      _isShow = true;
                                                      Helper.editvalue = "editedvalue";
                                                      Helper.dropDown = "HIDE";



                                                      ref.read(addTaskdetailsNotifier.notifier).addTaskdetails(datum[index].workorderid, datum[index].productid);


                                                    });
                                                  /*  showDialog(
                                                        context: context,
                                                        builder: (c) => AlertDialog(
                                                          title: Text('TASK VIEW'),
                                                          //content: Text("msg"),
                                                          actions: [
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  width: 660,
                                                                  height: 450,
                                                                  child: Card(
                                                                      color: Colors.white70,
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                              flex: 2,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10.0),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Task id : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(taskId.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "User id : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(userId.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "User name : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(username.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Assign id : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(assignId.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text("template name : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(templateName.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text("product name : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(productName.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "User id : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(userId.toString(), style: TextStyle(
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
                                                                                        Text(quantity.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Start Serial no0 : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(startSerialNo.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "End Serial no : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(endSerialNo.toString(), style: TextStyle(
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
                                                                                        Text(status.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "testing Status  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(testingStatus.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Start date  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text((){
                                                                                          var str = startDate.toString().split('T')[0];
                                                                                          return str.toString();

                                                                                        }(),
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.black
                                                                                          ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "end date  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text((){
                                                                                          var str = endDate.toString().split('T')[0];
                                                                                          return str.toString();
                                                                                        }(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Created by  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(createdBy.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Updated by  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(updatedBy.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Created date  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text((){
                                                                                          var str = createdDate.toString().split('T')[0];
                                                                                          return str.toString();

                                                                                        }(),
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.black
                                                                                          ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Updated date  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text((){
                                                                                          var str = updatedDate.toString().split('T')[0];
                                                                                          return str.toString();
                                                                                        }(),
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.black
                                                                                          ),),

                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "Rating  : ",
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 14.0,
                                                                                              color: Colors.red
                                                                                          ),
                                                                                        ),
                                                                                        Text(rating.toString(), style: TextStyle(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontSize: 14.0,
                                                                                            color: Colors.black
                                                                                        ),),

                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                        ],
                                                                      )),

                                                                ),

                                                                TextButton(
                                                                    child: const Text('Ok'),
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                    }),
                                                              ],
                                                            ),
                                                          ],
                                                        ));*/


                                                  },
                                                  child: TaskListItems(
                                                    username: datum[index].username.toString(),
                                                      product: datum[index].productid.toString(),
                                                      workorder: datum[index].workorderid.toString(),
                                                      quantity: datum[index].quantity.toString(),
                                                      startserial: datum[index].startSerialNo.toString(),
                                                      endserial: datum[index].endSerialNo.toString(),
                                                    status: datum[index].status.toString(),

                                                  ),
                                                );

                                               /* InkWell(
                                                onTap: (){
                                                  setState(() {
                                                      taskId= datum[index].taskId;
                                                      userId= datum[index].userId;
                                                      assignId= datum[index].assignId;
                                                      wolId= datum[index].wolId;
                                                      quantity= datum[index].wolId;
                                                      startSerialNo= datum[index].startSerialNo;
                                                      endSerialNo= datum[index].endSerialNo;
                                                      status= datum[index].status;
                                                      testingStatus= datum[index].testingStatus;
                                                      startDate= datum[index].startDate;
                                                      endDate= datum[index].endDate;
                                                      createdBy= datum[index].createdBy;
                                                      updatedBy= datum[index].updatedBy;
                                                      createdDate= datum[index].createdDate;
                                                      updatedDate= datum[index].updatedDate;
                                                      flg= datum[index].flg;
                                                      rating= datum[index].rating;

                                                  });

                                                },
                                                child: Card(
                                                    color: Colors.teal[100],
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "User Name : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14.0,
                                                                            color: Colors.red
                                                                        ),
                                                                      ),
                                                                      Text(datum[index].userId.toString(), style: TextStyle(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 14.0,
                                                                          color: Colors.black
                                                                      ),),

                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Product : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14.0,
                                                                            color: Colors.red
                                                                        ),
                                                                      ),
                                                                      Text(datum[index].assignId.toString(), style: TextStyle(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 14.0,
                                                                          color: Colors.black
                                                                      ),),

                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Workorder : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14.0,
                                                                            color: Colors.red
                                                                        ),
                                                                      ),
                                                                      Text(datum[index].wolId.toString(), style: TextStyle(
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
                                                                      Text(datum[index].quantity.toString(), style: TextStyle(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 14.0,
                                                                          color: Colors.black
                                                                      ),),

                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Start Serial No : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14.0,
                                                                            color: Colors.red
                                                                        ),
                                                                      ),
                                                                      Text(datum[index].startSerialNo.toString(), style: TextStyle(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 14.0,
                                                                          color: Colors.black
                                                                      ),),

                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "End Serial No : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14.0,
                                                                            color: Colors.red
                                                                        ),
                                                                      ),
                                                                      Text(datum[index].endSerialNo.toString(), style: TextStyle(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 14.0,
                                                                          color: Colors.black
                                                                      ),),

                                                                    ],
                                                                  ),

                                                                ],
                                                              ),
                                                            )),
                                                       */
                                              /* Expanded(
                                                            child: CircularPercentIndicator(
                                                              radius: 50.0,
                                                              lineWidth: 6.5,
                                                              percent: 0.45,
                                                              circularStrokeCap: CircularStrokeCap.round,
                                                              center: Text(
                                                                "45%",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 13.0,
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                              progressColor: Colors.white,
                                                              startAngle: 270,
                                                              backgroundColor: Colors.white54,

                                                            ))*/
                                              /*
                                                      ],
                                                    )),
                                              );*/
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                       /* Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Column(
                                  children: [
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
                                            Center(
                                                child: Text("TASK VIEW",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),(){
                                  if(taskId == 0 && userId == 0 && assignId == 0){
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(child: Text("Click Task assign to view the Task  ")),
                                      ],
                                    );
                                  }else{
                                    return Expanded(
                                      child: Container(
                                        width: 660,
                                        height: 450,
                                        child: Card(
                                            color: Colors.white70,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Task id : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(taskId.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "User id : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(userId.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Assign id : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(assignId.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("Workorder list id : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(wolId.toString(), style: TextStyle(
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
                                                              Text(quantity.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Start Serial no0 : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(startSerialNo.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "End Serial no : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(endSerialNo.toString(), style: TextStyle(
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
                                                              Text(status.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "testing Status  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(testingStatus.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Start date  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text((){
                                                                var str = startDate.toString().split('T')[0];
                                                                return str.toString();

                                                              }(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.black
                                                                ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "end date  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text((){
                                                                var str = endDate.toString().split('T')[0];
                                                                return str.toString();
                                                              }(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Created by  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(createdBy.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Updated by  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(updatedBy.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Created date  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text((){
                                                                var str = createdDate.toString().split('T')[0];
                                                                return str.toString();

                                                              }(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.black
                                                                ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Updated date  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text((){
                                                                var str = updatedDate.toString().split('T')[0];
                                                                return str.toString();
                                                              }(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.black
                                                                ),),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Rating  : ",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.0,
                                                                    color: Colors.red
                                                                ),
                                                              ),
                                                              Text(rating.toString(), style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14.0,
                                                                  color: Colors.black
                                                              ),),

                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            )),

                                      ),
                                    );
                                  }
                                }(),


                              ],
                            ),
                          ),
                        )*/
                      ],
                    ),

                  ),
                /*  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [

                            SizedBox(
                              height: 50,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Color(0xff8fcceb),
                                //Colors.blueAccent,
                                elevation: 10,
                                child: Center(
                                    child: Text("TASK ASSIGN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.black))),
                              ),
                            ),


                            Card(
                              elevation:10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: users.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectUsers,
                                    onChanged: (item) {

                                      setState(() {
                                        selectUsers = item.toString();
                                        print("Index==>"+selectUsers);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: workorders.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectWorkorder,
                                    onChanged: (item) {

                                      setState(() {
                                        selectWorkorder = item.toString();
                                        print("Index==>"+selectWorkorder);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: products.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectProduct,
                                    onChanged: (item) {

                                      setState(() {
                                        selectProduct = item.toString();
                                        print("Index==>"+selectProduct);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),


                                ],
                              ),
                            ),


                            ListView.builder(
                                shrinkWrap: true,
                                controller: ScrollController(),
                                itemCount: datum.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Card(
                                      color: Colors.teal[100],
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "User Name : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        Text(datum[index].userId.toString(), style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14.0,
                                                            color: Colors.black
                                                        ),),

                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Product : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        Text(datum[index].assignId.toString(), style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14.0,
                                                            color: Colors.black
                                                        ),),

                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Workorder : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        Text(datum[index].wolId.toString(), style: TextStyle(
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
                                                        Text(datum[index].quantity.toString(), style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14.0,
                                                            color: Colors.black
                                                        ),),

                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Start Serial No : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        Text(datum[index].startSerialNo.toString(), style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14.0,
                                                            color: Colors.black
                                                        ),),

                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "End Serial No : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        Text(datum[index].endSerialNo.toString(), style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14.0,
                                                            color: Colors.black
                                                        ),),

                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                              child: CircularPercentIndicator(
                                                radius: 50.0,
                                                lineWidth: 6.5,
                                                percent: 0.45,
                                                circularStrokeCap: CircularStrokeCap.round,
                                                center: Text(
                                                  "45%",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 13.0,
                                                      color: Colors.white
                                                  ),
                                                ),
                                                progressColor: Colors.white,
                                                startAngle: 270,
                                                backgroundColor: Colors.white54,

                                              ))
                                        ],
                                      ));
                                }),


                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
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
                                      Center(
                                          child: Text("TASK VIEW",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                    ],
                                  ),
                                ),
                              ),


                              Card(
                                elevation:10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        '${date.year}/${date.month}/${date.day}'
                                    ),
                                    GestureDetector(
                                      onTap: ()async{
                                        DateTime? newDate = await showDatePicker(
                                            context: context,
                                            initialDate: date,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));
                                        if(newDate == null) return;
                                        setState(() {
                                          date = newDate;
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DropdownButton(
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                      items: workorders.map<DropdownMenuItem<String>>(
                                              (String setlist) {
                                            return DropdownMenuItem<String>(
                                              value: setlist,
                                              child: Text(setlist.toString()),
                                            );
                                          }).toList(),
                                      value: selectWorkorder,
                                      onChanged: (item) {

                                        setState(() {
                                          selectWorkorder = item.toString();
                                          print("Index==>"+selectWorkorder);
                                          //List<FirstClass> emptylist = [];

                                        });
                                      },
                                    ),
                                    DropdownButton(
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                      items: products.map<DropdownMenuItem<String>>(
                                              (String setlist) {
                                            return DropdownMenuItem<String>(
                                              value: setlist,
                                              child: Text(setlist.toString()),
                                            );
                                          }).toList(),
                                      value: selectProduct,
                                      onChanged: (item) {

                                        setState(() {
                                          selectProduct = item.toString();
                                          print("Index==>"+selectProduct);
                                          //List<FirstClass> emptylist = [];

                                        });
                                      },
                                    ),


                                  ],
                                ),
                              ),




                              SizedBox(
                                height: 350,
                                child: ListView.builder(
                                    itemCount: 20,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return Card(
                                          color: Colors.green[100],
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("16 zone"),
                                                Text("100"),
                                                Text("001"),
                                                Text("500"),
                                              ],
                                            ),
                                          ));
                                    }),
                              ),



                            ],
                          ),
                        ),
                      )
                    ],
                  ),*/

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
                child: AssignTask(tasks: task)),
          ),
        ],
      );
    }, error: (e,s){
      print("nancy----> ${e.toString()}");
      return Text(e.toString());
        }, loading: (){
      return CircularProgressIndicator();
        });

  }
}
