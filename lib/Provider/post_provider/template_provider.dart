import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final addTemplateNotifier =
StateNotifierProvider<AddTemplateProvider, AddTemplateState>((ref) {
  return AddTemplateProvider(ref);
});

class AddTemplateProvider extends StateNotifier<AddTemplateState> {
  Ref ref;

  AddTemplateProvider(this.ref)
      : super(AddTemplateState(false, const AsyncLoading(), 'initial'));

  addTemplate(var template) async {
    state = _loading();
    final data = await ref.read(apiProvider).insertTemplate(template);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTemplateState _dataState(String entity) {
    return AddTemplateState(false, AsyncData(entity), '');
  }

  AddTemplateState _loading() {
    print(state);
    return AddTemplateState(true, state.id, '');
  }

  AddTemplateState _errorState(String errMsg) {
    return AddTemplateState(false, state.id, errMsg);
  }

}


class AddTemplateState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddTemplateState(this.isLoading,this.id, this.error);


}





final updateTemplateNotifier =
StateNotifierProvider<UpdateTemplateProvider, AddTemplateState>((ref) {
  return UpdateTemplateProvider(ref);
});

class UpdateTemplateProvider extends StateNotifier<AddTemplateState> {
  Ref ref;

  UpdateTemplateProvider(this.ref)
      : super(AddTemplateState(false, const AsyncLoading(), 'initial'));

  updatetTemplate(var UpdateTemplate) async {
    state = _loading();
    final data = await ref.read(apiProvider)
        .UpdateTemplate(UpdateTemplate);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddTemplateState _dataState(String entity) {
    return AddTemplateState(false, AsyncData(entity), '');
  }

  AddTemplateState _loading() {
    print(state);
    //print(state.id);
    return AddTemplateState(true, state.id, '');
  }

  AddTemplateState _errorState(String errMsg) {
    return AddTemplateState(false, state.id, errMsg);
  }

}