import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:production_automation_testing/service/apiservice.dart';

import '../../Model/APIModel/workorderprogressreport.dart';
final workorderProgressReportNotifier =
    StateNotifierProvider<WorkOrderProgressReportProvider, WorkOrderProgressReportState>((ref){
      return WorkOrderProgressReportProvider(ref);
    });

class WorkOrderProgressReportProvider extends StateNotifier<WorkOrderProgressReportState>{
  Ref ref;

  WorkOrderProgressReportProvider(this.ref) : super(WorkOrderProgressReportState(false, const AsyncLoading(), 'initial'));


  workorderprogressReport(var user_id, var start_date, var end_date) async {
    state = _loading();
    final data = await ref.read(apiProvider).getworkorderprogressreport(user_id, start_date, end_date);

    if(data != null){
      state =_dataState(data);
    }else if(data == null){
      state = _errorState('Timeout');
    }
    return state;
  }



  WorkOrderProgressReportState _dataState(List<WorkorderProgressReportModel> entity){
    return WorkOrderProgressReportState(false, AsyncData(entity), '');
  }

  WorkOrderProgressReportState _loading(){
    return WorkOrderProgressReportState(true, state.id, "");
  }

  WorkOrderProgressReportState _errorState(String errMsg){
    return WorkOrderProgressReportState(false, state.id, errMsg);
  }



}

class WorkOrderProgressReportState {
  bool isLoading;
  AsyncValue<List<WorkorderProgressReportModel>> id;
  String error;

  WorkOrderProgressReportState(this.isLoading,this.id,this.error);
}