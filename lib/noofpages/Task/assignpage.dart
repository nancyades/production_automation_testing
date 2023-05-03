import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/taskmodel.dart';
import 'package:production_automation_testing/Model/readexcelmodel.dart';
import 'package:production_automation_testing/Model/taskdetailsmodel.dart';

import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/Provider/post_provider/task_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/taskdetails_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/test_provider.dart';


import '../../Helper/helper.dart';
import '../../Model/APIModel/workordermodel.dart';
import '../../Model/readexcel/readecel.dart';

import '../../Provider/readexcelprovider/readexcel_provider.dart';

import '../WorkOrder/addworkorder.dart';


class AssignTask extends ConsumerStatefulWidget {
  TaskModel tasks;

   AssignTask({Key? key,  required this.tasks}) : super(key: key);

  @override
  ConsumerState<AssignTask> createState() => _AssignTaskState();
}


class _AssignTaskState extends ConsumerState<AssignTask> {
  var selectProduct;
  List<String> products = ['PSBE', '16 Zone', 'PSBE-E', '32 Zone'];
 bool alterIndex = false;
  var selectWorkorder;
  List<WorkorderModel> workorders = [];

  bool isSelected = false;

  bool isSelct = true;

  bool isSelecteduser = false;
  List<ExcelRead> ind = [];
  List<ExcelRead> readexcel = [];
  List<ExcelRead> readtest = [];
  bool isValue = true;
  bool isValue1 = true;

  List<WorkorderList> wolst = [];

  List<WorkorderList> pro = [];
  List<WorkorderList> prolist = [];

  bool isBugged = false;






  List<ExcelRead> testlist_1 = [];

  int s = 0;
  bool vary = false;
  int e =0;

  TextEditingController controllerWorkorderid = TextEditingController();
  TextEditingController controllerQuantity = TextEditingController();
  TextEditingController controllerStartserial = TextEditingController();
  TextEditingController controllerEndserial = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();

  var product_id;

  int? ucer_id;

  int? wolist_id;

  bool unknow = false;

  bool drop = false;

  List<ExcelRead>? testlist;

  List<ExcelRead> gettest =[];




  @override
  void initState(){
    Helper.classes = "TEST";

  Helper.ischecked = "passvalue";

  }



