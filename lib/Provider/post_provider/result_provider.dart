
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final addResultNotifier =
StateNotifierProvider<AddResultProvider, AddResultState>((ref) {
  return AddResultProvider(ref);
});

class AddResultProvider extends StateNotifier<AddResultState> {
  Ref ref;

  AddResultProvider(this.ref)
      : super(AddResultState(false, const AsyncLoading(), 'initial'));

  addResult(var Result) async {
    state = _loading();
    final data = await ref.read(apiProvider). insertResult(Result);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddResultState _dataState(String entity) {
    return AddResultState(false, AsyncData(entity), '');
  }

  AddResultState _loading() {
    print(state);
    return AddResultState(true, state.id, '');
  }

  AddResultState _errorState(String errMsg) {
    return AddResultState(false, state.id, errMsg);
  }

}


class AddResultState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddResultState(this.isLoading,this.id, this.error);


}
