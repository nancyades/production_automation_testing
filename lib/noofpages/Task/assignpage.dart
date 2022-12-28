import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/testmodel.dart';
import '../../Provider/test_provider.dart';

class AssignTask extends ConsumerStatefulWidget {
  const AssignTask({Key? key}) : super(key: key);

  @override
  ConsumerState<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends ConsumerState<AssignTask> {
  var selectProduct = "PSBE";
  List<String> products = ['PSBE', '16 Zone', 'PSBE-E', '32 Zone'];

  var selectWorkorder = "PSBEWorkorder";
  List<String> workorders = [
    'PSBEWorkorder',
    '16ZoneWorkorder',
    'PSBE-EWorkorder',
    '32ZoneWorkorder'
  ];

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(getTestListProvider);
    List<TestModel> mModel = [];
    mModel = data;

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
        //color: Color(0xffa4cfed),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.65,
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
                        .map<DropdownMenuItem<String>>((String setlist) {
                      return DropdownMenuItem<String>(
                        value: setlist,
                        child: Text(setlist.toString()),
                      );
                    }).toList(),
                    value: selectWorkorder,
                    onChanged: (item) {
                      setState(() {
                        selectWorkorder = item.toString();
                        print("Index==>" + selectWorkorder);
                        //List<FirstClass> emptylist = [];
                      });
                    },
                  ),
                  DropdownButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    items:
                    products.map<DropdownMenuItem<String>>((String setlist) {
                      return DropdownMenuItem<String>(
                        value: setlist,
                        child: Text(setlist.toString()),
                      );
                    }).toList(),
                    value: selectProduct,
                    onChanged: (item) {
                      setState(() {
                        selectProduct = item.toString();
                        print("Index==>" + selectProduct);
                        //List<FirstClass> emptylist = [];
                      });
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
                                          this.isSelected = val!;
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
            Column(
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
                        itemCount: 6,
                        //mModel.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return getTaskItem(index);
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
                          onPressed: () => null),
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
            ),
          ],
        ),
      ),
    );
  }

  getTaskItem(int index) {
    //List<TestModel> mList,
    // TestModel task = mList[index];
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("VISUAL INSPECTION TEST"),
                  Text("#1101-M-PO1-1"),
                  Checkbox(
                    activeColor: Colors.green,
                    checkColor: Colors.black,
                    value: isSelected,
                    onChanged: (state) {
                      setState(() {
                        isSelected = state!;
                      });
                    },
                  ),
                ])));
  }
}
