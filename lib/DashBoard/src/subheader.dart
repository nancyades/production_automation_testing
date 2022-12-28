import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final String? title;

  SubHeader({
    this.title,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.0,right: 30.0, top: 5.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
             title!,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
              )
          ),
          Text(
              'view All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
                color: Colors.black45
              )
          ),
        ],
      ),
      

    );
  }
}
