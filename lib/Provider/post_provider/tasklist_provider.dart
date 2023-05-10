
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final getTaskListNotifier =
StateNotifierProvider<AddTaskListProvider, AddTaskListState>((ref) {
  return AddTaskListProvider(ref);
});

class AddTaskListProvider extends StateNotifier<AddTaskListState> {
  Ref ref;

  AddTaskListProvider(this.ref)
      : super(AddTaskListState(false, const AsyncLoading(), 'initial'));

  addTaskList(var userid) async {
    state = _loading();
    final data = await ref.read(apiProvider).getsingleusertasklist(userid);

    if (data != null) {
      state = _dataState(data);
      print(state);
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTaskListState _dataState(List<dynamic> entity) {
    return AddTaskListState(false, AsyncData(entity), '');
  }

  AddTaskListState _loading() {
    print(state);
    return AddTaskListState(true, state.id, '');
  }

  AddTaskListState _errorState(String errMsg) {
    return AddTaskListState(false, state.id, errMsg);
  }

}


class AddTaskListState {
  bool isLoading;
  AsyncValue<List<dynamic>> id;
  String error;

  AddTaskListState(this.isLoading,this.id, this.error);


}
