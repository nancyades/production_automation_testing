

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final addTestNotifier =
StateNotifierProvider<AddTestProvider, AddTestState>((ref) {
  return AddTestProvider(ref);
});

class AddTestProvider extends StateNotifier<AddTestState> {
  Ref ref;

  AddTestProvider(this.ref)
      : super(AddTestState(false, const AsyncLoading(), 'initial'));

  addTest(var Test) async {
    state = _loading();
    final data = await ref.read(apiProvider). insertTest(Test);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTestState _dataState(String entity) {
    return AddTestState(false, AsyncData(entity), '');
  }

  AddTestState _loading() {
    print(state);
    return AddTestState(true, state.id, '');
  }

  AddTestState _errorState(String errMsg) {
    return AddTestState(false, state.id, errMsg);
  }

}


class AddTestState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddTestState(this.isLoading,this.id, this.error);


}





final updateTestNotifier =
StateNotifierProvider<UpdateTestProvider, AddTestState>((ref) {
  return UpdateTestProvider(ref);
});

class UpdateTestProvider extends StateNotifier<AddTestState> {
  Ref ref;

  UpdateTestProvider(this.ref)
      : super(AddTestState(false, const AsyncLoading(), 'initial'));

  updatetTest(var UpdateTest) async {
    state = _loading();
    final data = await ref.read(apiProvider).UpdateTest(UpdateTest);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTestState _dataState(String entity) {
    return AddTestState(false, AsyncData(entity), '');
  }

  AddTestState _loading() {
    print(state);
    //print(state.id);
    return AddTestState(true, state.id, '');
  }

  AddTestState _errorState(String errMsg) {
    return AddTestState(false, state.id, errMsg);
  }

}