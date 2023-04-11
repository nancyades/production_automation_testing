import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/usermodel.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/noofpages/WorkOrder/workorderscreenpage.dart';

import '../../Helper/helper.dart';
import '../../Model/APIModel/workordermodel.dart';
import '../../Model/readexcel/readecel.dart';
import '../../Model/testmodel.dart';
import '../../Provider/testProvider.dart';
import '../WorkOrder/addworkorder.dart';


class AssignTask extends ConsumerStatefulWidget {
  const AssignTask({Key? key}) : super(key: key);

  @override
  ConsumerState<AssignTask> createState() => _AssignTaskState();
}


class _AssignTaskState extends ConsumerState<AssignTask> {
  var selectProduct;
  List<String> products = ['PSBE', '16 Zone', 'PSBE-E', '32 Zone'];

  var selectWorkorder;
  List<WorkorderModel> workorders = [];

  bool isSelected = false;
  bool isSelecteduser = false;
  List<FirstTest> ind = [];
  bool isValue = true;
  bool isValue1 = true;

  List<WorkorderList> wolst = [];

  List<WorkorderList> pro = [];

  bool isBugged = false;




  List productlist = [];

  List<FirstTest> testlist = [];

  int s = 0;

  TextEditingController controllerWorkorderid = TextEditingController();
  TextEditingController controllerQuantity = TextEditingController();
  TextEditingController controllerStartserial = TextEditingController();
  TextEditingController controllerEndserial = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();
  @override
  void initState(){
    Helper.classes = "TEST";
    print("GRIFFINDOR####");

  }

  @override
  Widget build(BuildContext context) {

    //print("GRIFFINDOR####");
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
        /*for (var i in data) {
          var productMap = {
            'workorderId': i.workorderId,
            'workorderCode': i.workorderCode,
          };
          productlist.add(productMap);
        }*/


      }

    /*  for(var workid in workorders){
        if(selectWorkorder == workid.workorderCode){
          for(var proname in workid.woList!){
            if(workid.workorderId == proname.workorder_id){
              WorkorderList wolst = WorkorderList(
                  product_id: proname.workorder_id,
                  product_name: proname.product_name.toString()
              );
              pro.add(wolst);
            }
          }
        }
      }*/
      return  Align(
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
          //color: Color(0xffa4cfed),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.65,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Assign",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton(
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
                                          pro.add(wolst);

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
                                        pro.add(wolst);

                                      }
                                    }
                                  }

                                }
                              }
                              selectProduct = pro[0].product_name.toString();




                              /* for (int i = 0; i < productlist.length; i++) {
                              if (productlist[i]['productName'] ==
                                  selectedProduct) {
                                controllerProductQuantity.text =
                                    productlist[i]['quantity'].toString();
                              }
                            }*/
                            /*  for(int j=0; j<data[0].woList!.length; j++){
                                if(selectWorkorder == data[0].woList![j].workorder_id){
                                  WorkorderList  wol = WorkorderList(
                                      workorder_id: data[0].woList![j].workorder_id
                                  );
                                  wolst.add(wol);
                                }

                              }*/



                            }


                         /* setState(() {
                            selectWorkorder = item.toString();
                            print("Index==>" + selectWorkorder);
                            //List<FirstClass> emptylist = [];
                          });*/
                        },
                      ),
                      DropdownButton(
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
                            if (isValue1 == true) {
                              isValue1 = false;
                            }
                            if (isValue1 == false) {
                              selectProduct = item.toString();

                                for(var workid in workorders){
                               if(selectWorkorder == workid.workorderCode) {
                                 for (var proname in workid.woList!) {
                                   if(workid.workorderId == proname.workorder_id){
                                     if (selectProduct == proname.product_name) {
                                       controllerWorkorderid.text = proname.workorder_id.toString();
                                       controllerQuantity.text  = proname.quantity.toString();
                                       controllerStartserial.text = proname.start_serial_no.toString();
                                       controllerEndserial.text  = proname.end_serial_no.toString();
                                       controllerStatus.text  = proname.status.toString();
                                     }
                                   }
                                 }
                               }
                                }


                            }
                          });


                   /*  setState(() {
                            selectProduct = item.toString();
                            print("Index==>" + selectProduct);
                            //List<FirstClass> emptylist = [];
                          });*/
                        },
                      ),
                    ],
                  ),
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
                                              isSelected = val!;
                                              if(val == true){
                                                Helper.classes = "TESSA";
                                                testlist = ind;
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

                   if(s == 0){
                     for (int i = 0; i < alltest!.length; i++) {
                       if (alltest[i].testtype != "" && alltest[i].testtype != "Title") {

                         FirstTest firstTest = FirstTest(
                             testtype: alltest[i].testtype.toString(),
                             testnumber: alltest[i].testnumber.toString(),
                             isSelected:  alltest[i].isSelected
                         );

                         ind.add(firstTest);
                       }
                     }
                     s++;
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
                                    itemCount: ind.length,
                                    //mModel.length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return getTaskItem(ind, index);
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
                                      //  Helper.selectuser == "Firstvalue";
                                        assignlist(ind);



                                      }),
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
                                      onPressed: () => null),
                                  ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("REASSIGN".toUpperCase(),
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
                                      onPressed: () => null),
                                ],
                              ),
                            )
                          ],
                        );
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
      return CircularProgressIndicator();
    });


  }

  assignlist(List<FirstTest> ind1){

    return  showDialog(
        context: context,
        builder: (c) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
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
                        }),
                  ],
                ),
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

                    TextButton(
                        child: const Text('Ok'),
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

  getTaskItem(List<FirstTest> mList, int index) {

    print("exited####");
    if(Helper.classes == "TEST"){
      mList[index].isSelected = false;
    }else if(Helper.classes == "TESSA"){
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
                        child: Text(ind[index].testtype.toString(),
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
                                    child: Text(ind[index].testnumber.toString(),
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
                              value: ind[index].isSelected,
                              onChanged: (val) {
                                print("object---------?> ${mList[index].isSelected} + ${[index]}");
                                print("val---------?> $val + $index");

                                if(ind[index].isSelected == true){
                                  setState(() {
                                    ind[index].isSelected = false;
                                    ind[index].isSelected = val;
                                    Helper.classes = "DEMO";

                                  });

                                }else if(mList[index].isSelected == false){
                                  setState(() {
                                    ind[index].isSelected = true;
                                    ind[index].isSelected = val;
                                    Helper.classes = "DEMO";



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
}
