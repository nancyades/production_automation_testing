import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/productmodel.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/usermodel.dart';
import 'package:production_automation_testing/Model/APIModel/templatemodel.dart';
import 'package:production_automation_testing/Provider/post_provider/product_provider.dart';
import '../../Helper/AppClass.dart';
import '../../Helper/helper.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Model/templatemodel.dart';
import '../../Provider/changenotifier/widget_notifier.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/post_provider/template_provider.dart';
import '../../res/appColors.dart';
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
  bool isSelected = true;

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
  DateTime? date = DateTime.now();

  String selctFile = '';
  Uint8List? selectedImageInByte;
  String? selectedImage;
  int? product_id;
  int? template_product_id;

  bool searchdropdown = true;

  bool refresh = false;

  bool saveAndTemp = false;
  int i = 0;

  //widget.product.status = "";
  List<String> status = [
    'Approved',
    //'Verified',
    //'Created',
    'Rejected',
  ];
  List<String> designadminstatus = [
    'Verified',
    'Rejected',
  ];

  String designadminstatusselection = "Verified";

  List<Template> temp = [];
  List<Template> listoftemplate = [];
  List<Template> listofupdatetemplate = [];
  Template? lasttempid;

  bool _isLoading = false;
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _userAborted = false;

  var passingTemplateId;
  final bool _multiPick = false;
  final FileType _pickingType = FileType.any;
  File? selectedFile;

  String tempproduct_id="";


  @override
  void initState() {
    super.initState();
    ref.refresh(getTemplateNotifier);
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

  void clearTemplate() {
    controllerTemplate.clear();
    controllerFilepath.clear();
    controllerTemplateremarks.clear();
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

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;

    _isLoading = false;
    _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    print(_fileName!.split('.')[1].split(')')[0]);
    print(_fileName);
    _userAborted = _paths == null;
  }

  void _logException(String message) {
    print(message);
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  var datum;

  @override
  Widget build(BuildContext context) {
    if (Helper.editvalue == "editedvalue") {
      if (widget.product != null) {
        product_id = widget.product.productId;
        controllerProductCode.text = widget.product.productCode!;
        controllerProductName.text = widget.product.productName!.toString();
        controllerProductQuantity.text = widget.product.quantity!.toString();
        controllerProductDescription.text =
            widget.product.description.toString();
        controllerProductStatus.text = widget.product.status!;
        controllerTimeRequired.text = widget.product.timeRequired!.toString();
        controllerRemarks.text = widget.product.remarks!.toString();
        isSelected = widget.product.flg == 0 ? false : true;
        passingTemplateId = widget.product.template![0].templateId.toString();

        if(controllerProductStatus.text == "Created"){
          designadminstatusselection = "Verified";
        }else{
          designadminstatusselection = controllerProductStatus.text;
        } if(controllerProductStatus.text == "Verified"){
          if(Helper.sharedRoleId == "Design Admin"){
            designadminstatusselection = widget.product.status.toString();
          }
          widget.product.status = "Approved";
      }else{
          widget.product.status = controllerProductStatus.text;
        }

      }
    }

    //print("STATUS----> ${widget.product.status}");
    //print("TEMPLATEID----> ${widget.product.template![0].templateId}");

    return ref.watch(getProductNotifier).when(data: (data) {
      print("role-----------> ${Helper.sharedRoleId}");


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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Product",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),
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
                                            style: TextStyle(
                                                color: Colors.red)),
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
                                            style: TextStyle(
                                                color: Colors.red)),
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
                                            style: TextStyle(
                                                color: Colors.red)),
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
                                            style: TextStyle(
                                                color: Colors.red)),
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
                      Helper.sharedRoleId == "Design User" ? Column(children: [
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: Row(
                                  children: [
                                    Consumer(builder: (context, ref, child) {
                                      ref.watch(counterModelProvider);
                                      return Checkbox(
                                        checkColor: AppColors.white,
                                        activeColor: Colors.blue,
                                        value: isSelected,
                                        onChanged: (value) {
                                          ref
                                              .read(
                                              counterModelProvider.notifier)
                                              .press();
                                          isSelected = value!;
                                          widget.product.flg =
                                          isSelected == false ? 0 : 1;
                                        },
                                      );
                                    }),
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
                      ],)
                          :  Helper.sharedRoleId == "Design Admin"
                      ? Column(children: [
                        (){
                          if(widget.product.productCode != null){
                            if(controllerProductStatus.text == "Created"){
                             return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              right: 15.0),
                                          child: DropdownButton(
                                            icon: Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 25.0),
                                              child: Icon(Icons
                                                  .keyboard_arrow_down),
                                            ),
                                            items: designadminstatus.map<
                                                DropdownMenuItem<
                                                    String>>(
                                                    (String setlist) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: setlist,
                                                    child: Text(
                                                        setlist
                                                            .toString()),
                                                  );
                                                }).toList(),
                                            value: designadminstatusselection,
                                            onChanged: (item) {
                                              ref
                                                  .read(counterModelProvider.notifier).press();
                                              designadminstatusselection =
                                                  item.toString();

                                              controllerProductStatus.text = item.toString();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            else if(controllerProductStatus.text == "Verified"){
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              right: 15.0),
                                          child: DropdownButton(
                                            icon: Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 25.0),
                                              child: Icon(Icons
                                                  .keyboard_arrow_down),
                                            ),
                                            items: designadminstatus.map<
                                                DropdownMenuItem<
                                                    String>>(
                                                    (String setlist) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: setlist,
                                                    child: Text(
                                                        setlist
                                                            .toString()),
                                                  );
                                                }).toList(),
                                            value: designadminstatusselection,
                                            onChanged: (item) {
                                              ref
                                                  .read(counterModelProvider.notifier).press();
                                              designadminstatusselection =
                                                  item.toString();

                                              controllerProductStatus.text = item.toString();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            else{
                              return  Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18.0),
                                            child:

                                            Row(
                                              children: [
                                                Text("Status: ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 11.0,
                                                        color: Colors.blueAccent)),

                                                Text(widget.product.status.toString() ,
                                                    style: TextStyle(color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }


                          }else {
                            return Column(
                                children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0),
                                          child: Row(
                                            children: [
                                              Text("Status",
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
                                        Consumer(builder: (context, ref, child) {
                                          ref.watch(counterModelProvider);
                                          return Visibility(
                                            visible: searchdropdown,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 20.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            right: 15.0),
                                                        child: DropdownButton(
                                                          icon: Padding(
                                                            padding:
                                                            const EdgeInsets.only(
                                                                left: 25.0),
                                                            child: Icon(Icons
                                                                .keyboard_arrow_down),
                                                          ),
                                                          items: designadminstatus.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                                  (String setlist) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: setlist,
                                                                  child: Text(
                                                                      setlist
                                                                          .toString()),
                                                                );
                                                              }).toList(),
                                                          value: designadminstatusselection,
                                                          onChanged: (item) {
                                                            ref
                                                                .read(counterModelProvider.notifier).press();
                                                            designadminstatusselection =
                                                                item.toString();

                                                            controllerProductStatus.text = item.toString();
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
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30.0, right: 30.0),
                                        child: Row(
                                          children: [
                                            Consumer(builder: (context, ref, child) {
                                              ref.watch(counterModelProvider);
                                              return Checkbox(
                                                checkColor: AppColors.white,
                                                activeColor: Colors.blue,
                                                value: isSelected,
                                                onChanged: (value) {
                                                  ref
                                                      .read(
                                                      counterModelProvider.notifier)
                                                      .press();
                                                  isSelected = value!;
                                                  widget.product.flg =
                                                  isSelected == false ? 0 : 1;
                                                },
                                              );
                                            }),
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
                            ]
                            );
                          }
                        }(),


                      ])
                      : Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0),
                                      child: Row(
                                        children: [
                                          Text("Status",
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
                                    Consumer(builder: (context, ref, child) {
                                      ref.watch(counterModelProvider);
                                      return Visibility(
                                        visible: searchdropdown,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
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
                                                                  setlist
                                                                      .toString()),
                                                            );
                                                          }).toList(),
                                                      // value: selectRole,
                                                      // onChanged: (item) {
                                                      //   setState(() {
                                                      //     selectRole = item.toString();
                                                      //
                                                      //   });
                                                      // },
                                                      value:
                                                      widget.product.status,
                                                      onChanged: (item) {
                                                        ref
                                                            .read(
                                                            counterModelProvider
                                                                .notifier)
                                                            .press();
                                                        widget.product.status =
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
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: Row(
                                  children: [
                                    Consumer(builder: (context, ref, child) {
                                      ref.watch(counterModelProvider);
                                      return Checkbox(
                                        checkColor: AppColors.white,
                                        activeColor: Colors.blue,
                                        value: isSelected,
                                        onChanged: (value) {
                                          ref.read(
                                              counterModelProvider.notifier)
                                              .press();
                                          isSelected = value!;
                                          widget.product.flg =
                                          isSelected == false ? 0 : 1;
                                        },
                                      );
                                    }),
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
                      ]),

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
                                            style: TextStyle(
                                                color: Colors.red)),
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
                    ],
                  ),
                ),
                /* SizedBox(
                  height: 280,
                  child: Card(
                    color: Color(0xffd7e7fa),
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
                                                uploadFile();
                                              },
                                              child: Icon(
                                                Icons.folder,
                                                size: 15.0,
                                                color: Colors.orangeAccent,
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
                                setState(() {
                                  refresh = true;
                                  if (templatevalidateFields()) {

                                        setState(() {

                                        });
                                    var template = temp.where((element) => element.templateName ==
                                        controllerTemplate.text)
                                        .toList();
                                    print("tem----------> $template");
                                    if (template.isEmpty) {
                                      ref
                                          .read(addTemplateNotifier.notifier)
                                          .addTemplate({
                                        "template_id": 0,
                                        "template_name": controllerTemplate.text,
                                        "file_path": controllerFilepath.text,
                                        "created_by": 1,
                                        "updated_by": 1,
                                        "created_date": "2023-04-20",
                                        "updated_date": "2023-04-20",
                                        "flg": 1,
                                        "remarks": controllerTemplateremarks.text,
                                        "product_id": product_id,
                                      });

                                    } else if (template[0].templateName ==
                                        controllerTemplate.text) {
                                      showDialog(
                                          context: context,
                                          builder: (c) => AlertDialog(
                                            title: Text("Template!"),
                                            content:
                                            Text("Tmplate already exists"),
                                            actions: [
                                              TextButton(
                                                  child: const Text('Ok'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ));
                                    } else {
                                      ref
                                          .read(addTemplateNotifier.notifier)
                                          .addTemplate({
                                        "template_id": 0,
                                        "template_name": controllerTemplate.text,
                                        "file_path": controllerFilepath.text,
                                        "created_by": 1,
                                        "updated_by": 1,
                                        "created_date": "2023-04-20",
                                        "updated_date": "2023-04-20",
                                        "flg": 1,
                                        "remarks": controllerTemplateremarks.text,
                                        "product_id": product_id,
                                      });
                                    }
                                   // ref.refresh(getTemplateNotifier);

                                    Helper.editvalue = "notpassvalue";
                                    Template pro = Template(
                                      templateId: 0,
                                      templateName: controllerTemplate.text,
                                      filePath: controllerFilepath.text,
                                      createdBy: 1,
                                      updatedBy: 1,
                                      createdDate: "2023-04-20",
                                      updatedDate: "2023-04-20",
                                      flg: 1,
                                      remarks: controllerTemplateremarks.text,
                                      productid: product_id.toString(),

                                    );

                                      listoftemplate.add(pro);





                                    clearTemplate();

                                  }

                                });

                              */
                /*  if (templatevalidateFields()) {
                                  var template = temp
                                      .where((element) =>
                                  element.templateName ==
                                      controllerTemplate.text)
                                      .toList();
                                  print("tem----------> $template");
                                  if (template.isEmpty) {
                                    ref
                                        .read(addTemplateNotifier.notifier)
                                        .addTemplate({
                                      "template_id": 0,
                                      "template_name": controllerTemplate.text,
                                      "file_path": controllerFilepath.text,
                                      "created_by": 1,
                                      "updated_by": 1,
                                      "created_date": "2023-04-20",
                                      "updated_date": "2023-04-20",
                                      "flg": 1,
                                      "remarks": controllerTemplateremarks.text,
                                      "product_id": product_id,
                                    });

                                    clearTemplate();
                                  } else if (template[0].templateName ==
                                      controllerTemplate.text) {
                                    showDialog(
                                        context: context,
                                        builder: (c) => AlertDialog(
                                          title: Text("Template!"),
                                          content:
                                          Text("Tmplate already exists"),
                                          actions: [
                                            TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ));
                                  } else {
                                    ref
                                        .read(addTemplateNotifier.notifier)
                                        .addTemplate({
                                      "template_id": 0,
                                      "template_name": controllerTemplate.text,
                                      "file_path": controllerFilepath.text,
                                      "created_by": 1,
                                      "updated_by": 1,
                                      "created_date": "2023-04-20",
                                      "updated_date": "2023-04-20",
                                      "flg": 1,
                                      "remarks": controllerTemplateremarks.text,
                                      "product_id": product_id,
                                    });
                                    clearTemplate();
                                  }

                                }*/
                /*               },
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
                ),*/




                (widget.product.productName == "")
                    ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: saveAndTemp == false ?  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
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
                            if (validateFields()) {

                              var productname = data.where((element) => element.productName.toString() == controllerProductName.text).toList();

                              if(productname.isNotEmpty){
                                if(productname[0].productName ==  controllerProductName.text){
                                  final snackBar = SnackBar(
                                    content:  Text(
                                        "Product Name is Already Exsist"),
                                    backgroundColor:
                                    (Colors.black),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              }
                              if(Helper.sharedRoleId == "Design User"){
                                ref
                                    .read(addProductNotifier.notifier)
                                    .addProducts({
                                  "product_name": controllerProductName.text,
                                  "product_code": controllerProductCode.text,
                                  "description":
                                  controllerProductDescription.text,
                                  "template_id": 0,
                                  "quantity":
                                  int.parse(controllerProductQuantity.text),
                                  "status": "Created",
                                  "created_by": Helper.shareduserid.toString(),
                                  "updated_by": "0",
                                  "created_date": date.toString().split(' ')[0],
                                  "updated_date": null,
                                  "flg": isSelected ? 1 : 0,
                                  "remarks": controllerRemarks.text,
                                  "time_required":
                                  int.parse(controllerTimeRequired.text),
                                  "mac_address": null,
                                  // "template ": (listoftemplate),
                                });

                              }else{
                                ref
                                    .read(addProductNotifier.notifier)
                                    .addProducts({
                                  "product_name": controllerProductName.text,
                                  "product_code": controllerProductCode.text,
                                  "description":
                                  controllerProductDescription.text,
                                  "template_id": 0,
                                  "quantity":
                                  int.parse(controllerProductQuantity.text),
                                  "status": widget.product.status,
                                  "created_by": Helper.shareduserid.toString(),
                                  "updated_by": "0",
                                  "created_date": date.toString().split(' ')[0],
                                  "updated_date": null,
                                  "flg": isSelected ? 1 : 0,
                                  "remarks": controllerRemarks.text,
                                  "time_required":
                                  int.parse(controllerTimeRequired.text),
                                  "mac_address": null,
                                  // "template ": (listoftemplate),
                                });

                              }









                              print("helper class---------> ${Helper.product_id.toString()}");




                              if(Helper.product_id != null){

                                if(Helper.product_id.toString() == "Product Code is Already Exsist"){
                                  final snackBar = SnackBar(
                                    content:  Text(
                                        Helper.product_id),
                                    backgroundColor:
                                    (Colors.black),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else if(Helper.product_id.toString().split('-')[1].toString() == " Inserted Successfully!") {
                                  setState(() {
                                    saveAndTemp = true;
                                  });
                                  print("helper ---------> ${Helper.product_id.toString().split('-')[1].toString() }");
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Product added successfully! Now add template for product'),
                                    backgroundColor:
                                    (Colors.black),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                 // clearText();
                                }
                              }
                              else if(Helper.product_id == null ){
                                setState(() {
                                  saveAndTemp = true;
                                });
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Product added successfully! Now add template for product'),
                                  backgroundColor:
                                  (Colors.black),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                               // clearText();

                              }







                             // clearText();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Save".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          )),

                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
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
                            showDialog(
                                context: context,
                                builder: (c) =>
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Template'),
                                                IconButton(onPressed: (){
                                                  Navigator.pop(context);
                                                  listoftemplate.clear();
                                                  clearTemplate();





                                                }, icon: Icon(Icons.close))

                                              ],
                                            ),
                                            //content: Text("msg"),
                                            actions: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 660,
                                                    height: 350,
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Card(
                                                            color: Color(0xffd7e7fa),
                                                            elevation: 10,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(5.0),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(
                                                                      10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 18.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                      "Template Name",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight
                                                                                              .w600,
                                                                                          fontSize: 11.0,
                                                                                          color: Colors
                                                                                              .blueAccent)),
                                                                                  Text('*',
                                                                                      style:
                                                                                      TextStyle(
                                                                                          color: Colors
                                                                                              .red)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 15.0,
                                                                                  right: 22.0),
                                                                              child: SizedBox(
                                                                                height: 35,
                                                                                child: TextField(
                                                                                  controller: controllerTemplate,
                                                                                  decoration: InputDecoration(
                                                                                      filled: true,
                                                                                      hintStyle: TextStyle(
                                                                                          color: Colors
                                                                                              .grey[800],
                                                                                          fontSize: 13),
                                                                                      //hintText: "Status",
                                                                                      fillColor: Colors
                                                                                          .white70),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .w400,
                                                                                      fontSize: 13.0,
                                                                                      color: Colors
                                                                                          .black),
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
                                                                  padding: const EdgeInsets.all(
                                                                      10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 18.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                      "File Path",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight
                                                                                              .w600,
                                                                                          fontSize: 11.0,
                                                                                          color: Colors
                                                                                              .blueAccent)),
                                                                                  Text('*',
                                                                                      style:
                                                                                      TextStyle(
                                                                                          color: Colors
                                                                                              .red)),
                                                                                  Container(
                                                                                    height: 30.0,
                                                                                    width: 30.0,
                                                                                    child: GestureDetector(
                                                                                      onTap: () async {
                                                                                        uploadFile();
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons
                                                                                            .folder,
                                                                                        size: 15.0,
                                                                                        color: Colors
                                                                                            .orangeAccent,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 15.0,
                                                                                  right: 22.0),
                                                                              child: SizedBox(
                                                                                height: 35,
                                                                                child: TextField(
                                                                                  controller: controllerFilepath,
                                                                                  decoration: InputDecoration(
                                                                                      filled: true,
                                                                                      hintStyle: TextStyle(
                                                                                          color: Colors
                                                                                              .grey[800],
                                                                                          fontSize: 13),
                                                                                      //hintText: "Status",
                                                                                      fillColor: Colors
                                                                                          .white70),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .w400,
                                                                                      fontSize: 13.0,
                                                                                      color: Colors
                                                                                          .black),
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
                                                                  padding: const EdgeInsets.all(
                                                                      10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 18.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                      "Remarks",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight
                                                                                              .w600,
                                                                                          fontSize: 11.0,
                                                                                          color: Colors
                                                                                              .blueAccent)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 15.0,
                                                                                  right: 22.0),
                                                                              child: SizedBox(
                                                                                height: 35,
                                                                                child: TextField(
                                                                                  controller: controllerTemplateremarks,
                                                                                  decoration: InputDecoration(
                                                                                      filled: true,
                                                                                      hintStyle: TextStyle(
                                                                                          color: Colors
                                                                                              .grey[800],
                                                                                          fontSize: 13),
                                                                                      //hintText: "Status",
                                                                                      fillColor: Colors
                                                                                          .white70),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .w400,
                                                                                      fontSize: 13.0,
                                                                                      color: Colors
                                                                                          .black),
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
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    MaterialButton(
                                                                      shape: const CircleBorder(),
                                                                      color: Colors.black,
                                                                      padding: const EdgeInsets
                                                                          .all(10),
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          refresh = true;
                                                                          if (templatevalidateFields()) {

                                                                            var template = temp
                                                                                .where((
                                                                                element) =>
                                                                            element
                                                                                .templateName ==
                                                                                controllerTemplate
                                                                                    .text)
                                                                                .toList();
                                                                            print(
                                                                                "tem----------> $template");
                                                                            if (template
                                                                                .isEmpty) {
                                                                              ref
                                                                                  .read(
                                                                                  addTemplateNotifier
                                                                                      .notifier)
                                                                                  .addTemplate({
                                                                                "template_id": 0,
                                                                                "template_name": controllerTemplate
                                                                                    .text,
                                                                                "file_path": controllerFilepath
                                                                                    .text,
                                                                                "created_by": Helper.shareduserid.toString(),
                                                                                "updated_by": "0",
                                                                                "created_date": "2023-04-20",
                                                                                "updated_date": "2023-04-20",
                                                                                "flg": 1,
                                                                                "remarks": controllerTemplateremarks
                                                                                    .text,
                                                                                "product_id": Helper.product_id.toString().split('-')[0].toString(),
                                                                              });
                                                                            }
                                                                            /* if (template[0].templateName == controllerTemplate.text) {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (
                                                                                    c) =>
                                                                                    AlertDialog(
                                                                                      title: Text(
                                                                                          "Template!"),
                                                                                      content:
                                                                                      Text(
                                                                                          "Tmplate already exists"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                            child: const Text(
                                                                                                'Ok'),
                                                                                            onPressed: () {
                                                                                              Navigator
                                                                                                  .pop(
                                                                                                  context);
                                                                                            }),
                                                                                      ],
                                                                                    ));
                                                                          } */
                                                                            else {
                                                                              ref
                                                                                  .read(
                                                                                  addTemplateNotifier
                                                                                      .notifier)
                                                                                  .addTemplate({
                                                                                "template_id": 0,
                                                                                "template_name": controllerTemplate
                                                                                    .text,
                                                                                "file_path": controllerFilepath
                                                                                    .text,
                                                                                "created_by": Helper.shareduserid.toString(),
                                                                                "updated_by": "0",
                                                                                "created_date": "2023-04-20",
                                                                                "updated_date": "2023-04-20",
                                                                                "flg": 1,
                                                                                "remarks": controllerTemplateremarks
                                                                                    .text,
                                                                                "product_id": Helper.product_id.toString().split('-')[0].toString(),
                                                                              });
                                                                            }
                                                                            // ref.refresh(getTemplateNotifier);

                                                                            Helper.editvalue = "notpassvalue";
                                                                            Template pro = Template(
                                                                              templateId: 0,
                                                                              templateName: controllerTemplate.text,
                                                                              filePath: controllerFilepath.text,
                                                                              createdBy: Helper.shareduserid.toString(),
                                                                              updatedBy: "0",
                                                                              createdDate: "2023-04-20",
                                                                              updatedDate: "2023-04-20",
                                                                              flg: 1,
                                                                              remarks: controllerTemplateremarks.text,
                                                                              productid: Helper.product_id.toString().split('-')[0].toString().toString(),

                                                                            );

                                                                            listoftemplate.add(pro);


                                                                            clearTemplate();
                                                                            clearText();
                                                                          }
                                                                        });
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
                                                                  IconButton(
                                                                      highlightColor: Colors.amberAccent,
                                                                      onPressed: () {
                                                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                          ref.refresh(getTemplateNotifier);
                                                                        });
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.refresh,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10.0,
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
                                                              child: Consumer(builder: (context, ref, child) {
                                                                return ref.watch(getTemplateNotifier).when(data: (data) {
                                                                  temp = data;
                                                                  lasttempid = temp.last;
                                                                  return ListView.builder(
                                                                      itemCount:
                                                                      //data.length,
                                                                      listoftemplate.length,

                                                                      //Templatelist.length,
                                                                      itemBuilder: (BuildContext ctxt, int index) {


                                                                        return InkWell(
                                                                          onTap: () {
                                                                            /* controllerTemplate.text =
                                                                              listoftemplate[index].templateName
                                                                                  .toString();

                                                                          controllerFilepath.text =
                                                                              listoftemplate[index].filePath.toString();

                                                                          controllerTemplateremarks.text =
                                                                              listoftemplate[index].remarks.toString();*/

                                                                          },
                                                                          child: Visibility(
                                                                            visible: data[index].flg == 1 ? true : false,
                                                                            child: Card(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                      left: 15.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(
                                                                                              8.0),
                                                                                          child: Text(
                                                                                            //data[index].templateName.toString(),
                                                                                              listoftemplate[index]
                                                                                                  .templateName
                                                                                                  .toString(),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight: FontWeight
                                                                                                      .w300,
                                                                                                  fontSize: 10.0,
                                                                                                  color: Colors.black)),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(
                                                                                              8.0),
                                                                                          child: Text(
                                                                                            //data[index].filePath.toString(),
                                                                                              listoftemplate[index]
                                                                                                  .filePath.toString(),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight: FontWeight
                                                                                                      .w300,
                                                                                                  fontSize: 10.0,
                                                                                                  color: Colors.black)),
                                                                                        ),
                                                                                      ),
                                                                                      IconButton(
                                                                                          onPressed: () {
                                                                                            /* ref.read(updateTemplateNotifier.notifier).updatetTemplate({
                                                          "template_id":
                                                          data[index].templateId,
                                                          "template_name": data[index]
                                                              .templateName
                                                              .toString(),
                                                          "file_path": data[index]
                                                              .filePath
                                                              .toString(),
                                                          "created_by":
                                                          data[index].createdBy,
                                                          "updated_by":
                                                          data[index].updatedBy,
                                                          "created_date": data[index]
                                                              .createdDate
                                                              .toString(),
                                                          "updated_date": data[index]
                                                              .updatedDate
                                                              .toString(),
                                                          "flg": 0,
                                                          "remarks": data[index]
                                                              .remarks
                                                              .toString(),
                                                          "product_id": product_id,
                                                        });
                                                        final snackBar = SnackBar(
                                                          content: const Text(
                                                              'Template deleted successfully'),
                                                          backgroundColor: (Colors.black),
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(snackBar);
*/

                                                                                            ref.read(
                                                                                                updateTemplateNotifier
                                                                                                    .notifier)
                                                                                                .updatetTemplate({
                                                                                              "template_id":
                                                                                              listoftemplate[index]
                                                                                                  .templateId,
                                                                                              "template_name": listoftemplate[index]
                                                                                                  .templateName
                                                                                                  .toString(),
                                                                                              "file_path": listoftemplate[index]
                                                                                                  .filePath
                                                                                                  .toString(),
                                                                                              "created_by":
                                                                                              listoftemplate[index]
                                                                                                  .createdBy,
                                                                                              "updated_by":
                                                                                              listoftemplate[index]
                                                                                                  .updatedBy,
                                                                                              "created_date": listoftemplate[index]
                                                                                                  .createdDate
                                                                                                  .toString(),
                                                                                              "updated_date": listoftemplate[index]
                                                                                                  .updatedDate
                                                                                                  .toString(),
                                                                                              "flg": 0,
                                                                                              "remarks": listoftemplate[index]
                                                                                                  .remarks
                                                                                                  .toString(),
                                                                                              "product_id": product_id,
                                                                                            });
                                                                                            final snackBar = SnackBar(
                                                                                              content: const Text(
                                                                                                  'Template deleted successfully'),
                                                                                              backgroundColor: (Colors
                                                                                                  .black),
                                                                                            );
                                                                                            ScaffoldMessenger.of(context)
                                                                                                .showSnackBar(snackBar);
                                                                                          },
                                                                                          icon: Icon(Icons.delete))
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        );
                                                                      });
                                                                }, error: (e, s) {
                                                                  return Text(e.toString());
                                                                }, loading: () {
                                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                                });
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Template".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          )),
                    ],
                  )
                )
                    : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
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
                            if(Helper.sharedRoleId == "Design User"){
                              ref
                                  .read(updateProductsNotifier.notifier)
                                  .updatetProduct({
                                "product_Id": product_id,
                                "product_name": controllerProductName.text,
                                "product_code": controllerProductCode.text,
                                "description": controllerProductDescription.text,
                                "template_id": widget.product.template![0].templateId,
                                "quantity": int.parse(controllerProductQuantity.text),
                                "status": "Created",
                                "updated_by": Helper.shareduserid.toString(),
                                "updated_date": date.toString().split(' ')[0],
                                "flg": widget.product.flg,
                                "remarks": controllerRemarks.text,
                                "time_required":
                                int.parse(controllerTimeRequired.text),
                                "mac_address": null
                              });
                              clearText();
                            }else if(Helper.sharedRoleId == "Design Admin"){
                              ref
                                  .read(updateProductsNotifier.notifier)
                                  .updatetProduct({
                                "product_Id": product_id,
                                "product_name": controllerProductName.text,
                                "product_code": controllerProductCode.text,
                                "description": controllerProductDescription.text,
                                "template_id": widget.product.template![0].templateId,
                                "quantity": int.parse(controllerProductQuantity.text),
                                "status": designadminstatusselection,
                                "updated_by": Helper.shareduserid.toString(),
                                "updated_date": date.toString().split(' ')[0],
                                "flg": widget.product.flg,
                                "remarks": controllerRemarks.text,
                                "time_required":
                                int.parse(controllerTimeRequired.text),
                                "mac_address": null
                              });
                              clearText();
                            }
                            ref
                                .read(updateProductsNotifier.notifier)
                                .updatetProduct({
                              "product_Id": product_id,
                              "product_name": controllerProductName.text,
                              "product_code": controllerProductCode.text,
                              "description": controllerProductDescription.text,
                              "template_id": widget.product.template![0].templateId,
                              "quantity": int.parse(controllerProductQuantity.text.toString()),
                              "status": widget.product.status!,
                              "updated_by": Helper.shareduserid.toString(),
                              "updated_date": date.toString().split(' ')[0],
                              "flg": widget.product.flg,
                              "remarks": controllerRemarks.text,
                              "time_required":
                              int.parse(controllerTimeRequired.text),
                              "mac_address": null
                            });
                            clearText();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("UPDATE".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          )),
                      ElevatedButton(
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
                            showDialog(
                                context: context,
                                builder: (c) =>
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Template'),
                                                IconButton(onPressed: (){
                                                  Navigator.pop(context);
                                                  clearTemplate();
                                                }, icon: Icon(Icons.close))

                                              ],
                                            ),
                                            //content: Text("msg"),
                                            actions: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 660,
                                                    height: 350,
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Card(
                                                            color: Color(0xffd7e7fa),
                                                            elevation: 10,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(5.0),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(
                                                                      10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 18.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                      "Template Name",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight
                                                                                              .w600,
                                                                                          fontSize: 11.0,
                                                                                          color: Colors
                                                                                              .blueAccent)),
                                                                                  Text('*',
                                                                                      style:
                                                                                      TextStyle(
                                                                                          color: Colors
                                                                                              .red)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 15.0,
                                                                                  right: 22.0),
                                                                              child: SizedBox(
                                                                                height: 35,
                                                                                child: TextField(
                                                                                  controller: controllerTemplate,
                                                                                  decoration: InputDecoration(
                                                                                      filled: true,
                                                                                      hintStyle: TextStyle(
                                                                                          color: Colors
                                                                                              .grey[800],
                                                                                          fontSize: 13),
                                                                                      //hintText: "Status",
                                                                                      fillColor: Colors
                                                                                          .white70),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .w400,
                                                                                      fontSize: 13.0,
                                                                                      color: Colors
                                                                                          .black),
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
                                                                  padding: const EdgeInsets.all(
                                                                      10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 18.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                      "File Path",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight
                                                                                              .w600,
                                                                                          fontSize: 11.0,
                                                                                          color: Colors
                                                                                              .blueAccent)),
                                                                                  Text('*',
                                                                                      style:
                                                                                      TextStyle(
                                                                                          color: Colors
                                                                                              .red)),
                                                                                  Container(
                                                                                    height: 30.0,
                                                                                    width: 30.0,
                                                                                    child: GestureDetector(
                                                                                      onTap: () async {
                                                                                        uploadFile();
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons
                                                                                            .folder,
                                                                                        size: 15.0,
                                                                                        color: Colors
                                                                                            .orangeAccent,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 15.0,
                                                                                  right: 22.0),
                                                                              child: SizedBox(
                                                                                height: 35,
                                                                                child: TextField(
                                                                                  controller: controllerFilepath,
                                                                                  decoration: InputDecoration(
                                                                                      filled: true,
                                                                                      hintStyle: TextStyle(
                                                                                          color: Colors
                                                                                              .grey[800],
                                                                                          fontSize: 13),
                                                                                      //hintText: "Status",
                                                                                      fillColor: Colors
                                                                                          .white70),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .w400,
                                                                                      fontSize: 13.0,
                                                                                      color: Colors
                                                                                          .black),
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
                                                                  padding: const EdgeInsets.all(
                                                                      10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 18.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                      "Remarks",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight
                                                                                              .w600,
                                                                                          fontSize: 11.0,
                                                                                          color: Colors
                                                                                              .blueAccent)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 15.0,
                                                                                  right: 22.0),
                                                                              child: SizedBox(
                                                                                height: 35,
                                                                                child: TextField(
                                                                                  controller: controllerTemplateremarks,
                                                                                  decoration: InputDecoration(
                                                                                      filled: true,
                                                                                      hintStyle: TextStyle(
                                                                                          color: Colors
                                                                                              .grey[800],
                                                                                          fontSize: 13),
                                                                                      //hintText: "Status",
                                                                                      fillColor: Colors
                                                                                          .white70),
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight
                                                                                          .w400,
                                                                                      fontSize: 13.0,
                                                                                      color: Colors
                                                                                          .black),
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
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    MaterialButton(
                                                                      shape: const CircleBorder(),
                                                                      color: Colors.black,
                                                                      padding: const EdgeInsets
                                                                          .all(10),
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          refresh = true;
                                                                          if (templatevalidateFields()) {

                                                                            var template = temp.where((element) => element
                                                                                .templateName ==
                                                                                controllerTemplate
                                                                                    .text)
                                                                                .toList();
                                                                            print(
                                                                                "tem----------> $template");
                                                                            if (template
                                                                                .isEmpty) {
                                                                              ref
                                                                                  .read(
                                                                                  addTemplateNotifier
                                                                                      .notifier)
                                                                                  .addTemplate({
                                                                                "template_id": 0,
                                                                                "template_name": controllerTemplate
                                                                                    .text,
                                                                                "file_path": controllerFilepath
                                                                                    .text,
                                                                                "updated_by": Helper.shareduserid.toString(),
                                                                                "created_date": "2023-04-20",
                                                                                "updated_date": "2023-04-20",
                                                                                "flg": 1,
                                                                                "remarks": controllerTemplateremarks
                                                                                    .text,
                                                                                "product_id": widget.product.productId.toString(),
                                                                              });
                                                                            }
                                                                            /* if (template[0].templateName == controllerTemplate.text) {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (
                                                                                    c) =>
                                                                                    AlertDialog(
                                                                                      title: Text(
                                                                                          "Template!"),
                                                                                      content:
                                                                                      Text(
                                                                                          "Tmplate already exists"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                            child: const Text(
                                                                                                'Ok'),
                                                                                            onPressed: () {
                                                                                              Navigator
                                                                                                  .pop(
                                                                                                  context);
                                                                                            }),
                                                                                      ],
                                                                                    ));
                                                                          } */
                                                                            else {
                                                                              ref
                                                                                  .read(
                                                                                  addTemplateNotifier
                                                                                      .notifier)
                                                                                  .addTemplate({
                                                                                "template_id": 0,
                                                                                "template_name": controllerTemplate
                                                                                    .text,
                                                                                "file_path": controllerFilepath
                                                                                    .text,
                                                                                "updated_by": Helper.shareduserid.toString(),
                                                                                "created_date": "2023-04-20",
                                                                                "updated_date": "2023-04-20",
                                                                                "flg": 1,
                                                                                "remarks": controllerTemplateremarks
                                                                                    .text,
                                                                                "product_id": widget.product.productId.toString(),
                                                                              });
                                                                            }
                                                                            // ref.refresh(getTemplateNotifier);

                                                                            Helper.editvalue = "notpassvalue";
                                                                            Template pro = Template(
                                                                              templateId: 0,
                                                                              templateName: controllerTemplate.text,
                                                                              filePath: controllerFilepath.text,
                                                                              updatedBy: Helper.shareduserid.toString(),
                                                                              createdDate: "2023-04-20",
                                                                              updatedDate: "2023-04-20",
                                                                              flg: 1,
                                                                              remarks: controllerTemplateremarks.text,
                                                                              productid: widget.product.productId.toString(),

                                                                            );

                                                                            widget.product.template!.add(pro);
                                                                           // listoftemplate.add(pro);


                                                                            clearTemplate();
                                                                            clearText();
                                                                          }
                                                                        });
                                                                      },
                                                                      child: const Icon(
                                                                        Icons.add,
                                                                        size: 15,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                    //edit
                                                                    MaterialButton(
                                                                      shape: const CircleBorder(),
                                                                      color: Colors.black,
                                                                      padding: const EdgeInsets
                                                                          .all(10),
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          refresh = true;
                                                                          if (templatevalidateFields()) {
                                                                              ref.read(updateTemplateNotifier.notifier).updatetTemplate({
                                                                                "template_id": template_product_id,
                                                                                "template_name": controllerTemplate.text,
                                                                                "file_path": controllerFilepath.text,
                                                                                "updated_by": Helper.shareduserid.toString(),
                                                                                "created_date": "2023-04-20",
                                                                                "updated_date": "2023-04-20",
                                                                                "flg": 1,
                                                                                "remarks": controllerTemplateremarks
                                                                                    .text,
                                                                                "product_id": tempproduct_id,
                                                                              });
                                                                             /* for(var mod in widget.product.template!){
                                                                                mod.templateId = template_product_id;
                                                                                mod.templateName = controllerTemplate.text;
                                                                                mod.filePath = controllerFilepath.text;
                                                                                mod.remarks = controllerTemplateremarks.text;
                                                                                mod.productid = tempproduct_id;
                                                                              }*/


                                                                                widget.product.template![i].templateId =  template_product_id;
                                                                                widget.product.template![i].templateName = controllerTemplate.text;
                                                                                widget.product.template![i].filePath = controllerFilepath.text;
                                                                                widget.product.template![i].remarks = controllerTemplateremarks.text;
                                                                                widget.product.template![i].productid = tempproduct_id;





                                                                              clearTemplate();
                                                                           // clearText();
                                                                          }
                                                                        });
                                                                      },
                                                                      child: const Icon(
                                                                        Icons.edit,
                                                                        size: 15,
                                                                        color: Colors.white,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
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
                                                                  IconButton(
                                                                      highlightColor: Colors.amberAccent,
                                                                      onPressed: () {
                                                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                          ref.refresh(getTemplateNotifier);
                                                                        });
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.refresh,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10.0,
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
                                                              child: Consumer(builder: (context, ref, child) {
                                                                return ref.watch(getTemplateNotifier).when(data: (data) {
                                                                  temp = data;
                                                                  lasttempid = temp.last;
                                                                  return ListView.builder(
                                                                      itemCount: widget.product.template!.length,

                                                                      //Templatelist.length,
                                                                      itemBuilder: (BuildContext ctxt, int index) {

                                                                        return InkWell(
                                                                          onTap: () {

                                                                            tempproduct_id = widget.product.template![index].productid.toString();
                                                                            template_product_id = widget.product.template![index].templateId;
                                                                            print('template_product_id------------->$template_product_id');
                                                                            print('index------------->$index');
                                                                            i = index;
                                                                            controllerTemplate.text = widget.product.template![index].templateName
                                                                                    .toString();
                                                                            //data[index].templateName.toString();
                                                                            controllerFilepath.text =
                                                                                widget.product.template![index].filePath.toString();
                                                                            //data[index].filePath.toString();
                                                                            controllerTemplateremarks.text =
                                                                                widget.product.template![index].remarks.toString();
                                                                            //data[index].remarks.toString();
                                                                          },
                                                                          child: Visibility(
                                                                            visible: data[index].flg == 1 ? true : false,
                                                                            child: Card(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                      left: 15.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .start,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(
                                                                                              8.0),
                                                                                          child: Text(
                                                                                            //data[index].templateName.toString(),
                                                                                              widget.product.template![index]
                                                                                                  .templateName
                                                                                                  .toString(),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight: FontWeight
                                                                                                      .w300,
                                                                                                  fontSize: 10.0,
                                                                                                  color: Colors.black)),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(
                                                                                              8.0),
                                                                                          child: Text(
                                                                                            //data[index].filePath.toString(),
                                                                                              widget.product.template![index]
                                                                                                  .filePath.toString(),
                                                                                              style: const TextStyle(
                                                                                                  fontWeight: FontWeight
                                                                                                      .w300,
                                                                                                  fontSize: 10.0,
                                                                                                  color: Colors.black)),
                                                                                        ),
                                                                                      ),
                                                                                      IconButton(
                                                                                          onPressed: () {


                                                                                            ref.read(
                                                                                                updateTemplateNotifier.notifier).updatetTemplate({
                                                                                              "template_id": widget.product.template![index].templateId,
                                                                                              "template_name": widget.product.template![index].templateName.toString(),
                                                                                              "file_path": widget.product.template![index].filePath.toString(),
                                                                                              "created_by": widget.product.template![index].createdBy.toString(),
                                                                                              "updated_by": widget.product.template![index].updatedBy.toString(),
                                                                                              "created_date": widget.product.template![index].createdDate.toString(),
                                                                                              "updated_date": widget.product.template![index].updatedDate.toString(),
                                                                                              "flg": 0,
                                                                                              "remarks": widget.product.template![index].remarks.toString(),
                                                                                              "product_id": product_id,
                                                                                            });
                                                                                            final snackBar = SnackBar(
                                                                                              content: const Text(
                                                                                                  'Template deleted successfully'),
                                                                                              backgroundColor: (Colors
                                                                                                  .black),
                                                                                            );
                                                                                            ScaffoldMessenger.of(context)
                                                                                                .showSnackBar(snackBar);
                                                                                          },
                                                                                          icon: Icon(Icons.delete))
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        );
                                                                      });
                                                                }, error: (e, s) {
                                                                  return Text(e.toString());
                                                                }, loading: () {
                                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                                });
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Template".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          )),
                    ],
                  ),
                ),

                /*  Padding(
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
                              "status":  widget.product.status,
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
                        */
                /*  product_code: controllerProductCode.text,
                          product_name: controllerProductName.text,
                          quantity: controllerProductQuantity.text,
                          status: controllerProductStatus.text,
                          time_required: controllerTimeRequired.text,
                          flg: isSelected;*/
                /*
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
                          child: Text("UPDATE".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        )),
                  ],
                ),
              )*/
              ],
            ),
          ),
        ),
      );
    }, error: (error, s) {
      return Text(error.toString());
    }, loading: () {
      return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
    });
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

  Future<dynamic> uploadFile() async {
    if (Response != "") {
      print("object");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("file uploaded successfully")));
    }
    var dio = Dio();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? "");

      String fileName = result.files.first.name;

      String path = file.path;

      FormData formData = FormData.fromMap(
          {'file': await MultipartFile.fromFile(path, filename: fileName)});
      final response = await dio.post(
          "http://192.168.1.10/PAT_API/api/Upload/SaveFile",
          data: formData, onSendProgress: (int sent, int total) {
        print('$sent $total');
      });

      print(response.data.toString());
      controllerFilepath.text = response.data.toString();
    } else {
      print("Result is null");
    }
  }



}
