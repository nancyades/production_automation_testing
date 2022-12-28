import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Helper/AppClass.dart';
//import 'package:progress_timeline/progress_timeline.dart';

class AddWorkOrder extends StatefulWidget {
  const AddWorkOrder({Key? key}) : super(key: key);

  @override
  State<AddWorkOrder> createState() => _AddWorkOrderState();
}

class _AddWorkOrderState extends State<AddWorkOrder> {
  var selectedProduct = "PSBE";
  List<String> products = ['PSBE', '16 Zone', 'PSBE-E', '32 Zone'];

  TextEditingController controllerWorkorder = TextEditingController();
  TextEditingController controllerQuantity = TextEditingController();
  TextEditingController controllerStartserial = TextEditingController();
  TextEditingController controllerEndserial = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();
  TextEditingController controllerProductQuantity = TextEditingController();
  TextEditingController controllerProductStartserial = TextEditingController();
  TextEditingController controllerProductEndserial = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                "Work Order",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
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
                                    Text("Workorder Code",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                    Text('*',
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 22.0,
                                ),
                                child: SizedBox(
                                  height: 35,
                                  child: TextField(
                                    controller: controllerWorkorder,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        //hintText: "Workorder Code",
                                        fillColor: Colors.white70),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Colors.black),
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
                                    Text("Quantity",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                    Text('*', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 22.0),
                                child: SizedBox(
                                  height: 35,
                                  child: TextField(
                                    controller: controllerQuantity,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        //hintText: "Quantity",
                                        fillColor: Colors.white70),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Colors.black),
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
                                    Text("Start Serial No",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                    Text('*', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 22.0),
                                child: SizedBox(
                                  height: 35,
                                  child: TextField(
                                    controller: controllerStartserial,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        // hintText: "Start Serial No",
                                        fillColor: Colors.white70),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Colors.black),
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
                                    Text("End Serial No",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                    Text('*', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 22.0),
                                child: SizedBox(
                                  height: 35,
                                  child: TextField(
                                    controller: controllerEndserial,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        //hintText: "End Serial No",
                                        fillColor: Colors.white70),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Colors.black),
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
                                    Text("Status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                    Text('*', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 22.0),
                                child: SizedBox(
                                  height: 35,
                                  child: TextField(
                                    controller: controllerStatus,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        //hintText: "Status",
                                        fillColor: Colors.white70),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Colors.black),
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
                                    Text("Remarks",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 22.0),
                                child: SizedBox(
                                  height: 35,
                                  child: TextField(
                                    controller: controllerRemarks,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        //hintText: "Remarks",
                                        fillColor: Colors.white70),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                        color: Colors.black),
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
            SizedBox(
              height: 70,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        items: products
                            .map<DropdownMenuItem<String>>((String setlist) {
                          return DropdownMenuItem<String>(
                            value: setlist,
                            child: Text(setlist.toString()),
                          );
                        }).toList(),
                        value: selectedProduct,
                        onChanged: (item) {
                          setState(() {
                            selectedProduct = item.toString();
                            print("Index==>" + selectedProduct);
                            //List<FirstClass> emptylist = [];
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Row(
                              children: [
                                Text("Quantity",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 22.0),
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                controller: controllerProductQuantity,
                                decoration: InputDecoration(
                                    /* border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(8.0),
                             ),*/
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[800], fontSize: 13),
                                    //hintText: "Quantity",
                                    fillColor: Colors.white70),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0,
                                    color: Colors.black),
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
                                Text("Start Serialno",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 22.0),
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                controller: controllerProductStartserial,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[800], fontSize: 13),
                                    //hintText: "Quantity",
                                    fillColor: Colors.white70),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0,
                                    color: Colors.black),
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
                                Text("End Serialno",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.blueAccent)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 22.0),
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                controller: controllerProductEndserial,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[800], fontSize: 13),
                                    //hintText: "Quantity",
                                    fillColor: Colors.white70),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: const CircleBorder(),
                      color: Colors.black,
                      padding: const EdgeInsets.all(10),
                      onPressed: () {},
                      child: const Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                            child: Text("Product",
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
                            child: Text("Quantity",
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
                            child: Text("Start Serial No",
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
                            child: Text("End Serial No",
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xffcbdff2),
                        elevation: 10,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Add WorkOrder ".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              ),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side:
                                              BorderSide(color: Colors.red)))),
                              onPressed: () {
                                if(validateFields()){
                                }

                              }),
                          ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Edit WorkOrder".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              ),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side:
                                              BorderSide(color: Colors.red)))),
                              onPressed: () => null),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool validateFields() {
    if (controllerWorkorder.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'workorder Code should not be empty',
          context: context);
      return false;
    }else if(controllerQuantity.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Quantity should not be empty',
          context: context);
      return false;
    }else if (controllerStartserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Start Serial No should not be empty',
          context: context);
      return false;
    }else if (controllerEndserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'End Serial No should not be empty',
          context: context);
      return false;
    }else if (controllerStatus.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Status should not be empty',
          context: context);
      return false;
    }else if (controllerProductQuantity.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Quantity should not be empty',
          context: context);
      return false;
    }else if (controllerProductStartserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Start serialno should not be empty',
          context: context);
      return false;
    }else if (controllerProductEndserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product End serialno should not be empty',
          context: context);
      return false;
    }
    return true;
  }
}
