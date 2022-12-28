import 'package:flutter/material.dart';
import 'package:production_automation_testing/DashBoard/src/subheader.dart';

class MeetingSection extends StatelessWidget {
  const MeetingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SubHeader(
            title: 'Meetings',
          ),
          Container(
            height: 100.0,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
              child: Row(
                children: [
                  Container(
                    width: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)
                      )
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27 - 60.0,
                    padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Project OverView',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                )
                            ),
                            Icon(
                              Icons.more_horiz,
                              size: 20.0,
                              color: Colors.black26,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                            '08 AM - 10 AM',
                            style: TextStyle(
                              fontSize: 9.0,
                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 13.0),
                          height: 50.0,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0.0,
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: Colors.white
                                      )
                                    ),
                                  )),
                              Positioned(
                                  left: 20.0,
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.white
                                        )
                                    ),
                                  )),
                              Positioned(
                                  left: 40.0,
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                  /*    image: DecorationImage(
                                          image:  NetworkImage('https://unsplash.com/photos/80JjLrCUo64'),),*/

                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.white
                                        )

                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),

        ],
      ),
    );
  }
}
