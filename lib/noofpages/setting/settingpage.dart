import 'package:flutter/material.dart';

import '../../Helper/helper.dart';
import '../../Provider/post_provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmpId = TextEditingController();
  TextEditingController controllerContactNo = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerRole= TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {



   controllerUsername.text = Helper.sharedUsername;
   controllerPassword.text = Helper.sharedpassword;
   controllerEmpId.text = Helper.sharedempid;
   controllerContactNo.text = Helper.sharedmobileno;
   controllerEmail.text = Helper.sharedemail;
   controllerRole.text = Helper.sharedRoleId;



    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/banner.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
              top: 150,
              left: 100,
              right: 100,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                  ),
                  child: Card(
                      elevation: 8.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text("Update Profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        color: Colors.black))
                              ],
                            ),
                          ),

                          Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18.0),
                                            child: Row(
                                              children: [
                                                Text("User Name",
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
                                                controller: controllerUsername,
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
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 22.0),
                                            child: SizedBox(
                                              height: 35,
                                              child: TextField(
                                                 controller: controllerEmail,
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
                            padding: const EdgeInsets.all(15.0),
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
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 22.0),
                                        child: SizedBox(
                                          height: 35,
                                          child: TextField(
                                             controller: controllerPassword,
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Text("Mobile No",
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
                                             controller: controllerContactNo,
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
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Text("Employee Code",
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
                                            enabled: false,
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Text("Role",
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
                                            enabled: false,
                                            controller: controllerRole,
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
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>( Colors.deepPurple),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: BorderSide(color:  Colors.deepPurple)))),
                                onPressed: () {
                                  ref.read(updateUserNotifier.notifier).updatetUser({
                                    "user_id": Helper.shareduserid,
                                    "emp_id": controllerEmpId.text,
                                    "name": controllerUsername.text,
                                    "password": controllerPassword.text,
                                    "avatar_id": null,
                                    "emailid": controllerEmail.text,
                                    "phoneno": Helper.sharedmobileno,
                                    "role": Helper.sharedRoleId,
                                    "created_by": 0,
                                    "updated_by": 0,
                                    "created_date": null,
                                    "updated_date": null,
                                    "flg": 1
                                  });
                                   Helper.sharedUsername = controllerUsername.text;
                                   Helper.sharedpassword =controllerPassword.text;
                                   Helper.sharedempid = Helper.sharedempid;
                                   Helper.sharedmobileno = controllerContactNo.text ;
                                  Helper.sharedemail = controllerEmail.text;
                                  Helper.sharedRoleId = Helper.sharedRoleId;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Update ".toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                )),
                          ),




                        ],
                      ))))
        ],
      ),
    );
  }
}
