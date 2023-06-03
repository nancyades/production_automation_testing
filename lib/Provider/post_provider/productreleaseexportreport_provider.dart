import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/apiservice.dart';

final getproductreleseexportexcelNotifier =
StateNotifierProvider<getproductreleseexportexcelProvider, getproductreleseexportexcelState>((ref) {
  return getproductreleseexportexcelProvider(ref);
});

class getproductreleseexportexcelProvider extends StateNotifier<getproductreleseexportexcelState> {
  Ref ref;

  getproductreleseexportexcelProvider(this.ref)
      : super(getproductreleseexportexcelState(false, const AsyncLoading(), 'initial'));

  getproductreleseexport() async {
    state = _loading();
    final data = await ref.read(apiProvider).getProductReleseexportreport();

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  getproductreleseexportexcelState _dataState(String entity) {
    return getproductreleseexportexcelState(false, AsyncData(entity), '');
  }

  getproductreleseexportexcelState _loading() {
    print(state);
    return getproductreleseexportexcelState(true, state.id, '');
  }

  getproductreleseexportexcelState _errorState(String errMsg) {
    return getproductreleseexportexcelState(false, state.id, errMsg);
  }

}


class getproductreleseexportexcelState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  getproductreleseexportexcelState(this.isLoading,this.id, this.error);


}
