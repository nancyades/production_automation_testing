import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          Text(
            "All",
            style: GoogleFonts.alegreya(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          SizedBox(
            width: 15.0,
          ),
          Container(
            height: 25.0,
            width: 70.0,
            decoration: BoxDecoration(
              color: Color(0xff040404),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                "Current",
                style: GoogleFonts.alegreya(color: Colors.white, fontSize: 12.0),
              ),
            ),
          ),

          SizedBox(
            width: 15.0,
          ),
          Center(
            child: Text(
              "Pending",
              style: GoogleFonts.alegreya(color: Colors.black, fontSize: 12.0),
            ),
          ),

          SizedBox(
            width: 15.0,
          ),
          Center(
            child: Text(
              "Categorized",
              style: GoogleFonts.alegreya(color: Colors.black, fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }
}
