import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../Database/Curd_operation/HiveModel/productmodel.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/HiveModel/workordermodel.dart';
import '../../Database/Curd_operation/boxes.dart';
import '../../Database/Curd_operation/database.dart';
import '../../Helper/AppClass.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/APIModel/workordermodel.dart';
import '../../Model/templatemodel.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/post_provider/workorder_provider.dart';
import '../Users/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  List<ProductList> listofproduct = [];



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
  int? workorder_id;

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


  @override
  Widget build(BuildContext context) {
    if (Allvalues.WorkOrder_Code != null &&
        Allvalues.Quantity != null &&
        Allvalues.Start_Serial_No != null &&
        Allvalues.End_Serial_No != null &&
        Allvalues.Status != null) {
      controllerWorkorder.text = Allvalues.WorkOrder_Code!;
      controllerQuantity.text = Allvalues.Quantity!;
      controllerStartserial.text = Allvalues.Start_Serial_No!;
      controllerEndserial.text = Allvalues.End_Serial_No!;
      key = Allvalues.key!;
      controllerStatus.text = Allvalues.Status!;
    }

    if (widget.workorderModel != null) {
      workorder_id = widget.workorderModel.workorderId;
      controllerWorkorder.text = widget.workorderModel.workorderCode!;
      controllerQuantity.text = widget.workorderModel.quantity!.toString();
      controllerStartserial.text = widget.workorderModel.startSerialNo!;
      controllerEndserial.text = widget.workorderModel.endSerialNo!;
      controllerStatus.text = widget.workorderModel.status!;
      isSelected = widget.workorderModel.flg == 0 ? false : true;
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
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.65,
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
                child:  Consumer(
                        builder: (context, ref, child) {
                         return  ref.watch(getProductNotifier).when(data: (data){
                           if (isValue == true) {
                             selectedProduct = data[0].productName.toString();
                                // datamodels![0].product_name.toString();
                           }


                           if (products.length == 0 ) {
                             for (int i = 0; i < data.length; i++) {
                               Productmodel val = Productmodel(
                                 productName:  data[i].productName,
                                 quantity: data[i].quantity
                               );

                               products.add(val.productName.toString());


                               // print("pproducts");
                               // print("product length1====> ${products.length}");
                              // print("product value1====> ${products}");
                               //print("product value2====> ${quantity}");
                             }
                           }

                           for(var i in data){
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: DropdownButton(
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

                                        print("Index==>" + selectedProduct);
                                        setState(() {
                                          if (isValue == true) {
                                            isValue = false;
                                          }
                                          if (isValue == false) {
                                            selectedProduct = item.toString();

                                            for(int i=0;i<productlist.length; i++){
                                              if(productlist[i]['productName'] == selectedProduct){
                                                controllerProductQuantity.text = productlist[i]['quantity'].toString();
                                              }
                                            }



                                          }
                                          print("Index==>" + selectedProduct);
                                        });
                                      },
                                    ),
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
                                MaterialButton(
                                  shape: const CircleBorder(),
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(10),
                                  onPressed: () {
                                    setState(() {
                                      ProductList pro = ProductList(
                                          productname: selectedProduct,
                                          quantity: controllerProductQuantity.text,
                                          startserial: controllerProductStartserial.text,
                                          endserial: controllerProductEndserial.text
                                      );
                                      listofproduct.add(pro);

                                      clearproductText();
                                    });

                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          }, error: (e,s){
                            return Text(e.toString());
                          }, loading: (){
                            return CircularProgressIndicator();
                          });

                        }
                      ),
                  //  }),
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
                            itemCount: listofproduct.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(listofproduct[index].productname.toString()),
                                        Text(listofproduct[index].quantity.toString()),
                                        Text(listofproduct[index].startserial.toString()),
                                        Text(listofproduct[index].endserial.toString()),
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
                                if (validateFields()) {
                                  ref
                                      .read(addWorkOrderNotifier.notifier)
                                      .addWorkOrders({
                                    "workorder_code": controllerWorkorder.text,
                                    "quantity": int.parse(controllerQuantity.text),
                                    "start_serial_no": controllerStartserial.text,
                                    "end_serial_no": controllerEndserial.text,
                                    "status": controllerStatus.text,
                                    "created_by": 1,
                                    "updated_by": 1,
                                    "created_date": null,
                                    "updated_date": null,
                                    "flg": isSelected ? 0 : 1,
                                    "remarks": controllerRemarks.text,
                                  });
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
                              onPressed: () {
                                ref.read(updateWorkorderNotifier.notifier)
                                    .updatetWorkorder({
                                      "workorder_id": workorder_id,
                                      "workorder_code": controllerWorkorder.text,
                                      "quantity": int.parse(controllerQuantity.text),
                                      "start_serial_no": controllerStartserial.text,
                                      "end_serial_no": controllerEndserial.text,
                                      "status": controllerStatus.text,
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
    } else if (controllerStatus.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Status should not be empty',
          context: context);
      return false;
    } else if (controllerProductQuantity.text.isEmpty) {
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
