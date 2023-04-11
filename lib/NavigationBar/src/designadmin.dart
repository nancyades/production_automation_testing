import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Provider/navigation_provider.dart';

class DesignadminNavBar extends ConsumerStatefulWidget {
  const DesignadminNavBar({Key? key}) : super(key: key);

  @override
  _DesignadminNavBarState createState() => _DesignadminNavBarState();
}

class _DesignadminNavBarState extends ConsumerState<DesignadminNavBar> {
  List<bool> selected = [false, false, false, false, false];

  void select(int n) {
    for (int i = 0; i < 4; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: SingleChildScrollView(
          child:Column(
            children: [
              DesignadminNavBarItem(
                active: selected[0],
                icon: Icons.home,
                name: 'Dashboard',
                touched: () {
                  print("print 0 ");
                  ref.read(navNotifier.notifier).currentIndex(0);
                  setState(() {
                    select(0);
                  });
                },
              ),

              DesignadminNavBarItem(
                active: selected[1],
                icon: Icons.ballot_sharp,
                name: ' Product ',
                touched: () {
                  ref.read(navNotifier.notifier).currentIndex(2);
                  setState(() {
                    select(1);
                  });
                },
              ),

              DesignadminNavBarItem(
                active: selected[2],
                icon: Icons.contacts,
                name: '   User  ',
                touched: () {
                  ref.read(navNotifier.notifier).currentIndex(4);
                  setState(() {
                    select(2);
                  });
                },
              ),

              DesignadminNavBarItem(
                active: selected[3],
                icon: Icons.settings,
                name: ' setting ',
                touched: () {
                  ref.read(navNotifier.notifier).currentIndex(6);
                  setState(() {
                    select(3);
                  });
                },
              ),
              DesignadminNavBarItem(
                active: selected[4],
                icon: Icons.report,
                name: ' Report ',
                touched: () {
                  ref.read(navNotifier.notifier).currentIndex(7);
                  setState(() {
                    select(4);
                  });
                },
              ),
            ],
          ),
        ));
  }
}

class DesignadminNavBarItem extends StatefulWidget {
  final IconData? icon;
  final Function? touched;
  final bool? active;
  final String name;

  DesignadminNavBarItem({this.icon, this.touched, this.active, required this.name});

  @override
  State<DesignadminNavBarItem> createState() => _DesignadminNavBarItemState();
}

class _DesignadminNavBarItemState extends State<DesignadminNavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.touched!();
        },
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              Container(
                height: 60.0,
                width: 100.0,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 475),
                      height: 35.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                          color: widget.active!
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Column(
                        children: [
                          Icon(
                            widget.icon,
                            color: widget.active! ? Colors.white : Colors.white54,
                            size: 19.0,
                          ),
                          Text(widget.name.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0,
                                color: widget.active! ? Colors.white : Colors.white54,)),
                        ],
                      ),
                    ),


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
