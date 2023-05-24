import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';

final getworkorderexcelNotifier =
StateNotifierProvider<getworkorderexcelProvider, getworkorderexcelState>((ref) {
  return getworkorderexcelProvider(ref);
});

class getworkorderexcelProvider extends StateNotifier<getworkorderexcelState> {
  Ref ref;

  getworkorderexcelProvider(this.ref)
      : super(getworkorderexcelState(false, const AsyncLoading(), 'initial'));

  addworkorder(var work_id, var pro_id, var serial_no) async {
    state = _loading();
    final data = await ref.read(apiProvider).getWorkorderbasedexcelreport(work_id, pro_id, serial_no);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  getworkorderexcelState _dataState(String entity) {
    return getworkorderexcelState(false, AsyncData(entity), '');
  }

  getworkorderexcelState _loading() {
    print(state);
    return getworkorderexcelState(true, state.id, '');
  }

  getworkorderexcelState _errorState(String errMsg) {
    return getworkorderexcelState(false, state.id, errMsg);
  }

}


class getworkorderexcelState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  getworkorderexcelState(this.isLoading,this.id, this.error);


}
