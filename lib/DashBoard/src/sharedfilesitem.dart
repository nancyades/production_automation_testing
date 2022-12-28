import 'package:flutter/material.dart';

class SharedFilesItem extends StatefulWidget {
  final Color? color;
  final String? et;
  final String? fileSize;
  final String? members;
  final String? sharedFileName;

      SharedFilesItem({
     this.color,
     this.et,
     this.fileSize,
     this.members,
     this.sharedFileName,
  });



  @override
  State<SharedFilesItem> createState() => _SharedFilesItemState();
}

class _SharedFilesItemState extends State<SharedFilesItem> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value){
        setState(() {
          hovered = true;
        });
      },
      onExit: (value){
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        margin: EdgeInsets.only(bottom: 10.0,left: 40.0, right: 15.0),
        padding: EdgeInsets.all(10.0),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: hovered ?
          [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 13.0,
              spreadRadius: 0.0
            )
          ]
            :[]),
        child: Expanded(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          height: 28.0,
                          width: 28.0,
                          decoration: BoxDecoration(
                            color: widget.color!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Center(
                            child: Icon(
                              Icons.folder,
                              color: widget.color!,
                              size: 15.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          widget.sharedFileName!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            widget.members!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                                color: Colors.black45
                            ),
                          ),
                         ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            widget.et!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              color: Colors.black45
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            widget.fileSize!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              color: Colors.black87
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
