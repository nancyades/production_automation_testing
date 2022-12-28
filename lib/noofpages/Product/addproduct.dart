import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Helper/AppClass.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool isSelected = false;

  TextEditingController controllerProductCode = TextEditingController();
  TextEditingController controllerProductName = TextEditingController();
  TextEditingController controllerProductQuantity = TextEditingController();
  TextEditingController controllerProductDescription = TextEditingController();
  TextEditingController controllerProductStatus = TextEditingController();
  TextEditingController controllerTimeRequired = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();


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
                                      Text("Product Code",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                      Text('*',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0,),
                                  child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: controllerProductCode,
                                      decoration: InputDecoration(
                                          filled: true,
                                          hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
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
                                      Text("Product name",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                      Text('*',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                  child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: controllerProductName,
                                      decoration: InputDecoration(
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
                                      Text("Quantity",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                      Text('*',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0),
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
                                      Text("Description",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                      Text('*',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                  child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: controllerProductDescription,
                                      decoration: InputDecoration(
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
                                      Text('*',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                  child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: controllerProductStatus,
                                      decoration: InputDecoration(
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
                                      Text("Remarks",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0),
                                  child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: controllerRemarks,
                                      decoration: InputDecoration(
                                          filled: true,
                                          hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                          //hintText: "Remarks",
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
                                      Text("Time Required",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0,color: Colors.blueAccent )),
                                      Text('*',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 22.0),
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
                                          hintStyle: TextStyle(color: Colors.grey[800],fontSize: 13),
                                          //hintText: "Remarks",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Row(
                              children: [
                                Center(
                                    child: Text("Is Active",
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
                        ],
                      ),
                    ),


                  ],
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
                          child: Text(
                              "Add Product ".toUpperCase(),
                              style: TextStyle(fontSize: 14)
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                        onPressed: () {
                          if(validateFields()){

                          }
                        }
                    ),
                    ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Edit Product".toUpperCase(),
                              style: TextStyle(fontSize: 14)
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                        onPressed: () => null
                    ),
                  ],
                ),

              )],
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
    }else if(controllerProductName.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Product Name should not be empty',
          context: context);
      return false;
    }else if (controllerProductQuantity.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Quantity should not be empty',
          context: context);
      return false;
    }
    else if (controllerProductDescription.text.isEmpty) {
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
    }  else if (controllerTimeRequired.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Time Required should not be empty',
          context: context);
      return false;
    }
    return true;
  }
}
