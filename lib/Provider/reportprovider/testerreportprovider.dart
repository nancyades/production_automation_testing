import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/testerreport.dart';
import 'package:production_automation_testing/service/apiservice.dart';
import '../../Model/APIModel/workorderprogressreport.dart';
final testerReportNotifier =
StateNotifierProvider<TesterReportProvider, TesterReportState>((ref){
  return TesterReportProvider(ref);
});

class TesterReportProvider extends StateNotifier<TesterReportState>{
  Ref ref;

  TesterReportProvider(this.ref) : super(TesterReportState(false, const AsyncLoading(), 'initial'));


  testerReport(var user_id, var start_date, var end_date) async {
    state = _loading();
    final data = await ref.read(apiProvider).getTesterreport(user_id, start_date, end_date);

    if(data != null){
      state =_dataState(data);
    }
   else if(data == null){
      state = _errorState('Timeout');
    }
    return state;
  }



  TesterReportState _dataState(List<TesterReportModel> entity){
    return TesterReportState(false, AsyncData(entity), '');
  }

  TesterReportState _loading(){
    return TesterReportState(true, state.id, "");
  }

  TesterReportState _errorState(String errMsg){
    return TesterReportState(false, state.id, errMsg);
  }



}

class TesterReportState {
  bool isLoading;
  AsyncValue<List<TesterReportModel>> id;
  String error;

  TesterReportState(this.isLoading,this.id,this.error);
}