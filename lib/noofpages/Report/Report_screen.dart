import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Reportscreen extends ConsumerStatefulWidget {
  const Reportscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<Reportscreen> createState() => _ReportscreenState();
}

class _ReportscreenState extends ConsumerState<Reportscreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
              children:[Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                          children:const [
                            Text(
                              "Reports",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ]
                      ),
                    ),
                  ]),
              ]),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(left: 32.0),
              child:Row(
                children:[
                  ElevatedButton(
                      child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFFAAA1E),
                                  ),

                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("All".toUpperCase(),
                                    style: TextStyle(fontSize: 14)))]),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Color(0xff6C6CE5)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Color(0xff6C6CE5))))),
                      onPressed: () {
                        // setState(() {
                        //   all = true;
                        //   create = false;
                        //   verify = false;
                        //   approve = false;
                        //   reject = false;
                        // });
                      }),
                  SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                      child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFFAAA1E),
                                  ),

                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("All".toUpperCase(),
                                    style: TextStyle(fontSize: 14)))]),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Color(0xff6C6CE5)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Color(0xff6C6CE5))))),
                      onPressed: () {
                        // setState(() {
                        //   all = true;
                        //   create = false;
                        //   verify = false;
                        //   approve = false;
                        //   reject = false;
                        // });
                      }),
                  SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                      child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFFAAA1E),
                                  ),

                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left:5.0),
                                child: Text("All".toUpperCase(),
                                    style: TextStyle(fontSize: 14)))]),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Color(0xff6C6CE5)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Color(0xff6C6CE5))))),
                      onPressed: () {
                        // setState(() {
                        //   all = true;
                        //   create = false;
                        //   verify = false;
                        //   approve = false;
                        //   reject = false;
                        // });
                      })
                ],
              ))]);

  }
}