  @override
  Widget build(BuildContext context) {
   /* if (Helper.editvalue == "editedvalue"){
      if (widget.tasks != null) {
        controllerWorkorderid.text = widget.tasks.wolId!.toString();
        controllerQuantity.text = widget.tasks.quantity!.toString();
        controllerStartserial.text = widget.tasks.startSerialNo!.toString();
        controllerEndserial.text = widget.tasks.endSerialNo.toString();
        controllerStatus.text = widget.tasks.status!;
      }


    }
*/

    if(Helper.ischecked == "passvalue"){

      isSelct= widget.tasks.flg == 1 ? true :false;
    }




    return ref.watch(getWorkorderNotifier).when(data: (data){
      if (isValue == true) {
        selectWorkorder = data[0].workorderCode.toString();
      }
      if (isValue1 == true) {
        selectProduct = data[0].woList![0].product_name.toString();
      }
      if (workorders.length == 0) {

        for (int i = 0; i < data.length; i++) {
          for(int j=0; j<data[i].woList!.length; j++){
            if(data[i].workorderId == data[i].woList![j].workorder_id){
              WorkorderList  wol = WorkorderList(
                 id: data[i].woList![j].id,
                  workorder_id: data[i].woList![j].workorder_id,
                  product_id: data[i].woList![j].product_id,
                  product_name: data[i].woList![j].product_name,
                  quantity: data[i].woList![j].quantity,
                  start_serial_no: data[i].woList![j].start_serial_no,
                  end_serial_no: data[i].woList![j].end_serial_no,
                  status: data[i].woList![j].status,
                  testing_status: data[i].woList![j].testing_status,
                  start_date: data[i].woList![j].start_date,
                  end_date: data[i].woList![j].end_date,
                  flg: data[i].woList![j].flg,

              );
              wolst.add(wol);
            }

          }
          WorkorderModel val = WorkorderModel(
              workorderId: data[i].workorderId,
              workorderCode: data[i].workorderCode.toString(),
              quantity: data[i].quantity,
              startSerialNo: data[i].startSerialNo.toString(),
              endSerialNo: data[i].endSerialNo.toString(),
              status: data[i].status.toString(),
              createdBy: data[i].createdBy,
              updatedBy: data[i].updatedBy,
              createdDate: data[i].createdDate.toString(),
              updatedDate: data[i].updatedDate.toString(),
              flg: data[i].flg,
              remarks: data[i].remarks.toString(),
              woList: wolst
          );

          workorders.add(val);
        }

      }


      return ref.watch(addTaskdetailsNotifier).id.when(data: (data){
        if (Helper.editvalue == "editedvalue"){
         for(TaskDetails problems in data){
            controllerWorkorderid.text = problems.workorderId.toString();
            controllerQuantity.text =  problems.quantity.toString();
            controllerStartserial.text = problems.startSerialNo.toString();
            controllerEndserial.text =  problems.endSerialNo.toString();
            controllerStatus.text = problems.status.toString();


          }
        }
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.65,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Task",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ),

                  (Helper.dropDown == "HIDE")
                      ? Column(
                    children: [

                    ],
                  )
                      :   Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                children: [
                                  Text("Workorder",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 22.0),
                                  child: SizedBox(
                                    height: 35,
                                    child:DropdownButton(
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 25.0),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                      items: workorders
                                          .map<DropdownMenuItem<String>>((WorkorderModel setlist) {
                                        return DropdownMenuItem<String>(
                                          value: setlist.workorderCode,
                                          child: Text(setlist.workorderCode.toString()),
                                        );
                                      }).toList(),
                                      value: selectWorkorder,
                                      onChanged: (item) {

                                        ref.read(dropDownChange.notifier).state = !ref.watch(dropDownChange);
                                        if (isValue == true) {
                                          isValue = false;
                                        }
                                        if (isValue == false) {
                                          selectWorkorder = item.toString();


                                          for(var workid in workorders){
                                            if(selectWorkorder == workid.workorderCode){
                                              if(pro.isNotEmpty){
                                                pro.clear();
                                                if(pro.isEmpty){
                                                  for(var proname in workid.woList!){
                                                    if(workid.workorderId == proname.workorder_id){
                                                      WorkorderList wolst = WorkorderList(
                                                        workorder_id: proname.workorder_id,
                                                        product_id: proname.product_id,
                                                        product_name: proname.product_name.toString(),
                                                        quantity: proname.product_id,
                                                        start_serial_no: proname.start_serial_no.toString(),
                                                        end_serial_no: proname.end_serial_no.toString(),
                                                        status: proname.status.toString(),
                                                        testing_status: proname.testing_status.toString(),
                                                        start_date: proname.start_date.toString(),
                                                        end_date: proname.end_date.toString(),
                                                        flg: proname.flg,
                                                      );
                                                      if(pro.isEmpty){
                                                        pro.add(wolst);

                                                      }if(pro[0].product_name.toString() != wolst.product_name){
                                                        pro.add(wolst);
                                                      }else{

                                                      }

                                                      pro.toSet().toList();

                                                    }
                                                  }
                                                }
                                              } else {
                                                for(var proname in workid.woList!){
                                                  if(workid.workorderId == proname.workorder_id){
                                                    WorkorderList wolst = WorkorderList(
                                                      workorder_id: proname.workorder_id,
                                                      product_id: proname.product_id,
                                                      product_name: proname.product_name.toString(),
                                                      quantity: proname.product_id,
                                                      start_serial_no: proname.start_serial_no.toString(),
                                                      end_serial_no: proname.end_serial_no.toString(),
                                                      status: proname.status.toString(),
                                                      testing_status: proname.testing_status.toString(),
                                                      start_date: proname.start_date.toString(),
                                                      end_date: proname.end_date.toString(),
                                                      flg: proname.flg,
                                                    );
                                                    if(pro.isEmpty){
                                                      pro.add(wolst);

                                                    }if(pro[0].product_name.toString() != wolst.product_name){
                                                      pro.add(wolst);
                                                    }else{
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                          isValue1 = false;
                                          selectProduct = pro[0].product_name.toString();
                                          unknow = true;

                                        }
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
                        child: Visibility(
                          visible: unknow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Product",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: SizedBox(
                                      height: 35,
                                      child:  DropdownButton(
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 25.0),
                                          child: Icon(Icons.keyboard_arrow_down),
                                        ),
                                        items: pro.map<DropdownMenuItem<String>>((WorkorderList setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist.product_name,
                                            child: Text(setlist.product_name.toString()),
                                          );
                                        }).toList(),
                                        value: selectProduct,
                                        onChanged: (item) {
                                          setState(() {
                                            alterIndex = true;
                                            vary = false;
                                            Helper.editvalue == "noteditedvalue";
                                            if (isValue1 == true) {
                                              isValue1 = false;
                                            }
                                            if (isValue1 == false) {
                                              selectProduct = item.toString();

                                              Helper.editvalue = "noteditedvalue";

                                              for(var workid in workorders){
                                                if(selectWorkorder == workid.workorderCode) {
                                                  for (var proname in workid.woList!) {
                                                    if(workid.workorderId == proname.workorder_id){
                                                      if (selectProduct == proname.product_name) {
                                                        wolist_id = proname.id!;
                                                        product_id = proname.product_id;
                                                        controllerWorkorderid.text = proname.workorder_id.toString();
                                                        controllerQuantity.text  = proname.quantity.toString();
                                                        controllerStartserial.text = proname.start_serial_no.toString();
                                                        controllerEndserial.text  = proname.end_serial_no.toString();
                                                        controllerStatus.text  = proname.status.toString();
                                                        print("product_id----------> ${product_id}");
                                                      }
                                                    }
                                                  }
                                                }
                                              }

                                              ref.read(readexcelNotifier.notifier).readexcel(product_id);
                                              Helper.cleartemplate = true;

                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Workorder Id",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0,),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerWorkorderid,
                                          decoration: InputDecoration(
                                            /*  border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
                                              //hintText: "Workorder Code",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Quantity",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerQuantity,
                                          decoration: InputDecoration(
                                            /* border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
                                              //hintText: "Quantity",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Start Serial No",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerStartserial,
                                          decoration: InputDecoration(
                                            /*border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                              // hintText: "Start Serial No",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("End Serial No",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerEndserial,
                                          decoration: InputDecoration(
                                            /* border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                              //hintText: "End Serial No",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Status",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerStatus,
                                          decoration: InputDecoration(
                                            /* border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                              //hintText: "Status",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  (){
                    if(Helper.dropDown == "HIDE"){
                      return   Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Card(
                              color: Color(0xff8fcceb),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text("TASK TITLE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text("TASK ID",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                    ),
                                  ),
                                 /* Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Center(
                                              child: Text("SELECT ALL",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black))),
                                          Center(
                                              child: Checkbox(
                                                value: isSelected,
                                                onChanged: (val) {
                                                  setState(() {
                                                    isSelected = val!;
                                                    if(val == true){
                                                      Helper.classes = "TESSA1";
                                                      gettest = testlist!;
                                                    }
                                                    else{
                                                      Helper.classes = "TEST1";


                                                    }


                                                  });

                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else{
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Card(
                              color: Color(0xff8fcceb),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text("TASK TITLE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text("TASK ID",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Center(
                                              child: Text("SELECT ALL",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black))),
                                          Center(
                                              child: Checkbox(
                                                value: isSelected,
                                                onChanged: (val) {
                                                  setState(() {
                                                    Helper.cleartemplate = false;
                                                    isSelected = val!;
                                                    if(val == true){
                                                      Helper.classes = "TESSA";
                                                      // testlist_1 = readexcel;
                                                      // readtest = readexcel;
                                                      gettest = testlist!;


                                                    }
                                                    else{
                                                      Helper.classes = "TEST";


                                                    }


                                                  });

                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }(),



                  Consumer(
                      builder: (context, ref, child) {
                     if(Helper.dropDown == "HIDE") {

                        return Column(
                          children: [
                            SizedBox(
                              height: 300,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Color(0xffcbdff2),
                                elevation: 10,
                                child: ListView.builder(
                                    itemCount:  widget.tasks.testing!.length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return getTaskItem_1(widget.tasks.testing!, index);
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isSelct,
                                        onChanged: (val) {
                                          print("isselect-----> $isSelct");
                                          print("value-----> $val");
                                          setState(() {
                                            Helper.ischecked = "isactivevalue";

                                            isSelct = val!;


                                          });

                                        },
                                      ),
                                      Text("isActive" ,style: TextStyle(fontSize: 14, color: Colors.black)),
                                    ],
                                  ),

                                  ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("EDIT TASK".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                      style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(
                                              Colors.white),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(Colors.red),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side: BorderSide(color: Colors.red)))),
                                      onPressed: () {

                                        ref.read(updateTaskNotifier.notifier).updatetTask({
                                          "task_id": widget.tasks.taskId,
                                          "user_id": widget.tasks.userId,
                                          "assign_id": widget.tasks.assignId,
                                          "wol_id": widget.tasks.wolId,
                                          "quantity": widget.tasks.quantity,
                                          "start_serial_no": widget.tasks.startSerialNo,
                                          "end_serial_no": widget.tasks.endSerialNo,
                                          "status": widget.tasks.status,
                                          "testing_status": widget.tasks.testingStatus,
                                          "start_date": widget.tasks.startDate,
                                          "end_date": widget.tasks.endDate,
                                          "created_by": Helper.shareduserid,
                                          "updated_by": 0,
                                          "created_date": widget.tasks.createdDate,
                                          "updated_date": widget.tasks.updatedDate,
                                          "flg": widget.tasks.flg,
                                          "rating": widget.tasks.rating,
                                          "workorder_id": widget.tasks.workorderid,
                                          "product_id": widget.tasks.productid,
                                          "name": widget.tasks.username

                                        });


                                      })


                                ],
                              ),
                            )
                          ],
                        );
                        }else{
                       return ref.watch(readexcelNotifier).id.when(data: (data){
                         print(data);

                         if(Helper.cleartemplate == true){
                           testlist = data[0].template![0].excelread;





                           s = 0 ;
                           if(s == 0 &&  vary == false){
                             readexcel.clear();
                             e = 0;
                             for (int i = 0; i < testlist!.length; i++) {
                               if(readexcel.isEmpty){
                                 ExcelRead read = ExcelRead(
                                     testType: testlist![i].testType.toString(),
                                     testNumber: testlist![i].testNumber.toString(),
                                     isOnline: testlist![i].isOnline.toString(),
                                     isSelected:  testlist![i].isSelected
                                 );
                                 readexcel.add(read);
                               }else if(readexcel.isNotEmpty){
                                 if(testlist![i].testType != readexcel[e].testType)
                                 {
                                   ExcelRead read = ExcelRead(
                                       testType: testlist![i].testType.toString(),
                                       testNumber: testlist![i].testNumber.toString(),
                                       isOnline: testlist![i].isOnline.toString(),
                                       isSelected:  testlist![i].isSelected
                                   );
                                   readexcel.add(read);
                                   e++;
                                 }
                               }

                             }
                             s++;
                           }
                         }

                         return Column(
                           children: [
                             SizedBox(
                               height: 300,
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),
                                 color: Color(0xffcbdff2),
                                 elevation: 10,
                                 child: ListView.builder(
                                     itemCount: Helper.dropDown == "HIDE"? widget.tasks.testing!.length :readexcel.length,
                                     itemBuilder: (BuildContext ctxt, int index) {

                                       return  readexcel.isEmpty ? safeLog() : getTaskItem(readexcel, index);
                                     }),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(15.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   ElevatedButton(
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text("ADD TASK ".toUpperCase(),
                                             style: TextStyle(fontSize: 14)),
                                       ),
                                       style: ButtonStyle(
                                           foregroundColor: MaterialStateProperty.all<Color>(
                                               Colors.white),
                                           backgroundColor:
                                           MaterialStateProperty.all<Color>(Colors.red),
                                           shape: MaterialStateProperty.all<
                                               RoundedRectangleBorder>(
                                               RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(8.0),
                                                   side: BorderSide(color: Colors.red)))),
                                       onPressed: (){
                                         setState(() {
                                           isBugged = true;


                                         });

                                         assignlist(readexcel);




                                       })

                                 ],
                               ),
                             )
                           ],
                         );
                       }, error: (r,s){
                         return Text(r.toString());
                       }, loading: (){
                         return Center(child: CircularProgressIndicator());
                       });
                     }



                      }
                  )

                ],
              ),
            ),
          ),
        );

      }, error: (e,s){
        return Text(e.toString());
      }, loading: (){
        return Center(child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.65,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Task",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ),

                  (Helper.dropDown == "HIDE")
                      ? Column(
                    children: [

                    ],
                  )
                      :   Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                children: [
                                  Text("Workorder",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 22.0),
                                  child: SizedBox(
                                    height: 35,
                                    child:DropdownButton(
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 25.0),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                      items: workorders
                                          .map<DropdownMenuItem<String>>((WorkorderModel setlist) {
                                        return DropdownMenuItem<String>(
                                          value: setlist.workorderCode,
                                          child: Text(setlist.workorderCode.toString()),
                                        );
                                      }).toList(),
                                      value: selectWorkorder,
                                      onChanged: (item) {

                                        ref.read(dropDownChange.notifier).state = !ref.watch(dropDownChange);
                                        if (isValue == true) {
                                          isValue = false;
                                        }
                                        if (isValue == false) {
                                          selectWorkorder = item.toString();


                                          for(var workid in workorders){
                                            if(selectWorkorder == workid.workorderCode){
                                              if(pro.isNotEmpty){
                                                pro.clear();
                                                if(pro.isEmpty){
                                                  for(var proname in workid.woList!){
                                                    if(workid.workorderId == proname.workorder_id){
                                                      WorkorderList wolst = WorkorderList(
                                                        workorder_id: proname.workorder_id,
                                                        product_id: proname.product_id,
                                                        product_name: proname.product_name.toString(),
                                                        quantity: proname.product_id,
                                                        start_serial_no: proname.start_serial_no.toString(),
                                                        end_serial_no: proname.end_serial_no.toString(),
                                                        status: proname.status.toString(),
                                                        testing_status: proname.testing_status.toString(),
                                                        start_date: proname.start_date.toString(),
                                                        end_date: proname.end_date.toString(),
                                                        flg: proname.flg,
                                                      );
                                                      if(pro.isEmpty){
                                                        pro.add(wolst);

                                                      }if(pro[0].product_name.toString() != wolst.product_name){
                                                        pro.add(wolst);
                                                      }else{

                                                      }

                                                      pro.toSet().toList();

                                                    }
                                                  }
                                                }
                                              } else {
                                                for(var proname in workid.woList!){
                                                  if(workid.workorderId == proname.workorder_id){
                                                    WorkorderList wolst = WorkorderList(
                                                      workorder_id: proname.workorder_id,
                                                      product_id: proname.product_id,
                                                      product_name: proname.product_name.toString(),
                                                      quantity: proname.product_id,
                                                      start_serial_no: proname.start_serial_no.toString(),
                                                      end_serial_no: proname.end_serial_no.toString(),
                                                      status: proname.status.toString(),
                                                      testing_status: proname.testing_status.toString(),
                                                      start_date: proname.start_date.toString(),
                                                      end_date: proname.end_date.toString(),
                                                      flg: proname.flg,
                                                    );
                                                    if(pro.isEmpty){
                                                      pro.add(wolst);

                                                    }if(pro[0].product_name.toString() != wolst.product_name){
                                                      pro.add(wolst);
                                                    }else{
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                          isValue1 = false;
                                          selectProduct = pro[0].product_name.toString();
                                          unknow = true;

                                        }
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
                        child: Visibility(
                          visible: unknow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Product",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: SizedBox(
                                      height: 35,
                                      child:  DropdownButton(
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 25.0),
                                          child: Icon(Icons.keyboard_arrow_down),
                                        ),
                                        items: pro.map<DropdownMenuItem<String>>((WorkorderList setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist.product_name,
                                            child: Text(setlist.product_name.toString()),
                                          );
                                        }).toList(),
                                        value: selectProduct,
                                        onChanged: (item) {
                                          setState(() {
                                            alterIndex = true;
                                            vary = false;
                                            Helper.editvalue == "noteditedvalue";
                                            if (isValue1 == true) {
                                              isValue1 = false;
                                            }
                                            if (isValue1 == false) {
                                              selectProduct = item.toString();

                                              Helper.editvalue = "noteditedvalue";

                                              for(var workid in workorders){
                                                if(selectWorkorder == workid.workorderCode) {
                                                  for (var proname in workid.woList!) {
                                                    if(workid.workorderId == proname.workorder_id){
                                                      if (selectProduct == proname.product_name) {
                                                        wolist_id = proname.id!;
                                                        product_id = proname.product_id;
                                                        controllerWorkorderid.text = proname.workorder_id.toString();
                                                        controllerQuantity.text  = proname.quantity.toString();
                                                        controllerStartserial.text = proname.start_serial_no.toString();
                                                        controllerEndserial.text  = proname.end_serial_no.toString();
                                                        controllerStatus.text  = proname.status.toString();
                                                        print("product_id----------> ${product_id}");
                                                      }
                                                    }
                                                  }
                                                }
                                              }

                                              ref.read(readexcelNotifier.notifier).readexcel(product_id);
                                              Helper.cleartemplate = true;

                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Workorder Id",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0,),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerWorkorderid,
                                          decoration: InputDecoration(
                                            /*  border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
                                              //hintText: "Workorder Code",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Quantity",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerQuantity,
                                          decoration: InputDecoration(
                                            /* border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
                                              //hintText: "Quantity",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Start Serial No",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerStartserial,
                                          decoration: InputDecoration(
                                            /*border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                              // hintText: "Start Serial No",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("End Serial No",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerEndserial,
                                          decoration: InputDecoration(
                                            /* border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                              //hintText: "End Serial No",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Status",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: TextField(
                                          controller: controllerStatus,
                                          decoration: InputDecoration(
                                            /* border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),*/
                                              filled: true,
                                              hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                              //hintText: "Status",
                                              fillColor: Colors.white70),
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0,color: Colors.black ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          color: Color(0xff8fcceb),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text("TASK TITLE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.black))),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text("TASK ID",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.black))),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Center(
                                          child: Text("SELECT ALL",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                      Center(
                                          child: Checkbox(
                                            value: isSelected,
                                            onChanged: (val) {
                                              setState(() {
                                                Helper.cleartemplate = false;
                                                isSelected = val!;
                                                if(val == true){
                                                  Helper.classes = "TESSA";
                                                  // testlist_1 = readexcel;
                                                  // readtest = readexcel;
                                                  gettest = testlist!;


                                                }
                                                else{
                                                  Helper.classes = "TEST";


                                                }


                                              });

                                            },
                                          )),
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


                  Consumer(
                      builder: (context, ref, child) {
                        List<FirstTest>? alltest = ref.watch(getallestNotifier).value;

                        return  ref.watch(readexcelNotifier).id.when(data: (data){
                          print(data);

                          if(Helper.cleartemplate == true){
                            testlist = data[0].template![0].excelread;





                            s = 0 ;
                            if(s == 0 &&  vary == false){
                              readexcel.clear();
                              e = 0;
                              for (int i = 0; i < testlist!.length; i++) {
                                if(readexcel.isEmpty){
                                  ExcelRead read = ExcelRead(
                                      testType: testlist![i].testType.toString(),
                                      testNumber: testlist![i].testNumber.toString(),
                                      isOnline: testlist![i].isOnline.toString(),
                                      isSelected:  testlist![i].isSelected
                                  );
                                  readexcel.add(read);
                                }else if(readexcel.isNotEmpty){
                                  if(testlist![i].testType != readexcel[e].testType)
                                  {
                                    ExcelRead read = ExcelRead(
                                        testType: testlist![i].testType.toString(),
                                        testNumber: testlist![i].testNumber.toString(),
                                        isOnline: testlist![i].isOnline.toString(),
                                        isSelected:  testlist![i].isSelected
                                    );
                                    readexcel.add(read);
                                    e++;
                                  }
                                }

                              }
                              s++;
                            }
                          }

                          return Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Color(0xffcbdff2),
                                  elevation: 10,
                                  child: ListView.builder(
                                      itemCount: Helper.dropDown == "HIDE"? widget.tasks.testing!.length :readexcel.length,
                                      itemBuilder: (BuildContext ctxt, int index) {

                                        return Helper.dropDown == "HIDE"? getTaskItem_1(widget.tasks.testing!, index) : readexcel.isEmpty ? safeLog() : getTaskItem(readexcel, index);
                                      }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Helper.dropDown == "SHOW" ?
                                    ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("ADD TASK ".toUpperCase(),
                                              style: TextStyle(fontSize: 14)),
                                        ),
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all<Color>(
                                                Colors.white),
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(Colors.red),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    side: BorderSide(color: Colors.red)))),
                                        onPressed: (){
                                          setState(() {
                                            isBugged = true;


                                          });

                                          assignlist(readexcel);




                                        })
                                        : ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("EDIT TASK".toUpperCase(),
                                              style: TextStyle(fontSize: 14)),
                                        ),
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all<Color>(
                                                Colors.white),
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(Colors.red),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    side: BorderSide(color: Colors.red)))),
                                        onPressed: () => null)


                                  ],
                                ),
                              )
                            ],
                          );
                        }, error: (r,s){
                          return Text(r.toString());
                        }, loading: (){
                          return Center(child: CircularProgressIndicator());
                        });


                      }
                  )

                ],
              ),
            ),
          ),
        ));
      });

    }, error: (e,s){
      return Text(e.toString());
    }, loading: (){
      return CircularProgressIndicator();
    });


  }

  assignlist(List<ExcelRead> ind1){

    return  showDialog(
        context: context,
        builder: (c) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TEST USER'),
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("PROCEED ".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.red.shade300)))),
                          onPressed: (){


                            ref.read(addTaskNotifier.notifier).addTask({
                              //"task_id": 2,
                              "user_id": ucer_id,
                              "assign_id": Helper.shareduserid,
                              "wol_id": wolist_id,
                              "quantity": int.parse(controllerQuantity.text),
                              "start_serial_no": controllerStartserial.text,
                              "end_serial_no": controllerEndserial.text,
                              "status": "open",
                              "testing_status": "open",
                              "start_date": null,
                              "end_date": null,
                              "created_by": Helper.shareduserid,
                              "updated_by": 0,
                              "created_date": null,
                              "updated_date": null,
                              "flg": 1,
                              "rating": 2
                            });

                            getconfirmationpopup();
                            Helper.classes = "TEST";



                          //  Navigator.pop(context);
                          }),

                    ],
                  ),
                  TextField(
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
                      onChanged: (String query) {

                      }
                    // SearchWorkorders,
                  ),
                ],
              ),
              //content: Text("msg"),
              actions: [
                Column(
                  children: [
                    Container(
                      width: 500,
                      height: 350,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return ref.watch(getUserNotifier).when(data: (data){
                            var test_user =  data.where((element) => element.role == "Test User").toList();
                            print(test_user);

                            return ListView.builder(
                                shrinkWrap: true,
                                controller: ScrollController(),
                                itemCount: test_user.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  if(isBugged == true)
                                    {
                                      test_user[index].isSelecteduser = false;
                                    }

                                  return Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.red,
                                            child: ClipRRect(
                                              child: Image.asset("assets/images/profile.jpg"),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(test_user[index].name.toString()),
                                                Text(test_user[index].empId.toString()),
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Checkbox(
                                                  value: test_user[index].isSelecteduser,
                                                  onChanged: (value) {
                                                    setState((){
                                                      test_user[index].Selection(value!);
                                                      print("test_user ----> ${test_user[index].isSelecteduser}");
                                                      isBugged = false;
                                                      print("userid---------> ${test_user[index].userId}");
                                                      print("assigid---------> ${Helper.shareduserid}");

                                                      ucer_id = test_user[index].userId;


                                                    });

                                                  }))),
                                    ],
                                  );
                                });
                          }, error: (e,s){
                            return Text(e.toString());
                          }, loading: (){
                            return Center(child: CircularProgressIndicator());
                          });

                        }
                      ),



                    ),

                  ],
                ),
              ],
            );
          }
        ));
  }

  Widget safeLog(){
    return Text("");
  }

  getconfirmationpopup(){
    return  showDialog(
        context: context,
        builder: (c) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Text("Are You Sure?"),
                actions: [


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                             for(int i=0;i<gettest.length; i++){
                            ref.read(addTestNotifier.notifier).addTest({
                              "task_id": int.parse(Helper.task_id.toString().split('-')[0]),
                              "test_stage": 0,
                              "test_status": gettest[i].testType,
                              "pass": 0,
                              "fail": 0,
                              "status": "Open",
                              "flg": 1,
                              "mac_address": null,
                              "test_type": gettest[i].isOnline == "0" ? "Offline" : "Online" ,
                              "test_date": null,
                              "hours_taken": 0,
                              "test_number": gettest[i].testNumber
                            });
                          }

                            Navigator.pop(context);
                          }),
                      TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          }),

                    ],
                  ),
                ],
              );
            }
        ));
  }
  getTaskItem(List<ExcelRead> mList, int index) {

    if(Helper.classes == "TEST" && readexcel.isNotEmpty){
      mList[index].isSelected = false;
    }else if(Helper.classes == "TESSA"&& readexcel.isNotEmpty ){
      mList[index].isSelected = true;
    }
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(readexcel[index].testType.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                                color: Colors.black))),
                  ),
                ),
                  Expanded(
                    flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(readexcel[index].testNumber.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0,
                                            color: Colors.black))),
                              ),
                            ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        Center(
                            child: Checkbox(
                              value: readexcel[index].isSelected,
                              onChanged: (val) {


                                if(readexcel[index].isSelected == true){
                                  setState(() {
                                    readexcel[index].isSelected = false;
                                    readexcel[index].isSelected = val;
                                    Helper.classes = "DEMO";
                                    vary =true;


                                    removeAnItem(index);


                                  });

                                }else if(mList[index].isSelected == false){
                                  setState(() {
                                    readexcel[index].isSelected = true;
                                    readexcel[index].isSelected = val;
                                    Helper.classes = "DEMO";
                                    vary =true;


                                    var teststage = readexcel[index].testType.toString();
                                    var test_type = readexcel[index].isOnline.toString();

                                    print("teststage---------> ${readexcel[index].testType.toString()}");
                                    print("testtype---------> ${readexcel[index].isOnline.toString()}");

                                    ExcelRead read = ExcelRead(
                                        testType: readexcel[index].testType.toString(),
                                        isOnline: readexcel[index].isOnline.toString()

                                    );
                                    print(index);


                                    readtest.add(read);
                                    print("list of test----------> ${readtest}");


                                    int w = 0;

                                      for(int i =0; i<testlist!.length;i++){

                                        if(readtest[index].testType == testlist![w].testType){
                                          ExcelRead read = ExcelRead(
                                              testType: testlist![w].testType.toString(),
                                              testNumber: testlist![w].testNumber.toString(),
                                              isOnline: testlist![w].isOnline.toString()
                                          );
                                          gettest.add(read);

                                        }
                                        w++;
                                      }






                                  });
                                }


                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ));
  }

  getTaskItem_1(List<Testing> mList, int index) {

    if(Helper.classes == "TEST1" && readexcel.isNotEmpty){
      mList[index].isSelected = false;
    }else if(Helper.classes == "TESSA1"&& readexcel.isNotEmpty ){
      mList[index].isSelected = true;
    }
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(mList[index].testStatus.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0,
                              color: Colors.black))),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(mList[index].testNumber.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.black))),
                ),
              ),
             /* Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Center(
                          child: Checkbox(
                            value: mList[index].isSelected,
                            onChanged: (val) {


                              if(mList[index].isSelected == true){
                                setState(() {
                                  mList[index].isSelected = false;
                                  mList[index].isSelected = val;
                                  Helper.classes = "DEMO1";
                                  vary =true;


                                  removeAnItem(index);


                                });

                              }else if(mList[index].isSelected == false){
                                setState(() {
                                  mList[index].isSelected = true;
                                  mList[index].isSelected = val;
                                  Helper.classes = "DEMO1";
                                  vary =true;


                                  var teststage = readexcel[index].testType.toString();
                                  var test_type = readexcel[index].isOnline.toString();

                                  print("teststage---------> ${readexcel[index].testType.toString()}");
                                  print("testtype---------> ${readexcel[index].isOnline.toString()}");

                                  ExcelRead read = ExcelRead(
                                      testType: readexcel[index].testType.toString(),
                                      isOnline: readexcel[index].isOnline.toString()

                                  );
                                  print(index);


                                  readtest.add(read);
                                  print("list of test----------> ${readtest}");


                              //  int w = 0;
                              //  for(int i =0; i<testlist!.length;i++){
                              //    if(readtest[index].testType == testlist![w].testType){
                              //      ExcelRead read = ExcelRead(
                              //          testType: testlist![w].testType.toString(),
                              //          testNumber: testlist![w].testNumber.toString(),
                              //          isOnline: testlist![w].isOnline.toString()
                              //      );
                              //      gettest.add(read);

                              //    }
                              //    w++;
                              //  }






                                });
                              }


                            },
                          )),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ));
  }

  void removeAnItem(int index){
    readtest.removeAt(index);

  }
}
