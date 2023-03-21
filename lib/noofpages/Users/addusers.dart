import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/usermanagement.dart';
import 'package:production_automation_testing/Database/Curd_operation/database.dart';
import 'package:production_automation_testing/Helper/AppClass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/noofpages/Users/user.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Model/APIModel/usermodel.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/general_provider.dart';
import '../../Provider/post_provider/user_provider.dart';

class AddUsers extends ConsumerStatefulWidget {

  Users user;

  AddUsers({Key, key,required this.user});

  @override
  ConsumerState<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends ConsumerState<AddUsers> {
  var selectProduct = "PSBE";
  List<String> products = ['PSBE', '16 Zone', 'PSBE-E', '32 Zone'];

  var selectRole = "Super Admin";
  List<String> roles = [
    'Super Admin',
    'Design Admin',
    'Test Admin',
    'Design User',
    'Test User'
  ];

  bool isSelected = false;
  int? active = 0;
  Uint8List? selectedImageInByte;
  String? selectedImage;
  String defaultImageUrl =
      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.desicomments.com%2Fdc3%2F19%2F439319%2F4393191.jpg&imgrefurl=https%3A%2F%2Fwww.desicomments.com%2Fdesi%2Fflowers%2Frose%2F&tbnid=heBSBkV-HH-P5M&vet=12ahUKEwjs_8Dp_Zb8AhW3_zgGHdnNAAgQMygCegUIARDqAQ..i&docid=G53sgAPxM1fGuM&w=600&h=631&q=rose%20image&ved=2ahUKEwjs_8Dp_Zb8AhW3_zgGHdnNAAgQMygCegUIARDqAQ';
  String selctFile = '';
  XFile? file;

  bool isPasswordVisible = false;

  int? index;

  int? userid;


  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    print("FILE RESULT-------> $fileResult");

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        print("${fileResult.files.first.name}");
        selectedImageInByte = fileResult.files.first.bytes;
        selectedImage = fileResult.paths.first;
        print("selected images=======> ${fileResult.paths.first}");
      });
    }
    print(selctFile);
  }

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmpId = TextEditingController(text: "EID0");
  TextEditingController controllerContactNo = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerJigAddress = TextEditingController();

  late Box<UserManagementmodel> dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<UserManagementmodel>('users');
  }

  void clearText() {
    controllerUsername.clear();
    controllerPassword.clear();
    controllerEmpId.clear();
    controllerContactNo.clear();
    controllerEmail.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

/*    if (Allvalues.name != null &&
        Allvalues.emp_id != null &&
        Allvalues.phoneno != null &&
        Allvalues.email != null &&
        Allvalues.password != null &&
        Allvalues.key != null &&
        Allvalues.isActive != null &&
        Allvalues.user_id != null) {
      controllerEmpId.text = Allvalues.emp_id!;
      controllerUsername.text = Allvalues.name!;
      controllerEmail.text = Allvalues.email!;
      controllerContactNo.text = Allvalues.phoneno!;
      controllerPassword.text = Allvalues.password!;
      isSelected = Allvalues.isActive!;
      key = Allvalues.key!;

    }*/

    if(widget.user != null ){
      print("userid  ${widget.user.userId}");
      userid = widget.user.userId;
      controllerEmpId.text = widget.user.empId!;
      controllerUsername.text = widget.user.name!;
      controllerEmail.text = widget.user.emailid!;
      controllerContactNo.text = widget.user.phoneno!;
      controllerPassword.text = widget.user.password!;
      isSelected  =  widget.user.flg == 0 ? false : true;
    }


    return Container(
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
                "ADD USERS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              //color: Colors.purple,
                              child: selctFile.isEmpty
                                  ? Stack(
                                      children: [
                                        const CircleAvatar(
                                          radius: 220,
                                          backgroundImage: AssetImage(
                                              'assets/images/profile.jpg'),
                                        ),
                                        Positioned(
                                            top: 70.0,
                                            left: 67.0,
                                            child: Container(
                                              height: 20.0,
                                              width: 20.0,
                                              decoration: BoxDecoration(
                                                  /*    image: DecorationImage(
                                                                   image:  NetworkImage('https://unsplash.com/photos/80JjLrCUo64'),),*/

                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(20.0),
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _selectFile(true);
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  size: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  : () {
                                      //return Image.network('https://googleflutter.com/sample_image.jpg');
                                      if (selectedImage != null) {
                                        return Container(
                                            height: 100,
                                            width: 100,
                                            //color: Colors.purple,
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 220,
                                                  backgroundImage: NetworkImage(
                                                    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                                  ),
                                                ),

                                                /* CircleAvatar(
                                           radius: 220,
                                           backgroundImage: FileImage(File(selectedImage!)),
                                         ),*/

                                                // Image.file(File(selectedImage!)),
                                                Positioned(
                                                    top: 70.0,
                                                    left: 67.0,
                                                    child: Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20.0),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _selectFile(true);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 15.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ));

                                        //Image.file('C:\Users\NANCY\Pictures\Screenshots\Screenshot (7).png!\');
                                        //return Image.memory(selectedImageInByte!);
                                      } else {
                                        return Text('data');
                                      }
                                    }()),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Employee ID",
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
                                  height: 55,
                                  child: TextField(
                                    maxLength: 7,
                                    controller: controllerEmpId,
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
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Name",
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
                                  height: 55,
                                  child: TextField(
                                    maxLength: 20,
                                    controller: controllerUsername,
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Password",
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
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 22.0),
                                  child: SizedBox(
                                    height: 55,
                                    child: TextField(
                                      maxLength: 10,
                                      controller: controllerPassword,
                                      obscureText: !isPasswordVisible,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                          filled: true,
                                          suffix: InkWell(
                                            onTap: () {
                                              ref
                                                      .read(loginPasswordToggle
                                                          .notifier)
                                                      .state =
                                                  !ref.watch(loginPasswordToggle);
                                              isPasswordVisible =
                                                  ref.watch(loginPasswordToggle);
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0),
                                                child: isPasswordVisible
                                                    ? Icon(Icons.visibility,
                                                        size: height * 0.03)
                                                    : Icon(Icons.visibility_off,
                                                        size: height * 0.03)),
                                          ),
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
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Email Id",
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
                                  height: 55,
                                  child: TextField(
                                    maxLength: 35,
                                    controller: controllerEmail,
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    Text("Phone No",
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
                                  height: 55,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLength: 10,
                                    controller: controllerContactNo,
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text("Role",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.0,
                                            color: Colors.blueAccent)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: DropdownButton(
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25.0),
                                          child: Icon(Icons.keyboard_arrow_down),
                                        ),
                                        items: roles
                                            .map<DropdownMenuItem<String>>(
                                                (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                        value: selectRole,
                                        onChanged: (item) {
                                          setState(() {
                                            selectRole = item.toString();
                                            print("Index==>" + selectRole);
                                            //List<FirstClass> emptylist = [];
                                          });
                                        },
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, right: 30.0),
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
                                        /* this.isSelected = val!;
                                            if(isSelected == true ? false : true){

                                            }*/
                                        isSelected = !isSelected;
                                        widget.user.flg = isSelected == false ? 0 : 1;

                                       // Allvalues.isActive = isSelected;
                                      });
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView( 
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("ADD USERS ".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
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
                                ref.read(addUserNotifier.notifier).addUser({
                                  "name": controllerUsername.text,
                                  "password": controllerPassword.text,
                                  "avatar_id": "",
                                  "emailid": controllerEmail.text,
                                  "phoneno": controllerContactNo.text,
                                  "role": "",
                                  "created_by": 0,
                                  "updated_by": 0,
                                  "created_date": null,
                                  "updated_date": null,
                                  "flg": isSelected ? 0 : 1,
                                });

                                /*User().addUsers(
                                  "",
                                  controllerEmpId.text,
                                  controllerUsername.text,
                                  controllerPassword.text,
                                  "",
                                  controllerEmail.text,
                                  controllerContactNo.text,
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  isSelected,
                                );*/
                                clearText();
                              }
                              Helper.isadd = true;
                            }),
                        ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("EDIT USERS".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ),
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
                            onPressed: () async {
                              ref.read(updateUserNotifier.notifier).updatetUser({
                                    "user_id": userid,
                                    "emp_id": controllerEmpId.text,
                                    "name": controllerUsername.text,
                                    "password": controllerPassword.text,
                                    "avatar_id": null,
                                    "emailid": controllerEmail.text,
                                    "phoneno": controllerContactNo.text,
                                    "role": null,
                                    "created_by": 0,
                                    "updated_by": 0,
                                    "created_date": null,
                                    "updated_date": null,
                                    "flg": widget.user.flg
                                  });
                              clearText();


                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/* Future<void> _pickImage() async{
    if(!kIsWeb){
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        var selected = File(image.path);
        setState(() {
          pickedImage = selected;
        });
      }else{
        print("no image has be found");
      }
    }else if (kIsWeb){
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        var f = await image.readAsBytes();
        webImage = f;
        pickedImage = File('a');
      }else{
        print("no image has be found");
      }
    }else{
      print("something went wrong");
    }
  }*/

  bool validateFields() {
    if (controllerEmpId.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Employee Id should not be empty',
          context: context);
      return false;
    } else if (controllerEmpId.text.length < 5) {
      popDialog(
          title: 'Update Failed',
          msg: 'Please enter a valid employee code',
          context: context);
      return false;
    } else if (controllerUsername.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Username should not be empty',
          context: context);
      return false;
    } else if (controllerUsername.text.length < 3) {
      popDialog(
          title: 'Update Failed',
          msg: 'Username is too short, Please enter the full name',
          context: context);
      return false;
    } else if (controllerPassword.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Password should not be empty',
          context: context);
      return false;
    } else if (controllerPassword.text.length < 6) {
      popDialog(
          title: 'Update Failed',
          msg: 'Password must be greater than 6 characters',
          context: context);
      return false;
    } else if (controllerEmail.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Email address should not be empty',
          context: context);
      return false;
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(controllerEmail.text)) {
      popDialog(
          title: 'Update Failed',
          msg: 'Please enter a valid email address',
          context: context);
      return false;
    } else if (controllerContactNo.text.length < 10) {
      popDialog(
          title: 'Update Failed',
          msg: 'Please enter a valid mobile number',
          context: context);
      return false;
    } else if (controllerContactNo.text.length < 10) {
      popDialog(
          title: 'Update Failed',
          msg: 'Please enter a valid mobile number',
          context: context);
      return false;
    }
    return true;
  }
}
