import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CalendarSpace/calendarspace.dart';
import '../DashBoard/src/ProjectCardOverview.dart';
import '../DashBoard/src/projectStatisticsCards.dart';
import '../DashBoard/src/sharedfilesitem.dart';
import '../DashBoard/src/subheader.dart';
import '../DashBoard/src/tabs.dart';
class DashboardScreenPage extends StatefulWidget {
  const DashboardScreenPage({Key? key}) : super(key: key);

  @override
  State<DashboardScreenPage> createState() => _DashboardScreenPageState();
}

class _DashboardScreenPageState extends State<DashboardScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Positioned(
                      left: 100.0,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.63,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 30.0, top: 25.0, bottom: 10.0),
                              child: Text(
                                "Ongoing Project ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Tabs(),
                            Container(
                              margin: EdgeInsets.only(top:5.0),
                              height: 200.0,
                              width: MediaQuery.of(context).size.width * 0.62,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ProjectCardView(
                                      color: Color(0xffFF4C60),
                                      projectName: 'The matrix',
                                      percentComplete: '34%',
                                      progressIndicatorColor: Colors.redAccent[100],
                                      icon: Feather.moon
                                  ),
                                  ProjectCardView(
                                      color: Color(0xff6C6CE5),
                                      projectName: 'Delivery Club',
                                      percentComplete: '78%',
                                      progressIndicatorColor: Colors.blue[200],
                                      icon: Feather.truck
                                  ),
                                  ProjectCardView(
                                      color: Color(0xffFAAA1E),
                                      projectName: 'Travel Comrode',
                                      percentComplete: '82%',
                                      progressIndicatorColor: Colors.amber[200],
                                      icon: Icons.local_airport
                                  ),
                                ],
                              ),
                            ),
                            SubHeader(
                              title: 'Shared Files',
                            ),
                            SharedFilesItem(
                                color: Colors.blue,
                                sharedFileName: 'Company Gudidelines',
                                members: '12 members',
                                et: '19 Dec 2019',
                                fileSize: "2.3 MB"
                            ),
                            SharedFilesItem(
                                color: Colors.amber,
                                sharedFileName: 'Company Policy',
                                members: '30 members',
                                et: '27 Nov 2019',
                                fileSize: "4.3 MB"
                            ),
                            SharedFilesItem(
                                color: Colors.red,
                                sharedFileName: 'Wireframes',
                                members: '14 members',
                                et: '08 Oct 2019',
                                fileSize: "1.3 MB"
                            ),
                            SubHeader(
                              title: 'Project Statistics',
                            ),
                            Expanded(
                              flex: 1,
                                child: ProjectStatisticCards()),

                            Expanded(
                              flex: 2,
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('@copyright rax-tech International 2022',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0,color: Colors.black)),
                                ],
                              )),
                            ),

                          ],
                        ),
                      )),
                ],
              )
          ),
        ),
        Expanded(
          flex: 4,
            child: Calendarspace()),
      ],
    );
  }
}
