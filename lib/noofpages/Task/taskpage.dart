import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:production_automation_testing/DashBoard/src/ProjectCardOverview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../DashBoard/src/cardcount/taskcount.dart';
import '../../DashBoard/src/tabs.dart';
import '../../Provider/excelprovider.dart';
import 'assignpage.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  bool _isShow = false;

  var selectUsers = "Sriram";
  List<String> users = ['Sriram', 'Muthu', 'Issac', 'Nancy'];

  var selectProduct = "PSBE";
  List<String> products = ['PSBE', '16 Zone', 'PSBE-E', '32 Zone'];

  var selectWorkorder = "PSBEWorkorder";
  List<String> workorders = [
    'PSBEWorkorder',
    '16ZoneWorkorder',
    'PSBE-EWorkorder',
    '32ZoneWorkorder'
  ];

  DateTime date = DateTime(2022, 12, 07);

  @override
  Widget build(BuildContext context) {
    return  ref.watch(getTaskNotifier).when(data: (datum){
      return Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.63,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TASK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(15),
                          onPressed: () {
                            setState(() {
                              _isShow = !_isShow;
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
                      return ref.watch(getTaskCountNotifier).when(data: (count){
                        return Container(
                          margin: EdgeInsets.only(top: 5.0),
                          height: 200.0,
                          width: MediaQuery.of(context).size.width * 0.62,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TaskCardView(
                                  color: Color(0xffFF4C60),
                                  projectName: 'Task count',
                                  percentComplete: '${count[0].taskCount}%',
                                  peopleCount: count[0].taskCount,
                                  progressIndicatorColor: Colors.redAccent[100],
                                  icon: Feather.calendar),
                              TaskCardView(
                                  color: Color(0xff6C6CE5),
                                  projectName: 'In-Progress',
                                  percentComplete: '${count[0].inprogress}%',
                                  peopleCount: count[0].inprogress,
                                  progressIndicatorColor: Colors.blue[200],
                                  icon: Feather.truck),
                              TaskCardView(
                                  color: Color(0xffFAAA1E),
                                  projectName: 'Complete',
                                  percentComplete: '${count[0].completed}%',
                                  peopleCount: count[0].completed,
                                  progressIndicatorColor: Colors.amber[200],
                                  icon: Icons.local_airport),
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
                  Tabs(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Color(0xff8fcceb),
                                //Colors.blueAccent,
                                elevation: 10,
                                child: Center(
                                    child: Text("TASK ASSIGN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.black))),
                              ),
                            ),
                            Card(
                              elevation:10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: users.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectUsers,
                                    onChanged: (item) {

                                      setState(() {
                                        selectUsers = item.toString();
                                        print("Index==>"+selectUsers);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: workorders.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectWorkorder,
                                    onChanged: (item) {

                                      setState(() {
                                        selectWorkorder = item.toString();
                                        print("Index==>"+selectWorkorder);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: products.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectProduct,
                                    onChanged: (item) {

                                      setState(() {
                                        selectProduct = item.toString();
                                        print("Index==>"+selectProduct);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),


                                ],
                              ),
                            ),
                            SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: ScrollController(),
                                  itemCount: datum.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Card(
                                        color: Colors.teal[100],
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "User Name : ",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                          Text(datum[index].userId.toString(), style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.black
                                                          ),),

                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Product : ",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                          Text(datum[index].assignId.toString(), style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.black
                                                          ),),

                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Workorder : ",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                          Text(datum[index].wolId.toString(), style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.black
                                                          ),),

                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Quantity : ",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                          Text(datum[index].quantity.toString(), style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.black
                                                          ),),

                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Start Serial No : ",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                          Text(datum[index].startSerialNo.toString(), style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.black
                                                          ),),

                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "End Serial No : ",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                color: Colors.red
                                                            ),
                                                          ),
                                                          Text(datum[index].endSerialNo.toString(), style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.0,
                                                              color: Colors.black
                                                          ),),

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                child: CircularPercentIndicator(
                                                  radius: 50.0,
                                                  lineWidth: 6.5,
                                                  percent: 0.45,
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  center: Text(
                                                    "45%",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 13.0,
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  progressColor: Colors.white,
                                                  startAngle: 270,
                                                  backgroundColor: Colors.white54,

                                                ))
                                          ],
                                        ));
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Color(0xff8fcceb),
                                //Colors.blueAccent,
                                elevation: 10,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Center(
                                          child: Text("TASK VIEW",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation:10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      '${date.year}/${date.month}/${date.day}'
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      DateTime? newDate = await showDatePicker(
                                          context: context,
                                          initialDate: date,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100));
                                      if(newDate == null) return;
                                      setState(() {
                                        date = newDate;
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: workorders.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectWorkorder,
                                    onChanged: (item) {

                                      setState(() {
                                        selectWorkorder = item.toString();
                                        print("Index==>"+selectWorkorder);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),
                                  DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: products.map<DropdownMenuItem<String>>(
                                            (String setlist) {
                                          return DropdownMenuItem<String>(
                                            value: setlist,
                                            child: Text(setlist.toString()),
                                          );
                                        }).toList(),
                                    value: selectProduct,
                                    onChanged: (item) {

                                      setState(() {
                                        selectProduct = item.toString();
                                        print("Index==>"+selectProduct);
                                        //List<FirstClass> emptylist = [];

                                      });
                                    },
                                  ),


                                ],
                              ),
                            ),
                            SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Card(
                                        color: Colors.green[100],
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
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
                          ],
                        ),
                      )
                    ],
                  ),

                  Expanded(
                      flex: 1,
                      child: Text("")
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
            child: Expanded(
                flex: 5,
                child: AssignTask()),
          ),
        ],
      );
    }, error: (e,s){
      return Text(e.toString());
        }, loading: (){
      return CircularProgressIndicator();
        });

  }
}
