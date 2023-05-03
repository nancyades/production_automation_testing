

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final addTaskNotifier =
StateNotifierProvider<AddTaskProvider, AddTaskState>((ref) {
  return AddTaskProvider(ref);
});

class AddTaskProvider extends StateNotifier<AddTaskState> {
  Ref ref;

  AddTaskProvider(this.ref)
      : super(AddTaskState(false, const AsyncLoading(), 'initial'));

  addTask(var task) async {
    state = _loading();
    final data = await ref.read(apiProvider). insertTask(task);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTaskState _dataState(String entity) {
    return AddTaskState(false, AsyncData(entity), '');
  }

  AddTaskState _loading() {
    print(state);
    return AddTaskState(true, state.id, '');
  }

  AddTaskState _errorState(String errMsg) {
    return AddTaskState(false, state.id, errMsg);
  }

}


class AddTaskState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddTaskState(this.isLoading,this.id, this.error);


}





final updateTaskNotifier =
StateNotifierProvider<UpdateTaskProvider, AddTaskState>((ref) {
  return UpdateTaskProvider(ref);
});

class UpdateTaskProvider extends StateNotifier<AddTaskState> {
  Ref ref;

  UpdateTaskProvider(this.ref)
      : super(AddTaskState(false, const AsyncLoading(), 'initial'));

  updatetTask(var UpdateTask) async {
    state = _loading();
    final data = await ref.read(apiProvider).UpdateTask(UpdateTask);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTaskState _dataState(String entity) {
    return AddTaskState(false, AsyncData(entity), '');
  }

  AddTaskState _loading() {
    print(state);
    //print(state.id);
    return AddTaskState(true, state.id, '');
  }

  AddTaskState _errorState(String errMsg) {
    return AddTaskState(false, state.id, errMsg);
  }

}