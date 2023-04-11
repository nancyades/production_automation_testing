import 'package:flutter/material.dart';
import 'package:production_automation_testing/LoginPage/loginscreen.dart';
import 'package:production_automation_testing/NavigationBar/src/company_name.dart';
import 'package:production_automation_testing/NavigationBar/src/designadmin.dart';
import 'package:production_automation_testing/NavigationBar/src/designuser.dart';
import 'package:production_automation_testing/NavigationBar/src/navbar.dart';
import 'package:production_automation_testing/NavigationBar/src/superadmin.dart';
import 'package:production_automation_testing/NavigationBar/src/testadmin.dart';
import 'package:production_automation_testing/NavigationBar/src/testuser.dart';

import '../Helper/helper.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({Key? key}) : super(key: key);

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {


  @override
  Widget build(BuildContext context) {


    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100,
        color: Color(0xff333951),
        child: Stack(
          children: [
            CompanyName(),
            Align(
              alignment: Alignment.center,
                child: Helper.sharedRoleId == "Super Admin"
                    ? SuperadminNavBar()
                    : Helper.sharedRoleId == "Design Admin"
                    ? DesignadminNavBar()
                    : Helper.sharedRoleId == "Test Admin"
                    ? TestadminNavBar()
                    : Helper.sharedRoleId == "Design User"
                    ? DesignuserNavBar()
                    : Helper.sharedRoleId == "Test User"
                    ? TestuserNavBar()
                    : Container(color: Colors.pinkAccent,
                )

            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: NavBarItem(
                  name: "Log out",
                  icon: Icons.login_rounded,
                  active: false,
                  touched: (){
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
