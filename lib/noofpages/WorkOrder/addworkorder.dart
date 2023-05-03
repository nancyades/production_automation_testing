import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../Database/Curd_operation/HiveModel/productmodel.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/HiveModel/workordermodel.dart';
import '../../Helper/AppClass.dart';
import '../../Helper/helper.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/APIModel/workordermodel.dart';
import '../../Model/templatemodel.dart';
import '../../Provider/changenotifier/widget_notifier.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/post_provider/workorder_provider.dart';
import '../Users/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropDownChange = StateProvider<bool>((ref) => true);

final Add = StateProvider<bool>((ref) => true);

class AddWorkOrder extends ConsumerStatefulWidget {
  WorkorderModel workorderModel;

  AddWorkOrder({Key? key, required this.workorderModel}) : super(key: key);

  @override
  ConsumerState<AddWorkOrder> createState() => _AddWorkOrderState();
}

List<ProductModel>? datamodels;

class _AddWorkOrderState extends ConsumerState<AddWorkOrder> {
  //var selectedProduct = datamodels[0].Product_Name.toString();
  List<String> products = [];

  List productlist = [];

  List<WorkorderList> listofproduct = [];
  List<ProductList> listofproduct1 = [];

  WorkorderList ? lWorkorder;

  TextEditingController controllerWorkorder = TextEditingController();
  TextEditingController controllerQuantity = TextEditingController();
  TextEditingController controllerStartserial = TextEditingController();
  TextEditingController controllerEndserial = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();
  TextEditingController controllerProductQuantity = TextEditingController();
  TextEditingController controllerProductStartserial = TextEditingController();
  TextEditingController controllerProductEndserial = TextEditingController();

  bool isSelected = true;
  bool isValue = true;
  late Box<WorkOrderModel> dataBox;
  int? index;
  var selectedProduct;
  var updatepoduct = "";
  int? workorder_id;
  bool searchdropdown = true;

  // var selectRole = "Created";
  List<String> status = [
   // 'Created',
   // 'Verified',
    'Approved',
    'Rejected',
  ];

