import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/testerreport.dart';
import 'package:production_automation_testing/service/apiservice.dart';
import '../../Model/APIModel/workorderprogressreport.dart';





final singletesterReportNotifier =
StateNotifierProvider<SingletesterReportProvider, SingletesterReportState>((ref){
  return SingletesterReportProvider(ref);
});

class SingletesterReportProvider extends StateNotifier<SingletesterReportState>{
  Ref ref;

  SingletesterReportProvider(this.ref) : super(SingletesterReportState(false, const AsyncLoading(), 'initial'));


  singletesterReport(var user_id) async {
    state = _loading();
    final data = await ref.read(apiProvider).getSingleTesterreport(user_id);

    if(data != null){
      state =_dataState(data);
    }
    else if(data == null){
      state = _errorState('Timeout');
    }
    return state;
  }



  SingletesterReportState _dataState(List<TesterReportModel> entity){
    return SingletesterReportState(false, AsyncData(entity), '');
  }

  SingletesterReportState _loading(){
    return SingletesterReportState(true, state.id, "");
  }

  SingletesterReportState _errorState(String errMsg){
    return SingletesterReportState(false, state.id, errMsg);
  }



}

class SingletesterReportState {
  bool isLoading;
  AsyncValue<List<TesterReportModel>> id;
  String error;

  SingletesterReportState(this.isLoading,this.id,this.error);
}