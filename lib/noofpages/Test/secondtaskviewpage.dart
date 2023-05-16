import 'package:flutter/material.dart';
import 'package:production_automation_testing/Provider/post_provider/tasklist_provider.dart';

import 'package:production_automation_testing/noofpages/Test/testpage.dart';
import '../../Helper/helper.dart';
import '../../HomeScreen.dart';
import '../../Model/APIModel/taskmodel.dart';
import '../../Model/readexcel/readecel.dart';
import '../../NavigationBar/src/company_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../NavigationBar/src/testuser.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/generalProvider.dart';



class SecondTaskViewPage extends ConsumerStatefulWidget {
  TaskModel tasks;
  List<Testing>? tet;
   SecondTaskViewPage({Key? key, required this.tasks, this.tet}) : super(key: key);

  @override
  ConsumerState<SecondTaskViewPage> createState() => _SecondTaskViewPageState();
}

class _SecondTaskViewPageState extends ConsumerState<SecondTaskViewPage> {
  List<FirstTest>  testtypevale = [];
  List<Testtype>  testvale = [];
  var fontSize, height;
  bool isallSelected = false;

  List<dynamic> testindex = [];

  bool change = false;


  List<Testing> heading =  [];

  List<Testing>  teststate = [];

  String? testType;






  @override
  void initState(){
    //ref.read(gettesttypeNotifier);
    Helper.classes = "TEST";

  }



