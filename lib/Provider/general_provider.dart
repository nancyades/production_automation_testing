import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Helper/AppClass.dart';
final loginPasswordToggle = StateProvider<bool>((ref) => false);

final allUsers = StateProvider<bool>((ref) => false);

final ActiveUser = StateProvider<bool>((ref) => false);

final inActiveUser = StateProvider<bool>((ref) => false);

final serialNoTestProvider = StateProvider<String>((ref) => serialAddress);