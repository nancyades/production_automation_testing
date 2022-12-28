import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Feather.search,
                color: Colors.black45,
                size: 20.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Container(
                height: 20.0,
                width: 20.0,
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Colors.black54,
                      size: 20.0,
                    ),
                    Align(
                      alignment: Alignment(0.7, -0.5),
                      child: Container(
                        height: 5.0,
                        width: 5.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Super Admin',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                    )
                ),
              ),
              Icon(
                Feather.user,
                color: Colors.black45,
                size: 25.0,
              ),
            ],
          ),

      /*    ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child:
              Center(
                  child: Container(
                      child: Image(
                image: AssetImage(
                  'assets/images/rax_logo.png',
                ),
                height: 30.0,
                width: 30.0,
                fit: BoxFit.cover,
              )))
              )*/
        ],
      ),
    );
  }
}
