import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterModelProvider = ChangeNotifierProvider((ref) => ChangeState());

class ChangeState extends ChangeNotifier {
  int value = 0;

  void press() {
    value = value + 0;
    notifyListeners();
  }
}


final widgetDateNotifier = StateNotifierProvider<WidgetDateProvider, int>((ref) {
  return WidgetDateProvider(ref);
});

class  WidgetDateProvider extends StateNotifier<int> {
  final Ref ref;

  WidgetDateProvider(this.ref) : super(-1);

  void currentIndex(int index) {
    state = index;
  }
}