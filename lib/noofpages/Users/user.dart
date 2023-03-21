import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/noofpages/Users/addusers.dart';
import '../../DashBoard/src/ProjectCardOverview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../DashBoard/src/cardcount/usercount.dart';
import '../../Database/Curd_operation/HiveModel/usermanagement.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/boxes.dart';
import '../../Database/Curd_operation/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/APIModel/usermodel.dart';

class UserPage extends ConsumerStatefulWidget {
  UserPage({Key, key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

int? key;
UserManagementmodel? data;
List<UserManagementmodel>? datamodels;

Users user = Users();

class _UserPageState extends ConsumerState<UserPage> {
  bool _isShow = false;
  var selectRole = "Super Admin";
  List<String> roles = [
    'Super Admin',
    'Design Admin',
    'Test Admin',
    'Design User',
    'Test User'
  ];

  bool all = true;
  bool active = false;
  bool inactive = false;
  int looping = 0;

  bool useres = true;



  List<dynamic>? allusers;
  List<UserManagementmodel>  use = [];

  @override
  void initState(){
    Helper.classes ='userlist';
    //ref.refresh(getUserNotifier);

  }



  @override
  Widget build(BuildContext context) {

     /*   ref.watch(getUserNotifier).when(data: (datum){
          */
    /*  if(looping == 0) {
              for(int i = 0; i<datum.length; i++){
                if(datamodels!.isEmpty){
                  User().addUsers(
                      datum[i].userId.toString(),
                      datum[i].empId.toString(),
                      datum[i].name.toString(),
                      datum[i].password.toString(),
                      datum[i].avatarId.toString(),
                      datum[i].emailid.toString(),
                      datum[i].phoneno.toString(),
                      datum[i].role.toString(),
                      datum[i].createdBy.toString(),
                      datum[i].updatedBy.toString(),
                      datum[i].createdDate.toString(),
                      datum[i].updatedDate.toString(),
                      datum[i].flg == 0 ? false : true
                  );
                }

              }
              looping++;
            }*//*

    }, error: (e,s){

    }, loading: (){
    });*/

  /*  return ValueListenableBuilder<Box<UserManagementmodel>>(
        valueListenable: Usersvalue.getUsers().listenable(),
        builder: (context, Box<UserManagementmodel> items, _) {
          List<int> keys;
          keys = items.keys.cast<int>().toList();
          datamodels = items.values.toList().cast<UserManagementmodel>();

          var activevalue = items.values
              .where((element) => element.flg == true)
              .toList();

          var inactivevalue = items.values
              .where((element) => element.flg == false)
              .toList();
*/
         return ref.watch(getUserNotifier).when(data: (datum){
            var activevalue = datum.where((element) => element.flg == 1).toList();

            var inactivevalue = datum.where((element) => element.flg == 0).toList();

            return Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.63,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "User Management",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                              MaterialButton(
                                padding: const EdgeInsets.all(15),
                                onPressed: () {
                                  setState(() {


                                    user.name= "";
                                    user.empId= "";
                                    user.emailid= "";
                                    user.password= "";
                                    user.phoneno= "";
                                    user.flg= 0 ;

                                   /* AddUsers(user: user);
                                    Allvalues.name =
                                    " ";
                                    Allvalues.emp_id =
                                    " ";
                                    Allvalues.email =
                                    "";
                                    Allvalues.password =
                                    "";
                                    Allvalues.phoneno =
                                    " ";
                                    Allvalues.isActive =
                                    false;
                                    Allvalues.key = 0;*/
                                    _isShow = !_isShow;
                                    useres = !useres;
                                  });
                                },
                                child: const Icon(
                                  Icons.open_in_browser_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                       Consumer(
                          builder: (context, ref, child) {
                           return ref.watch(getUserCountNotifier).when(data: (count){
                              return Container(
                                margin: EdgeInsets.only(top: 5.0),
                                height: 200.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        UserCardView(
                                            color: Color(0xffb75661),
                                            projectName: 'Super Admin',
                                            peopleCount: count[0].superAdmin,
                                            percentComplete: '34%',
                                            progressIndicatorColor: Colors.redAccent[100],
                                            icon: Feather.anchor),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        UserCardView(
                                            color: Color(0xff6C6CE5),
                                            projectName: 'Design Admin',
                                            peopleCount: count[0].designAdmin,
                                            percentComplete: '78%',
                                            progressIndicatorColor: Colors.blue[200],
                                            icon: Feather.user),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        UserCardView(
                                            color: Color(0xffFAAA1E),
                                            projectName: 'Test Admin',
                                            peopleCount: count[0].testAdmin,
                                            percentComplete: '82%',
                                            progressIndicatorColor: Colors.amber[200],
                                            icon: Icons.checkroom),

                                      ],
                                    ),
                                    Visibility(
                                        visible: useres,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            UserCardView(
                                                color: Color(0xff2d6666),
                                                projectName: 'Design User',
                                                peopleCount: count[0].designUser,
                                                percentComplete: '82%',
                                                progressIndicatorColor: Colors.tealAccent[200],
                                                icon: Icons.person_add_alt_1_rounded),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            UserCardView(
                                                color: Color(0xff4c2d66),
                                                projectName: 'Test User',
                                                peopleCount: count[0].testUser,
                                                percentComplete: '82%',
                                                progressIndicatorColor: Colors.deepPurpleAccent[200],
                                                icon: Icons.people_alt),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            UserCardView(
                                                color: Color(0xff455e29),
                                                projectName: 'Total User',
                                                peopleCount: count[0].userCount,
                                                percentComplete: '82%',
                                                progressIndicatorColor: Colors.green[200],
                                                icon: Icons.people_alt),
                                          ],
                                        ))
                                  ],
                                ),

                              );
                            }, error: (e,s){
                              return Text(e.toString());
                            }, loading: (){
                              return CircularProgressIndicator();
                            });

                          }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 32.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  child: Text("All".toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.black)))),
                                  onPressed: () {
                                    setState(() {
                                      all = true;
                                      active = false;
                                      inactive = false;
                                    });
                                  }),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                  child: Text("Active".toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.black)))),
                                  onPressed: () {
                                    setState(() {
                                      all = false;
                                      active = true;
                                      inactive = false;
                                    });
                                  }),
                              SizedBox(
                                width: 15.0,
                              ),
                              ElevatedButton(
                                  child: Text("In Active".toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.black)))),
                                  onPressed: () {
                                    setState(() {
                                      all = false;
                                      active = false;
                                      inactive = true;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Color(0xff8fcceb),
                            //Colors.blueAccent,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 20.0,
                                      width: 10.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(' '),
                                          Expanded(
                                            child: Center(
                                              child: Text("Emp Id",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Name",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Email",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("phone no",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Rating",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButton(
                                      icon: _isShow == true
                                          ?Padding(
                                          padding:
                                          const EdgeInsets.only(left: 15.0),
                                          child: Icon(Icons.keyboard_arrow_down))
                                          :Padding(
                                          padding:
                                          const EdgeInsets.only(left: 80 ),
                                          child: Icon(Icons.keyboard_arrow_down)),
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
                                          print("Index==>" + selectRole);
                                          //List<FirstClass> emptylist = [];
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 500,
                                  child: ValueListenableBuilder<
                                      Box<UserManagementmodel>>(
                                      valueListenable:
                                      Usersvalue.getUsers().listenable(),
                                      builder: (context,
                                          Box<UserManagementmodel> items, _) {
                                        List<int> keys;
                                        keys = items.keys.cast<int>().toList();
                                        datamodels = items.values
                                            .toList()
                                            .cast<UserManagementmodel>();


                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 490,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15.0),
                                                  ),
                                                  color: Color(0xffcbdff2),
                                                  elevation: 15,
                                                  child: ListView.builder(
                                                      itemCount:  //allusers!.length,
                                                          () {
                                                        if (all == true) {

                                                          //return keys.length;
                                                          return datum.length;
                                                        } else if (active == true) {
                                                          // active = false;
                                                          return activevalue.length;
                                                        } else if (inactive == true) {
                                                          // inactive = false;
                                                          return inactivevalue.length;
                                                        } else {
                                                          return 0;
                                                        }
                                                      }(),
                                                      itemBuilder: (BuildContext ctxt, int index) {

                                                        return (){
                                                          if(all == true){
                                                            return  getListItems(datum, index);
                                                          }else if(active == true){
                                                            return getActiveItems(datum, index);
                                                          }else if(inactive == true){
                                                            return getInActiveItems(datum, index);
                                                          }else{
                                                            return getListItems(datum, index);
                                                          }
                                                        }();

                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('@copyright rax-tech International 2022',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0,
                                        color: Colors.black)),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _isShow,
                  child: Expanded(flex: 5, child: AddUsers(user: user,)),
                ),
              ],
            );

          }, error: (e,s){
           return Text(e.toString());

          }, loading: (){
           return Center(child: CircularProgressIndicator());
          });


  }


 // getListItems(Box<UserManagementmodel> items, int index) {

    getListItems(List<Users> items, int index) {

   // List<int> keys;
   // keys = items.keys.cast<int>().toList();
   // final datamodels = items.values.toList().cast<UserManagementmodel>();
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: items[index].flg == 1
                                  //datamodels[index].flg == true
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(items[index].empId.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(items[index].name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(items[index].emailid.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  items[index].phoneno.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              // setState(() {
                              /*           if(_isShow == false){
                                  _isShow = true;

                                }
                                Usermodel user = Usermodel(
                                  name:  datamodels[index].name,
                                  emp_id: datamodels[index].emp_id,
                                  email: datamodels[index].email,
                                  phoneno: datamodels[index].phoneno,
                                  isActive: datamodels[index].isActive,
                                );
                                AddUsers(
                                  index: index,
                                  usermodel: user ,
                                );

                              });*/

                              setState(() {


                                 user.userId =  items[index].userId;
                                 user.name= items[index].name.toString();
                                 user.empId= items[index].empId.toString();
                                 user.emailid= items[index].emailid.toString();
                                 user.password= items[index].password.toString();
                                 user.phoneno= items[index].phoneno.toString();
                                 user.flg= items[index].flg == 0 ? 0 : 1;

                                AddUsers(user: user);







                               /* Allvalues.user_id = items[index].userId;
                                Allvalues.name = items[index].name.toString();
                                Allvalues.emp_id = items[index].empId.toString();
                                Allvalues.email = items[index].emailid.toString();
                                Allvalues.password = items[index].password.toString();
                                Allvalues.phoneno = items[index].phoneno.toString();
                                Allvalues.isActive = items[index].flg == 0 ? false : true;
                                Allvalues.key = datamodels[index].key;
      */

                                 useres = false;
                                _isShow = true;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              User().deleteUser(datamodels![index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  getActiveItems(List<Users> items, int index) {
    var activevalue = items.where((element) => element.flg == 1).toList();
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: activevalue[index].flg == 1
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(activevalue[index].empId.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(activevalue[index].name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(activevalue[index].emailid.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  activevalue[index].phoneno.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {

                              setState(() {
                                user.userId =  activevalue[index].userId;
                                user.name= activevalue[index].name.toString();
                                user.empId= activevalue[index].empId.toString();
                                user.emailid= activevalue[index].emailid.toString();
                                user.password= activevalue[index].password.toString();
                                user.phoneno= activevalue[index].phoneno.toString();
                                user.flg= activevalue[index].flg == 0 ? 0 : 1;

                                AddUsers(user: user);

                                _isShow = true;
                                useres = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                             // User().deleteUser(activevalue![index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ));
  }

  getInActiveItems(List<Users> items, int index) {
    var inactivevalue = items.where((element) => element.flg == 0).toList();
    return Card(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: inactivevalue[index].flg == true
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(inactivevalue[index].empId.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(inactivevalue[index].name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(inactivevalue[index].emailid.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  inactivevalue[index].phoneno.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0,
                                      color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 15,
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {

                              setState(() {
                                user.userId =  inactivevalue[index].userId;
                                user.name= inactivevalue[index].name.toString();
                                user.empId= inactivevalue[index].empId.toString();
                                user.emailid= inactivevalue[index].emailid.toString();
                                user.password= inactivevalue[index].password.toString();
                                user.phoneno= inactivevalue[index].phoneno.toString();
                                user.flg= inactivevalue[index].flg == 0 ? 0 : 1;

                                AddUsers(user: user);

                                _isShow = true;
                                useres = false;
                              });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                             // User().deleteUser(inactivevalue[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

}
