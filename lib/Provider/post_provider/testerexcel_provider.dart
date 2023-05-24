import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';





final gettesterexcelNotifier =
StateNotifierProvider<gettesterexcelProvider, gettesterexcelState>((ref) {
  return gettesterexcelProvider(ref);
});

class gettesterexcelProvider extends StateNotifier<gettesterexcelState> {
  Ref ref;

  gettesterexcelProvider(this.ref)
      : super(gettesterexcelState(false, const AsyncLoading(), 'initial'));

  gettester(var pro_id, var serial_no) async {
    state = _loading();
    final data = await ref.read(apiProvider).getTesterexcelreport(pro_id, serial_no);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  gettesterexcelState _dataState(String entity) {
    return gettesterexcelState(false, AsyncData(entity), '');
  }

  gettesterexcelState _loading() {
    print(state);
    return gettesterexcelState(true, state.id, '');
  }

  gettesterexcelState _errorState(String errMsg) {
    return gettesterexcelState(false, state.id, errMsg);
  }

}


class gettesterexcelState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  gettesterexcelState(this.isLoading,this.id, this.error);


}
