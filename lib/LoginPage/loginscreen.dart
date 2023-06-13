import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:production_automation_testing/Database/Curd_operation/boxes.dart';
import 'package:production_automation_testing/Database/Curd_operation/database.dart';
import 'package:production_automation_testing/Provider/navigation_provider.dart';
import 'package:production_automation_testing/Provider/post_provider/singletest_provider.dart';
import '../Database/Curd_operation/HiveModel/usermanagement.dart';
import '../Helper/AppClass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Helper/helper.dart';
import '../HomeScreen.dart';
import '../Provider/excelprovider.dart';
import '../Provider/general_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}
int? key;
UserManagementmodel? data;
List<UserManagementmodel>? datamodels;
bool conditionfailed = true;


class _LoginScreenState extends ConsumerState<LoginScreen> {
  var selectRole;
  List<String> roles = ['Super Admin', 'Design Admin', 'Test Admin', 'Design User', 'Test User'];

  bool isSelected = false;

  TextEditingController controllerEmpId = TextEditingController(text: "EID0");
  TextEditingController controllerPassword = TextEditingController();

  bool isPasswordVisible = false;



  void clearText() {
    controllerEmpId.clear();
    controllerPassword.clear();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset('assets/images/raxlogo.png'),
                                    ),
                                  ),
                                  Text('Rax - Tech International',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ClipRRect(
                                    child: Image.asset('assets/images/login.png',
                                height: 500.0,
                                width: 600.0,
                               )),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    child: Center(
                  child: Card(
                      elevation: 20,
                      color: Color(0xff333951),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SizedBox(
                          width: 600,
                          height: 650,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 70.0, left: 35, right: 35, bottom: 20),
                                child: Card(
                                    elevation: 20,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child:  Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 27.0,top: 15,),
                                                  child: Row(
                                                    children: [
                                                      Text("Roles",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 11.0,
                                                              color: Colors.blueAccent)),
                                                      Text('*', style: TextStyle(color: Colors.red)),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10.0),
                                                  child: DropdownButton(
                                                    icon: Padding(
                                                      padding: const EdgeInsets.only(left: 320),
                                                      child: Icon(Icons.keyboard_arrow_down),
                                                    ),
                                                    items: roles.map<DropdownMenuItem<String>>(
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
                                                        print("Index==>"+selectRole);
                                                        //List<FirstClass> emptylist = [];

                                                      });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:  EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 18.0),
                                                              child: Row(
                                                                children: [
                                                                  Text("Employeee Code",
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
                                                                height: 57,
                                                                child: TextField(
                                                                  maxLength: 7,
                                                                  controller: controllerEmpId,
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
                                                  padding:  EdgeInsets.all(10.0),
                                                  child: Row(
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
                                                                  Text('*', style: TextStyle(color: Colors.red)),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left: 15.0, right: 22.0),
                                                              child: SizedBox(
                                                                height: 52,
                                                                child:  TextField(
                                                                  maxLength: 10,
                                                                  controller: controllerPassword,
                                                                  obscureText: !isPasswordVisible,
                                                                  enableSuggestions: false,
                                                                  autocorrect: false,

                                                                  decoration: InputDecoration(
                                                                      filled: true,
                                                                      suffix: InkWell(
                                                                        onTap: () {
                                                                          ref.read(loginPasswordToggle.notifier).state =
                                                                          !ref.watch(loginPasswordToggle);
                                                                          isPasswordVisible =
                                                                              ref.watch(loginPasswordToggle);
                                                                        },
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(right: 15.0),
                                                                            child: isPasswordVisible
                                                                                ? Icon(Icons.visibility,
                                                                                size: height * 0.03)
                                                                                : Icon(Icons.visibility_off,
                                                                                size:
                                                                                height * 0.03)),

                                                                      ),
                                                                      hintStyle: TextStyle(
                                                                          color: Colors.grey[800],
                                                                          fontSize: 13),
                                                                      fillColor: Colors.white70),
                                                                  style: TextStyle(fontWeight: FontWeight.w400,
                                                                      fontSize: 13.0,
                                                                      color: Colors.black),
                                                                )
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                               /* Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0, right: 30.0),
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                            value: isSelected,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                this.isSelected = val!;
                                                              });

                                                            },
                                                          ),
                                                          Text("Is Active",
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15.0,
                                                                  color: Colors.black)),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),*/
                                                Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                       /* child: ValueListenableBuilder<Box<UserManagementmodel>>(
                                                            valueListenable: Usersvalue.getUsers().listenable(),
                                                            builder: (context, Box<UserManagementmodel> items, _) {
                                                              List<int> keys;
                                                              keys = items.keys.cast<int>().toList();
                                                              datamodels = items.values.toList().cast<UserManagementmodel>();*/

                                                            child: Consumer(
                                                              builder: (context, ref,child ) {
                                                                return ref.watch(getUserNotifier).when(data: (datum){
                                                                  return ElevatedButton(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            "Login ".toUpperCase(),
                                                                            style: TextStyle(fontSize: 14)
                                                                        ),
                                                                      ),
                                                                      style: ButtonStyle(
                                                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFeb672f)),
                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              side: BorderSide(color: Color(0xFFeb672f))
                                                                          )
                                                                          )
                                                                      ),
                                                                      onPressed: () {
                                                                      /*  Navigator.push(
                                                                            context, MaterialPageRoute(builder: (context) => HomeScreenPage()));*/
                                                                        Helper.usercount = datum.length;
                                                                        if(validateFields()){
                                                                          var uservalidation = datum.where((element) => element.empId == controllerEmpId.text ).toList();
                                                                          if(uservalidation[0].flg == 1){
                                                                            if((uservalidation == null) || (uservalidation[0].empId == controllerEmpId.text && uservalidation[0].password == controllerPassword.text)){
                                                                              if(uservalidation[0].role == selectRole){
                                                                                Helper.sharedRoleId = selectRole;
                                                                                Helper.sharedUsername = uservalidation[0].name;
                                                                                Helper.sharedpassword = uservalidation[0].password;
                                                                                Helper.sharedemail = uservalidation[0].emailid;
                                                                                Helper.sharedempid = uservalidation[0].empId;
                                                                                Helper.sharedmobileno = uservalidation[0].phoneno;
                                                                                Helper.shareduserid = uservalidation[0].userId;

                                                                                print("helpername---->${ Helper.sharedUsername}");
                                                                                print("helpername---->${ Helper.sharedpassword}");
                                                                                print("helpername---->${ Helper.sharedemail}");
                                                                                print("helpername---->${ Helper.sharedempid}");
                                                                                print("helpername---->${ Helper.sharedRoleId}");
                                                                                print("helpername---->${ Helper.shareduserid}");

                                                                                ref.refresh(navNotifier);

                                                                                ref.read(singletesterReportNotifier.notifier).singletesterReport(Helper.shareduserid);

                                                                                Navigator.push(
                                                                                    context, MaterialPageRoute(builder: (context) => HomeScreenPage()));
                                                                                //conditionfailed = false;
                                                                                clearText();
                                                                              }else{
                                                                                getroledialog();
                                                                              }

                                                                            }else
                                                                            {
                                                                              getdialog();
                                                                            }
                                                                          }else{
                                                                            getinActive();
                                                                          }

                                                                        }
                                                                      }
                                                                  );
                                                                  },error: (e,s){
                                                                  return Text(e.toString());
                                                                },
                                                                  loading: (){
                                                                  return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
                                                                  });

                                                              }
                                                            ),
                                                         // }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Text("Forgot Password?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.white)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Don't have any account",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                        color: Colors.orange)),
                              ),

                            ],
                          )
                      )),
                )
                    /* Card(
                      child: Container(
                        width: 10,
                        height: 300,
                        color: Color(0xFF841be0),
                      ),
                    )*/
                    )
              ],
            )
          ],
        ),
      ),
    );
  }
  bool validateFields() {
    if (controllerEmpId.text.isEmpty) {
      popDialog(
          title: 'Update Failed',
          msg: 'Employee Id should not be empty',
          context: context);
      return false;
    }else if (controllerEmpId.text.length < 5) {
      popDialog(
          title: 'Update Failed',
          msg: 'Please enter a valid employee code',
          context: context);
      return false;
    }else if (controllerPassword.text.isEmpty) {
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
    }

    return true;
  }

  getdialog() {
    return popDialog(
        title: 'Login Failed',
        msg: 'Incorrect employee code or password. Try again!!!',
        context: context);
  }
  getinActive() {
    return popDialog(
        title: 'Login Failed',
        msg: 'User is not in Active ',
        context: context);

  }
  getroledialog() {
    return popDialog(
        title: 'Login Failed',
        msg: 'Role of user is Mismatch select correct role Try again!!!',
        context: context);
  }
}
