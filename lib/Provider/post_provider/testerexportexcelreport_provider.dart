import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';


final gettesterexportexcelNotifier =
StateNotifierProvider<gettesterexportexcelProvider, gettesterexportexcelState>((ref) {
  return gettesterexportexcelProvider(ref);
});

class gettesterexportexcelProvider extends StateNotifier<gettesterexportexcelState> {
  Ref ref;

  gettesterexportexcelProvider(this.ref)
      : super(gettesterexportexcelState(false, const AsyncLoading(), 'initial'));

  gettesterexportexcel(var user_id, var startdate, var enddate) async {
    state = _loading();
    final data = await ref.read(apiProvider).getTesterexportexcelreport(user_id, startdate,enddate);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  gettesterexportexcelState _dataState(String entity) {
    return gettesterexportexcelState(false, AsyncData(entity), '');
  }

  gettesterexportexcelState _loading() {
    print(state);
    return gettesterexportexcelState(true, state.id, '');
  }

  gettesterexportexcelState _errorState(String errMsg) {
    return gettesterexportexcelState(false, state.id, errMsg);
  }

}


class gettesterexportexcelState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  gettesterexportexcelState(this.isLoading,this.id, this.error);


}

