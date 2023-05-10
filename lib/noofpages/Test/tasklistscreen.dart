import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Helper/helper.dart';

import 'package:production_automation_testing/Provider/post_provider/taskdetails_provider.dart';
import 'package:production_automation_testing/noofpages/Task/src/tasklistitem.dart';
import 'package:production_automation_testing/noofpages/Task/src/testtasklistitems.dart';
import 'package:production_automation_testing/noofpages/Test/firsrtaskviewpage.dart';
import 'package:production_automation_testing/noofpages/Test/secondtaskviewpage.dart';

import '../../Model/APIModel/taskmodel.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/post_provider/tasklist_provider.dart';


class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  bool _isShow = false;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getTaskListNotifier.notifier).addTaskList(Helper.shareduserid);
    });
  }

  TaskModel task = TaskModel();

  List<TemplateValue> tempu = [];

  @override
  Widget build(BuildContext context) {
    return ref.watch(getTaskListNotifier).id.when(data: (datum) {

      return Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.63,
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
                      ],
                    ),
                  ),
                  Consumer(
                      builder: (context, ref, child) {
                        return ref.watch(getTaskCountNotifier).when(data: (
                            count) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Card(
                                elevation: 12,
                                child: Container(
                                  width: 170,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.white10,
                                            spreadRadius: 10,
                                            blurRadius: 12)
                                      ],
                                      border: Border.all(color: Colors.grey),
                                      backgroundBlendMode: BlendMode.darken,
                                      color: Colors.white,
                                      shape: BoxShape.rectangle
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${count[0]
                                                          .taskCount}%",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .deepOrange
                                                                  .shade300
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("All Task",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .black
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
                                            width: 168,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                shape: BoxShape.rectangle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(
                                                    Icons.call_made, size: 16,),
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
                                  width: 170,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.white10,
                                            spreadRadius: 10,
                                            blurRadius: 12)
                                      ],
                                      border: Border.all(color: Colors.grey),
                                      backgroundBlendMode: BlendMode.darken,
                                      color: Colors.white,
                                      shape: BoxShape.rectangle
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${count[0]
                                                          .inprogress}%",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .green
                                                                  .shade300
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("In-Progress",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .black
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
                                            width: 168,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.rectangle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(
                                                    Icons.call_made, size: 16,),
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
                                  width: 170,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Colors.white10,
                                            spreadRadius: 10,
                                            blurRadius: 12)
                                      ],
                                      border: Border.all(color: Colors.grey),
                                      backgroundBlendMode: BlendMode.darken,
                                      color: Colors.white,
                                      shape: BoxShape.rectangle
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("${count[0]
                                                          .completed}%",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 18.0,
                                                              color: Colors
                                                                  .amber
                                                                  .shade300
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Completed",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .black
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
                                            width: 168,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                shape: BoxShape.rectangle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text('% change'),
                                                  Icon(
                                                    Icons.call_made, size: 16,),
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
                          );
                        }, error: (e, s) {
                          return Text(e.toString());
                        }, loading: () {
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
                                          borderRadius: BorderRadius.circular(
                                              8.0),
                                        ),
                                        color: Color(0xff8fcceb),
                                        //Colors.blueAccent,
                                        elevation: 10,
                                        child: Center(
                                            child: Text("TASK LIST",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.black))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        color:  Color(0xffc7f6d5),
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
                                                child: Center(child: Text("Product Name",
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
                                                child: Center(child: Text("Product Code",
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
                                                child: Center(child: Text("Created By",
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
                                            itemBuilder: (BuildContext ctxt,
                                                int index) {
                                              return
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      TemplateValue temp = TemplateValue(
                                                        templateId: datum[index].product.template[0].templateId,
                                                        templateName: datum[index].product.template[0].templateName,
                                                        filePath: datum[index].product.template[0].filePath,
                                                        createdBy: datum[index].product.template[0].createdBy,
                                                        updatedBy: datum[index].product.template[0].updatedBy,
                                                        createdDate: datum[index].product.template[0].createdDate,
                                                        updatedDate: datum[index].product.template[0].updatedDate,
                                                        flg: datum[index].product.template[0].flg,
                                                        remarks: datum[index].product.template[0].remarks,
                                                        excelRead: datum[index].product.template[0].excelRead,
                                                        productId: datum[index].product.template[0].productId,
                                                      );
                                                      tempu.add(temp);

                                                      Productvalue pro = Productvalue(
                                                        productId: datum[index].product.productId,
                                                        productName: datum[index].product.productName,
                                                        productCode: datum[index].product.productCode,
                                                        description: datum[index].product.description,
                                                        templateId: datum[index].product.templateId,
                                                        quantity: datum[index].product.quantity,
                                                        status: datum[index].product.status,
                                                        createdBy: datum[index].product.createdBy,
                                                        updatedBy: datum[index].product.updatedBy,
                                                        createdDate: datum[index].product.createdDate,
                                                        updatedDate: datum[index].product.updatedDate,
                                                        flg: datum[index].product.flg,
                                                        remarks: datum[index].product.remarks,
                                                        timeRequired: datum[index].product.timeRequired,
                                                        macAddress: datum[index].product.macAddress,
                                                        template: tempu,
                                                      );
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
                                                      task.createdBy = datum[index].createdBy;
                                                      task.product = pro;


                                                      List<Testing> test = [];

                                                      for(int i = 0; i< datum[index].testing!.length; i++){
                                                        if(task.taskId == datum[index].testing![i].taskId){
                                                          Testing wlist = Testing(
                                                            testId: datum[index].testing![i].testId,
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
                                                            radiotype: datum[index].testing![i].radiotype,
                                                             testName: datum[index].testing![i].testName,
                                                             isOnline: datum[index].testing![i].isOnline,
                                                             type: datum[index].testing![i].type,
                                                             packetId: datum[index].testing![i].packetId,
                                                             pktType: datum[index].testing![i].pktType,
                                                             userEntry: datum[index].testing![i].userEntry,
                                                             wifiResult: datum[index].testing![i].wifiResult,
                                                             passCrieteria: datum[index].testing![i].passCrieteria,
                                                             remarks: datum[index].testing![i].remarks,
                                                            isSelected: false,
                                                          );
                                                          test.add(wlist);
                                                        }
                                                      }
                                                      var seen = Set<String>();
                                                      List<Testing> uniquelist = test.where((student) => seen.add(student.testStatus.toString())).toList();

                                                       uniquelist.sort((a, b) => a.testNumber!.compareTo(b.testNumber!));

                                                      task.testing = uniquelist;

                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  SecondTaskViewPage(tasks: task,tet: test,)));
                                                    });
                                                  },
                                                  child: TestTaskListItems(
                                                      Productname: datum[index].taskId.toString(),
                                                      productcode: datum[index].assignId.toString(),
                                                      quantity: datum[index].quantity.toString(),
                                                      assignedby: datum[index].createdBy.toString(),
                                                      status: datum[index].status.toString(),


                                                  ),
                                                );
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
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
      );
    }, error: (e, s) {
      print(e.toString());
      return Text(e.toString());
    }, loading: () {
      return CircularProgressIndicator();
    });
  }
}
