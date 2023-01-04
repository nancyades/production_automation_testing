import 'package:flutter_riverpod/flutter_riverpod.dart';
final loginPasswordToggle = StateProvider<bool>((ref) => false);

final allUsers = StateProvider<bool>((ref) => false);

final ActiveUser = StateProvider<bool>((ref) => false);

final inActiveUser = StateProvider<bool>((ref) => false);