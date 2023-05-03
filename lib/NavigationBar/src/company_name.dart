import 'package:flutter/material.dart';
import 'package:production_automation_testing/Helper/helper.dart';

class CompanyName extends StatefulWidget {
  const CompanyName({Key? key}) : super(key: key);

  @override
  State<CompanyName> createState() => _CompanyNameState();
}

class _CompanyNameState extends State<CompanyName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10, right: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  Helper.sharedRoleId.toString().split(" ").first[0] + Helper.sharedRoleId.toString().split(" ").last[0],
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333951),
                ),
              ),
            ))
          /*  Text(
              Helper.sharedRoleId.toString().split(' ').first ,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
            Text(
               Helper.sharedRoleId.toString().split(' ').last,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            )*/
          ],
        ),
      ),
    );
  }
}