  int? val;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<WorkOrderModel>('work_orders');
  }

  void clearText() {
    controllerWorkorder.clear();
    controllerQuantity.clear();
    controllerStartserial.clear();
    controllerEndserial.clear();
    controllerStatus.clear();
    controllerRemarks.clear();
  }

  void clearproductText() {
    controllerProductQuantity.clear();
    controllerProductStartserial.clear();
    controllerProductEndserial.clear();
  }

  void listBuilder (int index){
    listofproduct1[index].productname = widget.workorderModel.woList![index].id.toString();
    listofproduct1[index].startserial = widget.workorderModel.woList![index].start_serial_no.toString();
    listofproduct1[index].endserial = widget.workorderModel.woList![index].end_serial_no.toString();
  }

  @override
  Widget build(BuildContext context) {
    var Width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;

    if(Helper.editvalue == "passvalue"){
      if (widget.workorderModel != null) {
        workorder_id = widget.workorderModel.workorderId;
        controllerWorkorder.text = widget.workorderModel.workorderCode!;
        controllerQuantity.text = widget.workorderModel.quantity!.toString();
        controllerStartserial.text = widget.workorderModel.startSerialNo!;
        controllerEndserial.text = widget.workorderModel.endSerialNo!;
        controllerStatus.text = widget.workorderModel.status!;
        isSelected = widget.workorderModel.flg == 0 ? false : true;

        if(controllerStatus.text == "Created"){
          widget.workorderModel.status = "Approved";
        }else{
          widget.workorderModel.status = controllerStatus.text;
        }


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
                                    Text('*',
                                        style: TextStyle(color: Colors.red)),
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
                                    Text('*',
                                        style: TextStyle(color: Colors.red)),
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
                                    Text('*',
                                        style: TextStyle(color: Colors.red)),
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


                  Helper.sharedRoleId == "Test Admin" ?
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [

                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                 : Padding(
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
                                    Text('*',
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Consumer(builder: (context, ref, child) {
                                ref.watch(counterModelProvider);
                                return Visibility(
                                  visible: searchdropdown,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: DropdownButton(
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0),
                                                  child: Icon(Icons
                                                      .keyboard_arrow_down),
                                                ),
                                                items: status.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String setlist) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: setlist,
                                                    child: Text(
                                                        setlist.toString()),
                                                  );
                                                }).toList(),
                                                // value: selectRole,
                                                // onChanged: (item) {
                                                //   setState(() {
                                                //     selectRole = item.toString();
                                                //     print("Index==>" + selectRole);
                                                //     //List<FirstClass> emptylist = [];
                                                //   });
                                                // },
                                                value: widget
                                                     .workorderModel.status,
                                                onChanged: (item) {
                                                  ref
                                                      .read(counterModelProvider
                                                          .notifier)
                                                      .press();
                                                  widget.workorderModel.status =
                                                      item.toString();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
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
                /* child: ValueListenableBuilder<Box<ProductModel>>(
                    valueListenable: Products.getProducts().listenable(),
                    builder: (context, Box<ProductModel> items, _) {
                      List<int> keys;
                      keys = items.keys.cast<int>().toList();
                      datamodels = items.values.toList().cast<ProductModel>();
                      if (isValue == true) {
                        selectedProduct =
                            datamodels![0].product_name.toString();
                      }

                      if (products.length == 0) {
                        for (int i = 0; i < datamodels!.length; i++) {
                          ProductModel val = ProductModel(
                              product_name: datamodels![i].product_name);

                          products.add(val.product_name.toString());

                        // print("pproducts");
                        // print("product length1====> ${products.length}");
                        // print("product value1====> ${products}");
                        }
                      }*/

                // print(datamodels);
                // print("product length2====> ${products.length}");
                // print("product value2====> ${products}");
                child: Consumer(builder: (context, ref, child) {
                  return ref.watch(getProductNotifier).when(data: (data) {
                   /* for(int i=0; i<data.length; i++){
                      if(data[i].status ==)
                    }*/

                    if (isValue == true) {
                      selectedProduct = data[0].productName.toString();
                    }
                    if (products.length == 0) {
                      for (int i = 0; i < data.length; i++) {
                        Productmodel val = Productmodel(
                            productName: data[i].productName,
                            quantity: data[i].quantity,
                          status: data[i].status
                        );
                        if(val.status == "Approved"){
                          products.add(val.productName.toString());
                          selectedProduct = products[0];

                        }






                      }
                    }
                    for (var i in data) {
                      var productMap = {
                        'productName': i.productName,
                        'quantity': i.quantity,
                      };
                      productlist.add(productMap);
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:  widget.workorderModel.workorderCode == ""
                            ? DropdownButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: products.map<DropdownMenuItem<String>>(
                                  (String setlist) {
                                return DropdownMenuItem<String>(
                                  value: setlist,
                                  child: Text(setlist.toString()),
                                );
                              }).toList(),
                              value: selectedProduct,
                              onChanged: (item) {
                                ref.read(dropDownChange.notifier).state =
                                    !ref.watch(dropDownChange);
                                if (isValue == true) {
                                  isValue = false;
                                }
                                if (isValue == false) {
                                  selectedProduct = item.toString();
                                  for (int i = 0; i < productlist.length; i++) {
                                    if (productlist[i]['productName'] == selectedProduct) {
                                      controllerProductQuantity.text =
                                          productlist[i]['quantity'].toString();
                                    }
                                  }
                                }

                                print("ITEM.TOSTRING =====>$item");
                              },
                            )
                                : Center(child: Text(updatepoduct))
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
                                            fontSize: Width * 0.0069,
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
                                    controller: controllerProductQuantity,
                                    decoration: InputDecoration(
                                        /* border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(8.0),
                                     ),*/
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
                                            fontSize: Width * 0.0069,
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
                                    controller: controllerProductStartserial,
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
                                            fontSize: Width * 0.0069,
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
                                    controller: controllerProductEndserial,
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


                        (widget.workorderModel.workorderCode == "") ?
                        MaterialButton(
                          shape: const CircleBorder(),
                          color: Colors.black,
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            if(productvalidation()){
                              setState(() {
                                Helper.editvalue = "notpassvalue";
                                WorkorderList pro = WorkorderList(
                                    id: 0,
                                    workorder_id: 0,
                                    product_id: data.where((element) => element.productName.toString()== selectedProduct.toString()).first.productId,
                                    quantity: int.parse(controllerProductQuantity.text),
                                    start_serial_no: controllerProductStartserial.text,
                                    end_serial_no: controllerProductEndserial.text,
                                  status: "Created",
                                  flg:1
                                );
                                listofproduct.add(pro);


                                ProductList pro1 = ProductList(
                                  productname: selectedProduct,
                                  quantity: double.parse(controllerProductQuantity.text),
                                  startserial: controllerProductStartserial.text,
                                  endserial: controllerProductEndserial.text
                                );
                                listofproduct1.add(pro1);


                                clearproductText();
                              });



                            }

                          },
                          child: const Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.white,
                          ),
                        )
                            :  MaterialButton(
                          shape: const CircleBorder(),
                          color: Colors.black,
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            if(productvalidation()){
                              setState(() {
                                  widget.workorderModel.woList![val!].product_name = selectedProduct;
                                  widget.workorderModel.woList![val!].quantity = int.parse(controllerProductQuantity.text);
                                  widget.workorderModel.woList![val!].start_serial_no = controllerProductStartserial.text;
                                  widget.workorderModel.woList![val!].end_serial_no = controllerProductEndserial.text;

                                clearproductText();
                              });



                            }

                          },
                          child: const Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }, error: (e, s) {
                    return Text(e.toString());
                  }, loading: () {
                    return CircularProgressIndicator();
                  });
                }),
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
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemCount: (){
                              if(widget.workorderModel.workorderCode == ""){
                                return listofproduct.length;
                              }else{
                                return widget.workorderModel.woList!.length;
                              }
                            }(),

                            //listofproduct.length,
                            itemBuilder: (BuildContext ctxt, int index) {


                               return  (){
                                if(widget.workorderModel.workorderCode == ""){
                                  return InkWell(
                                    onTap: (){
                                      setState((){
                                        selectedProduct = listofproduct1[index].productname.toString();
                                        controllerProductQuantity.text = listofproduct1[index].quantity.toString();
                                        controllerProductStartserial.text = listofproduct1[index].startserial.toString();
                                        controllerProductEndserial.text = listofproduct1[index].endserial.toString();
                                      });

                                    },
                                    child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(listofproduct1[index]
                                                  .productname
                                                  .toString()),
                                              Text(listofproduct1[index]
                                                  .quantity
                                                  .toString()),
                                              Text(listofproduct1[index]
                                                  .startserial
                                                  .toString()),
                                              Text(listofproduct1[index]
                                                  .endserial
                                                  .toString()),
                                            ],
                                          ),
                                        ))
                                  );
                                }else{
                                  return InkWell(
                                    onTap: (){
                                     setState((){
                                        val = index;
                                        updatepoduct = widget.workorderModel.woList![index].product_name.toString();
                                        print("product---------> $updatepoduct");
                                        controllerProductQuantity.text = widget.workorderModel.woList![index].quantity.toString();
                                        controllerProductStartserial.text = widget.workorderModel.woList![index].start_serial_no.toString();
                                        controllerProductEndserial.text = widget.workorderModel.woList![index].end_serial_no.toString();

                                       });

                                    },
                                    child:
                                    //widget.workorderModel.workorderId == widget.workorderModel.woList![index].workorder_id ?
                                    Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(widget.workorderModel.woList![index].product_name.toString()),
                                              Text(widget.workorderModel.woList![index].quantity.toString()),
                                              Text(widget.workorderModel.woList![index].start_serial_no.toString()),
                                              Text(widget.workorderModel.woList![index].end_serial_no.toString()),
                                            ],
                                          ),
                                        ))
                                  );
                                }
                              }();



                            }),
                      ),
                    ),
                    (widget.workorderModel.workorderCode == "")?
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(
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


                            if (validateFields()) {
                              ref
                                  .read(addWorkOrderNotifier.notifier)
                                  .addWorkOrders(
                                  {
                                    "workorderId":null,
                                    "workorder_code": controllerWorkorder.text,
                                    "quantity":
                                    int.parse(controllerQuantity.text),
                                    "start_serial_no":
                                    controllerStartserial.text,
                                    "end_serial_no": controllerEndserial.text,
                                    "status": widget.workorderModel.status,
                                    "created_by": 1,
                                    "updated_by": 1,
                                    "created_date": null,
                                    "updated_date": null,
                                    "flg": isSelected ? 0 : 1,
                                    "remarks": controllerRemarks.text,
                                    "woList": (listofproduct) ,
                                  }
                              );

                              /* WorkOrder().addWorkorder(
                                      "",
                                      controllerWorkorder.text,
                                      controllerQuantity.text,
                                      controllerStartserial.text,
                                      controllerEndserial.text,
                                      controllerStatus.text,
                                      "",
                                      "",
                                      "",
                                      "",
                                      isSelected,
                                      controllerRemarks.text,
                                    );*/
                              clearText();
                            }


                          }),
                    )
                    : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("UPDATE".toUpperCase(),
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
                            ref
                                .read(updateWorkorderNotifier.notifier)
                                .updatetWorkorder({
                              "workorder_id": workorder_id,
                              "workorder_code": controllerWorkorder.text,
                              "quantity":
                              int.parse(controllerQuantity.text),
                              "start_serial_no": controllerStartserial.text,
                              "end_serial_no": controllerEndserial.text,
                              "status": widget.workorderModel.status,
                              "created_by": 1,
                              "updated_by": 1,
                              "created_date": null,
                              "updated_date": null,
                              "flg": isSelected ? 1 : 0,
                              "remarks": controllerRemarks.text
                            });
                            clearText();
                          }),
                    ),
                   /* Padding(
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


                                  if (validateFields()) {
                                    ref
                                        .read(addWorkOrderNotifier.notifier)
                                        .addWorkOrders(
                                       {
                                      "workorderId":null,
                                      "workorder_code": controllerWorkorder.text,
                                      "quantity":
                                      int.parse(controllerQuantity.text),
                                      "start_serial_no":
                                      controllerStartserial.text,
                                      "end_serial_no": controllerEndserial.text,
                                      "status": widget.workorderModel.status,
                                      "created_by": 1,
                                      "updated_by": 1,
                                      "created_date": null,
                                      "updated_date": null,
                                      "flg": isSelected ? 0 : 1,
                                      "remarks": controllerRemarks.text,
                                      "woList": (listofproduct) ,
                                     }
                                     );



                                    */
                    /* WorkOrder().addWorkorder(
                                    "",
                                    controllerWorkorder.text,
                                    controllerQuantity.text,
                                    controllerStartserial.text,
                                    controllerEndserial.text,
                                    controllerStatus.text,
                                    "",
                                    "",
                                    "",
                                    "",
                                    isSelected,
                                    controllerRemarks.text,
                                  );*/
                    /*



                                    clearText();
                                  }


                              }),
                          ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("UPDATE".toUpperCase(),
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
                                ref
                                    .read(updateWorkorderNotifier.notifier)
                                    .updatetWorkorder({
                                  "workorder_id": workorder_id,
                                  "workorder_code": controllerWorkorder.text,
                                  "quantity":
                                      int.parse(controllerQuantity.text),
                                  "start_serial_no": controllerStartserial.text,
                                  "end_serial_no": controllerEndserial.text,
                                  "status": widget.workorderModel.status,
                                  "created_by": 1,
                                  "updated_by": 1,
                                  "created_date": null,
                                  "updated_date": null,
                                  "flg": isSelected ? 1 : 0,
                                  "remarks": controllerRemarks.text
                                });
                                clearText();
                              }),
                        ],
                      ),
                    )*/
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
    } else if (controllerQuantity.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Quantity should not be empty',
          context: context);
      return false;
    } else if (controllerStartserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Start Serial No should not be empty',
          context: context);
      return false;
    } else if (controllerEndserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'End Serial No should not be empty',
          context: context);
      return false;
    }
    return true;
  }

  bool productvalidation() {
    if (controllerProductQuantity.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Quantity should not be empty',
          context: context);
      return false;
    } else if (controllerProductStartserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Start serialno should not be empty',
          context: context);
      return false;
    } else if (controllerProductEndserial.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product End serialno should not be empty',
          context: context);
      return false;
    }
    return true;
  }
}
