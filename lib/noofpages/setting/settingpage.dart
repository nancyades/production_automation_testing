import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                child: Image.asset('assets/images/banner.png', width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
              ),
            ],
          ),
          Positioned(
              top: 150,
              left: 400,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent
                ),
              ))
        ],
      ),
    );
  }
}
