import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';





final addUserNotifier =
StateNotifierProvider<AddUserProvider, AddUserState>((ref) {
  return AddUserProvider(ref);
});

class AddUserProvider extends StateNotifier<AddUserState> {
  Ref ref;

  AddUserProvider(this.ref)
      : super(AddUserState(false, const AsyncLoading(), 'initial'));

  addUser(var user) async {
    state = _loading();
    final data = await ref.read(apiProvider).insertUser(user);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddUserState _dataState(String entity) {
    return AddUserState(false, AsyncData(entity), '');
  }

  AddUserState _loading() {
    print(state);
    return AddUserState(true, state.id, '');
  }

  AddUserState _errorState(String errMsg) {
    return AddUserState(false, state.id, errMsg);
  }

}


class AddUserState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddUserState(this.isLoading,this.id, this.error);


}





final updateUserNotifier =
StateNotifierProvider<UpdateUserProvider, AddUserState>((ref) {
  return UpdateUserProvider(ref);
});

class UpdateUserProvider extends StateNotifier<AddUserState> {
  Ref ref;

  UpdateUserProvider(this.ref)
      : super(AddUserState(false, const AsyncLoading(), 'initial'));

  updatetUser(var UpdateUser) async {
    state = _loading();
    final data = await ref.read(apiProvider)
        .updatetUser(UpdateUser);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddUserState _dataState(String entity) {
    return AddUserState(false, AsyncData(entity), '');
  }

  AddUserState _loading() {
    print(state);
    //print(state.id);
    return AddUserState(true, state.id, '');
  }

  AddUserState _errorState(String errMsg) {
    return AddUserState(false, state.id, errMsg);
  }

}