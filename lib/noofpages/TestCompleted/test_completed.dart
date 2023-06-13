import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:production_automation_testing/Model/resultmodel.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/Provider/generalProvider.dart';
import 'package:production_automation_testing/Provider/post_provider/test_provider.dart';
import 'package:production_automation_testing/noofpages/Test/firsrtaskviewpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Helper/helper.dart';
import '../../HomeScreen.dart';
import '../../Model/APIModel/taskmodel.dart';
import '../../Provider/post_provider/task_provider.dart';

class TestCompleted extends ConsumerStatefulWidget {
   TestCompleted({Key? key, this.tasks}) : super(key: key);
  TaskModel? tasks;

  @override
  ConsumerState<TestCompleted> createState() => _TestCompletedState();
}

class _TestCompletedState extends ConsumerState<TestCompleted> {
  var resultupdate;
bool valus = true;

  @override
  Widget build(BuildContext context) {
  return  ref.watch(getTaskNotifier).when(data: (data){

    print(data);
    for(int i=0; i<data.length; i++){
      if(data[i].taskId == widget.tasks!.taskId){
        if(valus == true){
          for(int j=0; j<data[i].testing!.length; j++){
            if(data[i].testing![j].status == "FAIL" || data[i].testing![j].displayResult == 'FAIL'){
              setState(() {
                valus = false;
              });
            }
          }
        }
      }



    }



    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black,
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 45),
                        child: Row(
                          children: [
                            Text('Test Completed Successfully',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/images/complete.png",),
                          ),
                          Expanded(
                            child: Image.asset(
                              "assets/images/complet1.png",),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor:
                                MaterialStateProperty.all<Color>( Colors.deepPurple),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        side: BorderSide(color:  Colors.deepPurple)))),
                            onPressed: () {
                              ref.read(updateTaskNotifier.notifier).updatetTask({
                                "task_id": widget.tasks!.taskId,
                                "user_id": widget.tasks!.userId,
                                "assign_id": widget.tasks!.assignId,
                                "wol_id": widget.tasks!.wolId,
                                "quantity": widget.tasks!.quantity,
                                "start_serial_no": widget.tasks!.startSerialNo,
                                "end_serial_no": widget.tasks!.endSerialNo,
                                "status": valus == false ? "In-Progress" : "Completed",
                                "testing_status": valus == false ? "FAIL" : "PASS",
                                "start_date": widget.tasks!.startDate,
                                "end_date": widget.tasks!.endDate,
                                "created_by": widget.tasks!.createdBy.toString(),
                                "updated_by": Helper.shareduserid.toString(),
                                "created_date": widget.tasks!.createdDate,
                                "updated_date": widget.tasks!.updatedDate,
                                "flg": widget.tasks!.flg,
                                "rating": widget.tasks!.rating,
                                "workorder_id": widget.tasks!.workorderid,
                                "product_id": widget.tasks!.productid,
                                "name": widget.tasks!.username

                              });

                              ref.read(macAddressTestProvider.notifier).state = " ";

                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreenPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Save & Exit".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


    );
    }, error: (e,s){
      return Text(e.toString());
    }, loading: (){
      return Center(child: LoadingAnimationWidget.inkDrop(color: Color(0xff333951),
          size: 50,), );
    });

  }
}
