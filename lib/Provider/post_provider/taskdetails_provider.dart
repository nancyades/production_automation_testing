

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final addTaskdetailsNotifier =
StateNotifierProvider<AddTaskdetailsProvider, AddTaskdetailsState>((ref) {
  return AddTaskdetailsProvider(ref);
});

class AddTaskdetailsProvider extends StateNotifier<AddTaskdetailsState> {
  Ref ref;

  AddTaskdetailsProvider(this.ref)
      : super(AddTaskdetailsState(false, const AsyncLoading(), 'initial'));

  addTaskdetails(var workid, var prodid) async {
    state = _loading();
    final data = await ref.read(apiProvider). gettaskdetails(workid, prodid);

    if (data != null) {
      state = _dataState(data);
      print(state);
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTaskdetailsState _dataState(List<dynamic> entity) {
    return AddTaskdetailsState(false, AsyncData(entity), '');
  }

  AddTaskdetailsState _loading() {
    print(state);
    return AddTaskdetailsState(true, state.id, '');
  }

  AddTaskdetailsState _errorState(String errMsg) {
    return AddTaskdetailsState(false, state.id, errMsg);
  }

}


class AddTaskdetailsState {
  bool isLoading;
  AsyncValue<List<dynamic>> id;
  String error;

  AddTaskdetailsState(this.isLoading,this.id, this.error);


}





/*
final updateTaskdetailsNotifier =
StateNotifierProvider<UpdateTaskProvider, AddTaskdetailsState>((ref) {
  return UpdateTaskProvider(ref);
});

class UpdateTaskProvider extends StateNotifier<AddTaskdetailsState> {
  Ref ref;

  UpdateTaskProvider(this.ref)
      : super(AddTaskdetailsState(false, const AsyncLoading(), 'initial'));

  updatetTaskdetails(var UpdateTask) async {
    state = _loading();
    final data = await ref.read(apiProvider);
    //.UpdateTask(UpdateTask);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTaskdetailsState _dataState(String entity) {
    return AddTaskdetailsState(false, AsyncData(entity), '');
  }

  AddTaskdetailsState _loading() {
    print(state);
    //print(state.id);
    return AddTaskdetailsState(true, state.id, '');
  }

  AddTaskdetailsState _errorState(String errMsg) {
    return AddTaskdetailsState(false, state.id, errMsg);
  }

}*/
