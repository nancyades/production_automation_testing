import 'package:flutter/material.dart';
import 'package:production_automation_testing/noofpages/Test/firsrtaskviewpage.dart';

import '../../HomeScreen.dart';

class TestCompleted extends StatefulWidget {
  const TestCompleted({Key? key}) : super(key: key);

  @override
  State<TestCompleted> createState() => _TestCompletedState();
}

class _TestCompletedState extends State<TestCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0, left: 45),
                            child: Row(
                              children: [
                                Text('Test Completed Successfully',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  "assets/images/complete.png", width: 500,height: 500,),
                              ),
                              Expanded(
                                child: Image.asset(
                                  "assets/images/complet1.png",),
                              ),
                            ],
                          ),

                          ElevatedButton(
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreenPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Save & Exit".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


    );
  }
}
