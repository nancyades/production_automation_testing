import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:production_automation_testing/Model/APIModel/workorderbasedreport.dart';
import 'package:production_automation_testing/service/apiservice.dart';

import '../../Model/APIModel/workorderprogressreport.dart';
final workorderbasedReportNotifier =
StateNotifierProvider<WorkOrderbasedReportProvider, WorkOrderbasedReportState>((ref){
  return WorkOrderbasedReportProvider(ref);
});

class WorkOrderbasedReportProvider extends StateNotifier<WorkOrderbasedReportState>{
  Ref ref;

  WorkOrderbasedReportProvider(this.ref) : super(WorkOrderbasedReportState(false, const AsyncLoading(), 'initial'));


  workorderbasedReport(var user_id) async {
    state = _loading();
    final data = await ref.read(apiProvider).getNewWorkorderbasedreport(user_id);

    if(data != null){
      state =_dataState(data);
    }else if(data == null){
      state = _errorState('Timeout');
    }
    return state;
  }



  WorkOrderbasedReportState _dataState(List<NewWorkorderbasedReport> entity){
    return WorkOrderbasedReportState(false, AsyncData(entity), '');
  }

  WorkOrderbasedReportState _loading(){
    return WorkOrderbasedReportState(true, state.id, "");
  }

  WorkOrderbasedReportState _errorState(String errMsg){
    return WorkOrderbasedReportState(false, state.id, errMsg);
  }



}

class WorkOrderbasedReportState {
  bool isLoading;
  AsyncValue<List<NewWorkorderbasedReport>> id;
  String error;

  WorkOrderbasedReportState(this.isLoading,this.id,this.error);
}