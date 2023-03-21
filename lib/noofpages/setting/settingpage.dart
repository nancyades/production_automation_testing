import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       color: Colors.pink,
     );
  }
}
