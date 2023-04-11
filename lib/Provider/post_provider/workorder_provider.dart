import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Model/APIModel/workordermodel.dart';
import '../../service/apiservice.dart';


final addWorkOrderNotifier =
StateNotifierProvider<AddWorkOrderProvider, AddWorkorderState>((ref) {
  return AddWorkOrderProvider(ref);
});

class AddWorkOrderProvider extends StateNotifier<AddWorkorderState> {
  Ref ref;

  AddWorkOrderProvider(this.ref)
      : super(AddWorkorderState(false, const AsyncLoading(), 'initial'));

  addWorkOrders(var workorder) async {
    state = _loading();
    final data = await ref.read(apiProvider).insertWorkorders(workorder);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddWorkorderState _dataState(String entity) {
    return AddWorkorderState(false, AsyncData(entity), '');
  }

  AddWorkorderState _loading() {
    print(state);
    return AddWorkorderState(true, state.id, '');
  }

  AddWorkorderState _errorState(String errMsg) {
    return AddWorkorderState(false, state.id, errMsg);
  }

}


class AddWorkorderState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddWorkorderState(this.isLoading,this.id, this.error);


}





final updateWorkorderNotifier =
StateNotifierProvider<UpdateWorkOrderProvider, AddWorkorderState>((ref) {
  return UpdateWorkOrderProvider(ref);
});

class UpdateWorkOrderProvider extends StateNotifier<AddWorkorderState> {
  Ref ref;

  UpdateWorkOrderProvider(this.ref)
      : super(AddWorkorderState(false, const AsyncLoading(), 'initial'));

  updatetWorkorder(var UpdateWorkorder) async {
    state = _loading();
    final data = await ref.read(apiProvider)
        .UpdateWorkorders(UpdateWorkorder);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddWorkorderState _dataState(String entity) {
    return AddWorkorderState(false, AsyncData(entity), '');
  }

  AddWorkorderState _loading() {
    print(state);
    //print(state.id);
    return AddWorkorderState(true, state.id, '');
  }

  AddWorkorderState _errorState(String errMsg) {
    return AddWorkorderState(false, state.id, errMsg);
  }

}