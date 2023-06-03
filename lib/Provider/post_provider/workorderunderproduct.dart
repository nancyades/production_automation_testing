import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/workorderunderproduct.dart';

import 'package:production_automation_testing/service/apiservice.dart';




final workorderunderproductReportNotifier =
StateNotifierProvider<WorkOrderunderproductReportProvider, WorkOrderunderproductReportState>((ref){
  return WorkOrderunderproductReportProvider(ref);
});

class WorkOrderunderproductReportProvider extends StateNotifier<WorkOrderunderproductReportState>{
  Ref ref;

  WorkOrderunderproductReportProvider(this.ref) : super(WorkOrderunderproductReportState(false, const AsyncLoading(), 'initial'));


  workorderunderproductReport(var workorder_id) async {
    state = _loading();
    final data = await ref.read(apiProvider).getproductunderWorkorderreport(workorder_id);

    if(data != null){
      state =_dataState(data);
    }else if(data == null){
      state = _errorState('Timeout');
    }
    return state;
  }



  WorkOrderunderproductReportState _dataState(List<workorderunderproduct> entity){
    return WorkOrderunderproductReportState(false, AsyncData(entity), '');
  }

  WorkOrderunderproductReportState _loading(){
    return WorkOrderunderproductReportState(true, state.id, "");
  }

  WorkOrderunderproductReportState _errorState(String errMsg){
    return WorkOrderunderproductReportState(false, state.id, errMsg);
  }



}

class WorkOrderunderproductReportState {
  bool isLoading;
  AsyncValue<List<workorderunderproduct>> id;
  String error;

  WorkOrderunderproductReportState(this.isLoading,this.id,this.error);
}