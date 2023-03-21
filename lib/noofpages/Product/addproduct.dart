import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/productmodel.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/usermodel.dart';
import 'package:production_automation_testing/Provider/post_provider/product_provider.dart';

import '../../Database/Curd_operation/database.dart';
import '../../Helper/AppClass.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/templatemodel.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/post_provider/template_provider.dart';
import '../Users/user.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProduct extends ConsumerStatefulWidget {
  Productmodel product;

  AddProduct({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  bool isSelected = false;

  TextEditingController controllerProductCode = TextEditingController();
  TextEditingController controllerProductName = TextEditingController();
  TextEditingController controllerProductQuantity = TextEditingController();
  TextEditingController controllerProductDescription = TextEditingController();
  TextEditingController controllerProductStatus = TextEditingController();
  TextEditingController controllerTimeRequired = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();

  TextEditingController controllerTemplate = TextEditingController();
  TextEditingController controllerFilepath = TextEditingController();
  TextEditingController controllerTemplateremarks = TextEditingController();

  List<Templatemodel> Templatelist = [];
  late Box<ProductModel> dataBox;

  String selctFile = '';
  Uint8List? selectedImageInByte;
  String? selectedImage;
  int? product_id;

  @override
  void initState() {
    super.initState();

    dataBox = Hive.box<ProductModel>('product');
  }

  void clearText() {
    controllerProductCode.clear();
    controllerProductName.clear();
    controllerProductQuantity.clear();
    controllerProductDescription.clear();
    controllerProductStatus.clear();
    controllerTimeRequired.clear();
    controllerRemarks.clear();
  }

/*
  void _pickFile() async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

    final file = result.files.first;

    _openFile(file);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }*/

  @override
  Widget build(BuildContext context) {
    if (Allvalues.product_code != null &&
        Allvalues.product_name != null &&
        Allvalues.product_quantity != null &&
        Allvalues.product_status != null &&
        Allvalues.timerequired != null) {
      controllerProductCode.text = Allvalues.product_code!;
      controllerProductName.text = Allvalues.product_name!;
      controllerProductQuantity.text = Allvalues.product_quantity!;
      controllerProductStatus.text = Allvalues.product_status!;
      controllerTimeRequired.text = Allvalues.timerequired!;
      key = Allvalues.key!;
    }
    if (widget.product != null) {
      product_id = widget.product.productId;
      controllerProductCode.text = widget.product.productCode!;
      controllerProductName.text = widget.product.productName!.toString();
      controllerProductQuantity.text = widget.product.quantity!.toString();
      controllerProductDescription.text = widget.product.description.toString();
      controllerProductStatus.text = widget.product.status!;
      controllerTimeRequired.text = widget.product.timeRequired!.toString();
      isSelected = widget.product.flg == 0 ? false : true;
    }
    print("workorder id in add workorder----------> ${product_id}");
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Product",
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
                                      Text("Product Code",
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
                                      controller: controllerProductCode,
                                      decoration: InputDecoration(
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 13),
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
                                      Text("Product name",
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
                                      controller: controllerProductName,
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
                                      controller: controllerProductQuantity,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
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
                                      Text("Description",
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
                                      controller: controllerProductDescription,
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
                                      controller: controllerProductStatus,
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
                                      Text("Time Required",
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
                                      controller: controllerTimeRequired,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      isSelected = !isSelected;
                                      widget.product.flg = isSelected == false ? 0 : 1;

                                    });
                                  },
                                ),
                                Text("Is Active",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.0,
                                        color: Colors.black)),
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
                height: 280,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
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
                                        Text("Template Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11.0,
                                                color: Colors.blueAccent)),
                                        Text('*',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 22.0),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextField(
                                        controller: controllerTemplate,
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
                                        Text("File Path",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11.0,
                                                color: Colors.blueAccent)),
                                        Text('*',
                                            style:
                                                TextStyle(color: Colors.red)),
                                        Container(
                                          height: 30.0,
                                          width: 30.0,
                                          child: GestureDetector(
                                            onTap: () async {
                                              var picked = await FilePicker
                                                  .platform
                                                  .pickFiles();

                                              if (picked != null) {
                                                print(picked.files.first.name);
                                              }
                                              if (picked != null) {
                                                controllerFilepath.text = picked
                                                    .files.first.name
                                                    .toString();
                                              }
                                            },
                                            child: Icon(
                                              Icons.folder,
                                              size: 15.0,
                                              color: Colors.orangeAccent,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30.0,
                                          width: 30.0,
                                          child: GestureDetector(
                                            onTap: () async {
                                              openFile();
                                              /*    try {
                                                final String path =
                                                    (await getApplicationSupportDirectory())
                                                        .path;
                                                final String fileName =
                                                    '${path/picked.files.first.name}' ;
                                                OpenFile.open(fileName);
                                              } catch (e) {
                                                print(e);
                                              }*/
                                            },
                                            child: Icon(
                                              Icons.open_in_new,
                                              size: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 22.0),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextField(
                                        controller: controllerFilepath,
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
                                        controller: controllerTemplateremarks,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            shape: const CircleBorder(),
                            color: Colors.black,
                            padding: const EdgeInsets.all(10),
                            onPressed: () {
                              if (templatevalidateFields()) {
                                ref.read(addTemplateNotifier.notifier)
                                    .addTemplate({
                                  "template_id": 0,
                                  "template_name": controllerTemplate.text,
                                  "file_path": controllerFilepath.text,
                                  "created_by": 1,
                                  "updated_by": 1,
                                  "created_date": null,
                                  "updated_date": null,
                                  "flg": 1,
                                  "remarks": controllerTemplateremarks.text
                                });
                              }
                            /*  setState(() {
                                if (templatevalidateFields()) {
                                  Templatemodel temp = Templatemodel(
                                      templatename: controllerTemplate.text,
                                      filepath: controllerFilepath.text,
                                      templateremarks:
                                          controllerTemplateremarks.text);
                                  Templatelist.add(temp);
                                }
                              });*/

                            },
                            child: const Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.white,
                            ),
                          )
                        ],
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
                              child: Text("Template Name",
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
                              child: Text("File path",
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
              SizedBox(
                height: 250,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xffcbdff2),
                  elevation: 20,
                  child: Consumer(
                    builder: (context, ref,child) {
                      return ref.watch(getTemplateNotifier).when(data: (data){
                        return ListView.builder(
                            itemCount: data.length,
                            //Templatelist.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return InkWell(
                                onTap: (){
                                  controllerTemplate.text = data[index].templateName.toString();
                                  controllerFilepath.text = data[index].filePath.toString();
                                  controllerTemplateremarks.text = data[index].remarks.toString();
                                },
                                child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(data[index].templateName.toString(),
                                                 // Templatelist[index].templatename.toString(),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 10.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(data[index].filePath.toString(),
                                                  //Templatelist[index].filepath.toString(),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 10.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                // Product().deleteProduct(datamodels[index]);
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    )),
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          if (validateFields()) {
                            ref.read(addProductNotifier.notifier).addProducts({
                              "product_name": controllerProductName.text,
                              "product_code": controllerProductCode.text,
                              "description": controllerProductDescription.text,
                              "template_id": 0,
                              "quantity":
                                  int.parse(controllerProductQuantity.text),
                              "status": controllerProductStatus.text,
                              "created_by": 1,
                              "updated_by": 1,
                              "created_date": null,
                              "updated_date": null,
                              "flg": isSelected ? 0 : 1,
                              "remarks": controllerRemarks.text,
                              "time_required":
                                  int.parse(controllerTimeRequired.text),
                              "mac_address": null
                            });

                            clearText();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Add Product ".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                        /*  product_code: controllerProductCode.text,
                          product_name: controllerProductName.text,
                          quantity: controllerProductQuantity.text,
                          status: controllerProductStatus.text,
                          time_required: controllerTimeRequired.text,
                          flg: isSelected;*/
                          ref
                              .read(updateProductsNotifier.notifier)
                              .updatetProduct({
                              "product_Id": product_id,
                              "product_name": controllerProductName.text,
                              "product_code": controllerProductCode.text,
                              "description": controllerProductDescription.text,
                              "template_id": 1,
                              "quantity": int.parse(controllerProductQuantity.text),
                              "status": controllerProductStatus.text,
                              "updated_by": 1,
                              "updated_date": null,
                              "flg": widget.product.flg,
                              "remarks": controllerRemarks.text,
                              "time_required": int.parse(controllerTimeRequired.text),
                              "mac_address": null
                          });
                          clearText();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Edit Product".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateFields() {
    if (controllerProductCode.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Code should not be empty',
          context: context);
      return false;
    } else if (controllerProductName.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Name should not be empty',
          context: context);
      return false;
    } else if (controllerProductQuantity.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Quantity should not be empty',
          context: context);
      return false;
    } else if (controllerProductDescription.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Description should not be empty',
          context: context);
      return false;
    } else if (controllerProductStatus.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Status should not be empty',
          context: context);
      return false;
    } else if (controllerTimeRequired.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Time Required should not be empty',
          context: context);
      return false;
    }
    return true;
  }

  bool templatevalidateFields() {
    if (controllerTemplate.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Template Name should not be empty',
          context: context);
      return false;
    } else if (controllerFilepath.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'File Path should not be empty',
          context: context);
      return false;
    }
    return true;
  }

  Future<void> openFile() async {
    String? filePath = r'/storage/emulated/0/update.apk';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path;
    } else {
      // User canceled the picker
    }
    final _result = await OpenFile.open(filePath);
    print(_result);

    setState(() {
      var _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

    final file = result.files.first;

    _openFile(file);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

/*  _selectFile() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    print("FILE RESULT-------> $fileResult");

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        print("${fileResult.files.first.name}");
        selectedImageInByte = fileResult.files.first.bytes;
        selectedImage=fileResult.paths.first;
        print("selected images=======> ${fileResult.paths.first}");

      });
    }
    print(selctFile);
  }*/

}