  @override
  Widget build(BuildContext context) {
    fontSize = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;





    List<FirstTest>? alltest = ref.watch(getallestNotifier).value;

    if (alltest == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    List<FirstTest> ind = [];



    if(Helper.classes == "TEST"){
      for (int i = 0; i < alltest.length; i++) {
        if (alltest[i].testtype != "" && alltest[i].testtype != "Title") {

          FirstTest firstTest = FirstTest(
              testtype: alltest[i].testtype.toString(),
              isSelected:  alltest[i].isSelected
          );
          ind.add(firstTest);
          testtypevale = ind;
        }
      }

    }



   return ref.watch(getTaskListNotifier).id.when(data: (data){



    /*  for(int i = 0; i< datum[index].testing!.length; i++){
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
      List<Testing> uniquelist = test.where((student) => seen.add(student.testStatus.toString())).toList();*/


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
                            // color: Color(0xFFc6f5d7),
                            elevation: 70,
                            child: Column(
                              children: [
                                Container(
                                  height: 170.0,
                                  width: MediaQuery.of(context).size.width,
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Product Name : ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14.0,
                                                        color: Colors.red
                                                    ),
                                                  ),
                                                  Text(widget.tasks.product!.productName.toString(), style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.black
                                                  ),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Product code : ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14.0,
                                                        color: Colors.red
                                                    ),
                                                  ),
                                                  Text(widget.tasks.product!.productCode.toString(), style: TextStyle(
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
                                                  Text(widget.tasks.quantity.toString(), style: TextStyle(
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
                                                  Text(widget.tasks.status.toString(), style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.black
                                                  ),),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Template Name : ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14.0,
                                                        color: Colors.red
                                                    ),
                                                  ),
                                                  Text(widget.tasks.product!.template![0].templateName.toString(), style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.black
                                                  ),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Template code : ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14.0,
                                                        color: Colors.red
                                                    ),
                                                  ),
                                                  Text(widget.tasks.product!.template![0].templateId.toString(), style: TextStyle(
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
                                                  Text(widget.tasks.product!.template![0].createdBy.toString(), style: TextStyle(
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
                                                  Text(widget.tasks.createdDate.toString().split('T')[0], style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: Colors.black
                                                  ),),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 32.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Product Details",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: ElevatedButton(
                                            child: Text("Begin Test".toUpperCase(),
                                                style: TextStyle(fontSize: 14)),
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(
                                                    Colors.white),
                                                backgroundColor: MaterialStateProperty.all<Color>(
                                                    Colors.black),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: Colors.black)))),
                                            onPressed: () {
                                              if(Helper.classes == "TEST"){
                                                final snackBar = SnackBar(
                                                  content: const Text('please select atleast one field'),
                                                  backgroundColor: (Colors.black),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              }
                                              else{
                                               /* for(int i=0; i<testindex.length; i++){
                                                  for(int j=0; j<widget.tasks.testing!.length; j++){
                                                    if(testindex[i].toString() == widget.tasks.testing![j].testStatus.toString()){
                                                      Testing  st = Testing(
                                                        testStatus: widget.tasks.testing![j].testStatus.toString(),
                                                        testStage:  widget.tasks.testing![j].testStage
                                                      );
                                                      teststate.add(st);
                                                      final snackBar = SnackBar(
                                                        content:  Text(
                                                        "${ st.testStatus!.toString() + ":"  + st.testStage.toString() }"),
                                                        backgroundColor:
                                                        (Colors.black),
                                                      );
                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                    }
                                                  }
                                                }*/


                                                  getteststagepopup();



                                              }


                                             /* else{
                                                ref.read(testStartedProvider.notifier).state = false;
                                                Navigator.push(
                                                    context, MaterialPageRoute(builder: (context) => TestScreenPage(testtype: [testindex],testlist: widget.tet, tsk: widget.tasks,)));

                                              }*/



                                            }),
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
                                        Text(' '),
                                        Expanded(
                                          child: Container(
                                            height: 20.0,
                                            width: 10.0,
                                            child: Center(
                                                child: Text("Title",
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
                                                child: Text("Status",
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
                                                    Text("Select" ,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15.0,
                                                            color: Colors.black)),

                                                    Center(
                                                      child: Checkbox(
                                                        activeColor: Colors.green,
                                                        checkColor: Colors.black,
                                                        value:  isallSelected,
                                                        //isSelected,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            isallSelected = val!;
                                                            if(val == true){
                                                              Helper.classes = "TESSA";
                                                              for(int i=0; i<widget.tasks.testing!.length; i++){
                                                                Testtype tst = Testtype(
                                                                    testType:  widget.tasks.testing![i].testStatus
                                                                );
                                                                testindex.add(tst.testType);
                                                              }


                                                              print("object------------->${testindex}");
                                                            }
                                                            else{
                                                              Helper.classes = "TEST";
                                                              //  testindex.remove(testtypevale);

                                                            }

                                                          });

                                                        },
                                                      ),),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 20.0,
                                            width: 10.0,
                                            child: Center(
                                                child: Text("Test Type",
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
                                Expanded(
                                  flex: 4,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 500,
                                            color: Color(0xFFd9d8d7),
                                            child: ListView.builder(
                                                controller: ScrollController(),
                                                itemCount: widget.tasks.testing!.length,
                                                //testtypevale.length,
                                                itemBuilder: (BuildContext ctxt, int index) {
                                                  return getProduct( widget.tasks.testing!,index);
                                                })),
                                      ],
                                    ),
                                  ),
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
    }, error: (e,s){
      return Text(e.toString());

    }, loading: (){
      return Center(child: CircularProgressIndicator());
    });



  }

  getProduct(List<Testing> mList ,int index) {

   if(Helper.classes == "TEST"){
     mList[index].isSelected = false;
     testindex.remove(mList[index].testStatus);
   }else if(Helper.classes == "TESSA"){
     mList[index].isSelected = true;
   }
    return Card(
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
                      child: Text(mList[index].testStatus.toString(),
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
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(
                    child: Checkbox(
                      activeColor: Colors.green,
                      checkColor: Colors.black,
                      value: mList[index].isSelected,
                      onChanged: (val) {


                        print("${mList[index].isSelected}  ${index}");
                          if(mList[index].isSelected == true){
                            setState(() {
                              mList[index].isSelected = false;
                              Helper.classes = "DEMO";
                              testindex.remove(mList[index].testStatus);

                              print("remove item from list---------------> ${testindex}");

                              print("hellllo------------>${mList[index].isSelected}  ${index}");
                            });


                          }else if(mList[index].isSelected == false){
                            setState(() {
                              Helper.classes = "DEMO";
                              mList[index].isSelected = true;
                              if(testindex != mList[index].testStatus ){
                                if(testindex.contains(mList[index].testStatus) == false){
                                  testindex.add(mList[index].testStatus);
                                  Helper.testType = testindex;
                                }
                                print("add item from list---------------> ${testindex}");
                              }else{
                              }


                             /* for(int i=0; i< widget.test!.length; i++){
                                if(mList[index].testStatus.toString() == widget.test![i].testStatus ){
                                  Testing tests = Testing(
                                    testId: widget.test![i].testId,
                                    taskId: widget.test![i].taskId,
                                    testStage: widget.test![i].testStage,
                                    testStatus: widget.test![i].testStatus,
                                    pass: widget.test![i].pass,
                                    fail: widget.test![i].fail,
                                    status: widget.test![i].status,
                                    flg: widget.test![i].flg,
                                    macAddress: widget.test![i].macAddress,
                                    testType: widget.test![i].testType,
                                    testDate: widget.test![i].testDate,
                                    hoursTaken: widget.test![i].hoursTaken,
                                    testNumber: widget.test![i].testNumber,
                                    isSelected: widget.test![i].isSelected,
                                  );
                                  heading.add(tests);

                                  print("heading--------> ${heading[i].testStatus}");

                                }
                              }

                              print("heading--------> ${heading}");
*/




                            });
                          }


                      /*if(mList[index].isSelected == false){
                        setState(() {
                          mList[index].isSelected =  true;
                          print(mList[index].isSelected);

                        });
                      }else if(mList[index].isSelected == true){
                        setState(() {
                          mList[index].isSelected = false;

                        });
                      }*/
                      },
                    ),),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(
                      child: Text(mList[index].testStage.toString() == "1"? "First Test"
                          : mList[index].testStage.toString() == "2"? "Second Test"
                          : "ReTest",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                ),
              ),
            ],
          ),
        ));
  }

   getteststagepopup() {
     setState(() {
       testType = "1";
     });
    return showDialog(
        context: context,
        builder: (c) => StatefulBuilder(
        builder: (context, setState) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content:
        const Text('Are you sure, you want to start the test ?'),
        actions: [
          RadioListTile(
            title: const Text('First Test'),
            value: "1",
            groupValue: testType,
            onChanged: (value) {
              setState(() {
                testType = value.toString();
              });
            },
          ),
         RadioListTile(
            title: const Text("Second Test"),
            value: "2",
            groupValue: testType,
            onChanged: (value) {
              setState(() {
                testType = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text("ReTest"),
            value: "3",
            groupValue: testType,
            onChanged: (value) {
              setState(() {
                testType = value.toString();
              });
            },
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL')),
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
                        context, MaterialPageRoute(builder: (context) => TestScreenPage(testtype: [testindex],testlist: widget.tet, tsk: widget.tasks,stages: testType,)));
                  },
                  child: const Text('CONFIRM')),
            ],
          ),
        ],
      );
    }));
   }
}
