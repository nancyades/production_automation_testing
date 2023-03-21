import 'package:flutter/material.dart';

import 'package:production_automation_testing/noofpages/Test/testpage.dart';
import '../../Helper/helper.dart';
import '../../HomeScreen.dart';
import '../../Model/readexcel/readecel.dart';
import '../../NavigationBar/src/company_name.dart';
import '../../NavigationBar/src/navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Provider/excelprovider.dart';



class SecondTaskViewPage extends ConsumerStatefulWidget {
  const SecondTaskViewPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SecondTaskViewPage> createState() => _SecondTaskViewPageState();
}

class _SecondTaskViewPageState extends ConsumerState<SecondTaskViewPage> {
  List<Testtype>  testtypevale = [];
  var fontSize, height;
  bool isSelected = false;

  List<dynamic> testindex = [];






  @override
  void initState(){
    ref.read(gettesttypeNotifier);
    Helper.classes = "TEST";

  }



  @override
  Widget build(BuildContext context) {
    fontSize = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    List<Testtype>? testtype = ref.watch(gettesttypeNotifier).value;


    if(testtype != null){
      for(int i=0; i<testtype.length; i++){
        if(testtype[i].testType == ""|| testtype[i].testType == "Title" ){
        }else{
          Testtype tst = Testtype(
              testType: testtype[i].testType
          );
          if(testtypevale.isEmpty || testtypevale.length <= 6){
            if(Helper.classes == "TEST" ){
              testtypevale.add(tst);
            }
          }

        }
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
              Align(
                  alignment: Alignment.center,
                  child: NavBar()
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
                                                      Text('PSPB', style: TextStyle(
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
                                                      Text('PSPB_E104', style: TextStyle(
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
                                                      Text('Created', style: TextStyle(
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
                                                Text('PSPB-E', style: TextStyle(
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
                                                Text('PC_1101-M-P', style: TextStyle(
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
                                                Text('Sriram', style: TextStyle(
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
                                             //print("please select atleast one field")
                                            else{
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => TestScreenPage(testtype: [testindex])));
                                            }


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
                                                      value:  isSelected,
                                                      //isSelected,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          isSelected = val!;
                                                          if(val == true){
                                                            Helper.classes = "TESSA";
                                                          }
                                                          else{
                                                            Helper.classes = "TEST";
                                                          }

                                                        });

                                                      },
                                                    ),),
                                                ],
                                              )
                                          ),
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
                                              itemCount: testtypevale.length,
                                              itemBuilder: (BuildContext ctxt, int index) {
                                                return getProduct(testtypevale,index);
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
  }

  getProduct(List<Testtype> mList , int index) {

   if(Helper.classes == "TEST"){
     mList[index].isSelected = false;
     testindex.remove(mList[index].testType);
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
                      child: Text(mList[index].testType.toString(),
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
                      //isSelected,
                      onChanged: (val) {

                        print("${mList[index].isSelected}  ${index}");
                          if(mList[index].isSelected == true){
                            setState(() {
                              mList[index].isSelected = false;
                              Helper.classes = "DEMO";
                              testindex.remove(mList[index].testType);
                              print("remove item from list---------------> ${testindex}");

                              print("hellllo------------>${mList[index].isSelected}  ${index}");
                            });

                          }else if(mList[index].isSelected == false){
                            setState(() {
                              Helper.classes = "DEMO";
                              mList[index].isSelected = true;
                              if(testindex != mList[index].testType ){
                                if(testindex.contains(mList[index].testType) == false){
                                  testindex.add(mList[index].testType);
                                  Helper.testType = testindex;
                                }
                                print("add item from list---------------> ${testindex}");
                              }else{
                              }
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
            ],
          ),
        ));
  }
}
