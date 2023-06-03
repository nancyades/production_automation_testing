
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/AppClass.dart';
import '../model/testModel.dart';

final loginRoleDropdownProvider = StateProvider<String>((ref) => 'Select Product');

final isActiveCbStateProvider = StateProvider<bool>((ref) => true);

final flipStateProvider = StateProvider<bool>((ref) => true);

final assaignStateProvider = StateProvider<bool>((ref) => false);

final testStartedProvider = StateProvider<bool>((ref) => false);

final profileImagesVisibilityProvider = StateProvider<bool>((ref) => false);

final assaignTaskStateProvider = StateProvider<List<TestModel>>((ref) => []);

final dropdownProvider = StateProvider<String>((ref) => 'Select Product');

final workOrderDropDownProvider = StateProvider<String>((ref) => 'Select Product');

final productDropDownProvider = StateProvider<String>((ref) => 'Select Product');

final profilePictureProvider = StateProvider<String>((ref) => 'Select Product');

final lastTestSentProvider = StateProvider<String?>((ref) => null);

final lastPacketSentProvider = StateProvider<String?>((ref) => null);

final lastPacketReceivedProvider = StateProvider<String?>((ref) => null);




final serialNoTCPProvider = StateProvider<String>((ref) => '');

final jigAddressTestProvider = StateProvider<String>((ref) => jigAddress);

final macAddressTestProvider = StateProvider<String>((ref) => '-');

final isOnlineTestProvider = StateProvider<bool>((ref) => false);

