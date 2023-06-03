import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';





final getworkorderbasedtestexportexcelexportexcelNotifier =
StateNotifierProvider<getworkorderbasedtestexportexcelexportexcelProvider, getworkorderbasedtestexportexcelexportexcelState>((ref) {
  return getworkorderbasedtestexportexcelexportexcelProvider(ref);
});

class getworkorderbasedtestexportexcelexportexcelProvider extends StateNotifier<getworkorderbasedtestexportexcelexportexcelState> {
  Ref ref;

  getworkorderbasedtestexportexcelexportexcelProvider(this.ref)
      : super(getworkorderbasedtestexportexcelexportexcelState(false, const AsyncLoading(), 'initial'));

  getworkorderbasedtestexportexcelexportexcel(var workorder_id) async {
    state = _loading();
    final data = await ref.read(apiProvider).getworkorderbasedtestexportexcelreport(workorder_id);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  getworkorderbasedtestexportexcelexportexcelState _dataState(String entity) {
    return getworkorderbasedtestexportexcelexportexcelState(false, AsyncData(entity), '');
  }

  getworkorderbasedtestexportexcelexportexcelState _loading() {
    print(state);
    return getworkorderbasedtestexportexcelexportexcelState(true, state.id, '');
  }

  getworkorderbasedtestexportexcelexportexcelState _errorState(String errMsg) {
    return getworkorderbasedtestexportexcelexportexcelState(false, state.id, errMsg);
  }

}


class getworkorderbasedtestexportexcelexportexcelState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  getworkorderbasedtestexportexcelexportexcelState(this.isLoading,this.id, this.error);


}
