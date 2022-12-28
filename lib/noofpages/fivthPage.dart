import 'package:flutter/material.dart';
class FivthPage extends StatefulWidget {
  const FivthPage({Key? key}) : super(key: key);

  @override
  State<FivthPage> createState() => _FivthPageState();
}

class _FivthPageState extends State<FivthPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.teal,
    );
  }
}