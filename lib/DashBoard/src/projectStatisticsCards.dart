import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ProjectStatisticCards extends StatelessWidget {
  const ProjectStatisticCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 10,
        ),
        ProjectStatisticCard(
          count: '125',
          name: 'All finished Project',
          description: '2 Project out of time',
          progress: 0.75,
          progressString: "75%",
          color: Color(0xffFFAAA1E),
        ),
        ProjectStatisticCard(
          count: '1105',
          name: 'Customer intterest',
          description: '+ 576 new cilients',
          progress: 0.68,
          progressString: "48%",
          color: Color(0xff6C6CE5),
        ),
      ],
    );
  }
}

class ProjectStatisticCard extends StatelessWidget {
  final String? count;
  final String? name;
  final String? description;
  final double? progress;
  final String? progressString;
  final Color? color;

  ProjectStatisticCard({
    this.count,
    this.name,
    this.description,
    this.progress,
    this.progressString,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 85.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.010,
                      color: Colors.white
                  ),
                ),
                Text(
                  name!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.008,
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  description!,
                  style: TextStyle(
                      fontSize:width * 0.007,
                      color: Colors.white
                  ),
                )
              ],
            ),
          ),

          CircularPercentIndicator(
            radius: 35.0,
            lineWidth: 4.5,
            percent: progress!,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              progressString!,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                  color: Colors.white
              ),
            ),
            progressColor: Colors.white,
            startAngle: 270,
            backgroundColor: Colors.white54,

          )

        ],
      ),
    );
  }
}