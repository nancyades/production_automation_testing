import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';





final getworkorderprogressexportexcelNotifier =
StateNotifierProvider<getworkorderprogressexportexcelProvider, getworkorderprogressexportexcelState>((ref) {
  return getworkorderprogressexportexcelProvider(ref);
});

class getworkorderprogressexportexcelProvider extends StateNotifier<getworkorderprogressexportexcelState> {
  Ref ref;

  getworkorderprogressexportexcelProvider(this.ref)
      : super(getworkorderprogressexportexcelState(false, const AsyncLoading(), 'initial'));

  getworkorderprogressexportexcel(var user_id, var startdate, var enddate) async {
    state = _loading();
    final data = await ref.read(apiProvider).getworkorderprogressexportexcelreport(user_id, startdate,enddate);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  getworkorderprogressexportexcelState _dataState(String entity) {
    return getworkorderprogressexportexcelState(false, AsyncData(entity), '');
  }

  getworkorderprogressexportexcelState _loading() {
    print(state);
    return getworkorderprogressexportexcelState(true, state.id, '');
  }

  getworkorderprogressexportexcelState _errorState(String errMsg) {
    return getworkorderprogressexportexcelState(false, state.id, errMsg);
  }

}


class getworkorderprogressexportexcelState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  getworkorderprogressexportexcelState(this.isLoading,this.id, this.error);


}
