import 'package:flutter/material.dart';

//UserModel? currentUser;

String secretValue = 'hasura@1907';
String psqlDb = 'secret';
String secretKey = 'x-hasura-admin-secret';
String jigAddress = '';

List<String> roles = [
  'Super Admin',
  'Design Admin',
  'Test Admin',
  'Design User',
  'Test User'
];

List<List<String>> saDashboardItem = [
  ['Dashboard', 'assets/dashboard.svg'],
  ['Products', 'assets/notepad.svg'],
  ['Work Orders', 'assets/hexfiles.svg'],
  ['Reports', 'assets/stack.svg'],
  ['Users', 'assets/people.svg'],
];

List<List<String>> daDashboardItem = [
  ['Products', 'assets/notepad.svg'],
  ['Reports', 'assets/stack.svg'],
  ['Users', 'assets/people.svg'],
];

List<List<String>> taDashboardItem = [
  ['Work Orders', 'assets/hexfiles.svg'],
  ['Assign', 'assets/assign.svg'],
  ['Reports', 'assets/stack.svg'],
  ['Users', 'assets/people.svg'],
];

List<List<String>> duDashboardItem = [
  ['Dashboard', 'assets/dashboard.svg'],
];

List<List<String>> tuDashboardItem = [
  ['Dashboard', 'assets/dashboard.svg'],
  ['HexFile', 'assets/hexfiles.svg'],
  ['Test', 'assets/assign.svg']
];

Map<String, String> avatarList = {
  'avatar1': 'assets/avatar/avatar1.svg',
  'avatar2': 'assets/avatar/avatar2.svg',
  'avatar3': 'assets/avatar/avatar3.svg',
  'avatar4': 'assets/avatar/avatar4.svg',
  'avatar5': 'assets/avatar/avatar5.svg',
  'avatar6': 'assets/avatar/avatar6.svg',
  'avatar7': 'assets/avatar/avatar7.svg',
  'avatar8': 'assets/avatar/avatar8.svg',
  'avatar9': 'assets/avatar/avatar9.svg',
  'avatar10': 'assets/avatar/avatar10.svg',
  'avatar11': 'assets/avatar/avatar11.svg',
  'avatar12': 'assets/avatar/avatar12.svg',
  'avatar13': 'assets/avatar/avatar13.svg',
  'avatar14': 'assets/avatar/avatar14.svg',
  'avatar15': 'assets/avatar/avatar15.svg',
};

List<String> avatarArr = [
  'avatar1',
  'avatar2',
  'avatar3',
  'avatar4',
  'avatar5',
  'avatar6',
  'avatar7',
  'avatar8',
  'avatar9',
  'avatar10',
  'avatar11',
  'avatar12',
  'avatar13',
  'avatar14',
  'avatar15',
];

// Common Methods
void popDialog({String? title, String? msg, BuildContext? context}) {
  showDialog(
      context: context!,
      builder: (c) => AlertDialog(
            title: Text(title!),
            content: Text(msg!),
            actions: [
              TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ));
}
