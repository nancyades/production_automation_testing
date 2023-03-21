import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/apiservice.dart';


final addProductNotifier =
StateNotifierProvider<AddProductProvider, AddProductState>((ref) {
  return AddProductProvider(ref);
});

class AddProductProvider extends StateNotifier<AddProductState> {
  Ref ref;

  AddProductProvider(this.ref)
      : super(AddProductState(false, const AsyncLoading(), 'initial'));

  addProducts(var products) async {
    state = _loading();
    final data = await ref.read(apiProvider).insertProduct(products);

    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddProductState _dataState(String entity) {
    return AddProductState(false, AsyncData(entity), '');
  }

  AddProductState _loading() {
    print(state);
    return AddProductState(true, state.id, '');
  }

  AddProductState _errorState(String errMsg) {
    return AddProductState(false, state.id, errMsg);
  }

}


class AddProductState {
  bool isLoading;
  AsyncValue<String> id;
  String error;

  AddProductState(this.isLoading,this.id, this.error);


}





final updateProductsNotifier =
StateNotifierProvider<UpdateProductProvider, AddProductState>((ref) {
  return UpdateProductProvider(ref);
});

class UpdateProductProvider extends StateNotifier<AddProductState> {
  Ref ref;

  UpdateProductProvider(this.ref)
      : super(AddProductState(false, const AsyncLoading(), 'initial'));

  updatetProduct(var UpdateProduct) async {
    state = _loading();
    final data = await ref.read(apiProvider)
        .UpdateProduct(UpdateProduct);
    if (data != null) {
      state = _dataState(data.toString());
    } else if (data == null) {
      state = _errorState('Timeout');
    }
    return state;
  }

  AddProductState _dataState(String entity) {
    return AddProductState(false, AsyncData(entity), '');
  }

  AddProductState _loading() {
    print(state);
    //print(state.id);
    return AddProductState(true, state.id, '');
  }

  AddProductState _errorState(String errMsg) {
    return AddProductState(false, state.id, errMsg);
  }

}