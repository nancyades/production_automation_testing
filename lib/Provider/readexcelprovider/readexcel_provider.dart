import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:production_automation_testing/Model/APIModel/workorderbasedreport.dart';
import 'package:production_automation_testing/Model/readexcelmodel.dart';
import 'package:production_automation_testing/service/apiservice.dart';

import '../../Model/APIModel/productmodel.dart';
import '../../Model/APIModel/workorderprogressreport.dart';
final readexcelNotifier =
StateNotifierProvider<ReadExcelProvider, ReadExcelState>((ref){
  return ReadExcelProvider(ref);
});

class ReadExcelProvider extends StateNotifier<ReadExcelState>{
  Ref ref;

  ReadExcelProvider(this.ref) : super(ReadExcelState(false, const AsyncLoading(), 'initial'));


  readexcel(var productid) async {
    state = _loading();
    final data = await ref.read(apiProvider).getTemplateexcel(productid);

    if(data != null){
      state =_dataState(data);
    }else if(data == null){
      state = _errorState('Timeout');
    }
    return state;
  }



  ReadExcelState _dataState(List<Productmodel> entity){
    return ReadExcelState(false, AsyncData(entity), '');
  }

  ReadExcelState _loading(){
    return ReadExcelState(true, state.id, "");
  }

  ReadExcelState _errorState(String errMsg){
    return ReadExcelState(false, state.id, errMsg);
  }



}

class ReadExcelState {
  bool isLoading;
  AsyncValue<List<Productmodel>> id;
  String error;

  ReadExcelState(this.isLoading,this.id,this.error);
}