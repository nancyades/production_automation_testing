import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:production_automation_testing/Provider/tcpprovider/tcp_provider_send_data.dart';
import 'package:production_automation_testing/service/apiservice.dart';

import '../Model/excelModel.dart';
import '../Model/testmodel.dart';



class TestState {
  bool? isLoading;
  AsyncValue<List<TestModel>>? data;
  String? error;
  TestState(this.isLoading, this.data, this.error);
}

// get Tests from excel
/*final getTestListProvider =
StateNotifierProvider<GetTestNotifier, List<TestModel>>((ref) {
  return GetTestNotifier(ref);
});

class GetTestNotifier extends StateNotifier<List<TestModel>> {

  final Ref ref;

  GetTestNotifier(this.ref) : super([]);

  getAllTestList(String? productID, {String? fileName}) async {
    var filePath;
    if(productID != null) {
      filePath = await ref.read(apiProvider).getDownloadUrl(productID);
    } else {
      filePath = fileName;
    }
    if (filePath != null && filePath.toString().isNotEmpty) {
      try {

        Dio dio = Dio();
        final String downloadPath = (await getApplicationSupportDirectory()).path;
        String storagePath = downloadPath + '/Templates/' + filePath;
        await dio.download(
          ApiConstants.baseUrl + filePath, storagePath,
          onReceiveProgress: (_c, _t) async {
            print(_c / _t * 100);
            var file = downloadPath + '/Templates/' + filePath;
            var bytes = File(file).readAsBytesSync();
            var excel = Excel.decodeBytes(bytes);
            var template = excel.sheets['rax-template'];
            List<TestModel> mModel = [];

            for (int i = 0; i < template!.rows.length; i++) {
              if (i > 2) {
                var row = template.row(i);
                if (row[1] != null && row[1]!.value.toString() != "Title") {
                  mModel.add(TestModel(
                      testTitle: row[1]!.value.toString(),
                      taskId: row[0]!.value.toString(),
                      isSelected: false,
                      testIdentifyType: "2"));
                }
              }
            }
            state = [];
            state = mModel;
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  changeStatus(List<TestModel> data) {
    state = [];
    state = data;
  }

  selectAll(bool bol) {
    var tempList = state;
    for (var element in tempList) {
      element.isSelected = bol;
    }
    state = [];
    state = tempList;
  }
}*/



/*// assaign test
final assaignTestProvider =
StateNotifierProvider<assaignTestNotifier, List<String>>((ref) {
  return assaignTestNotifier(ref);
});

class assaignTestNotifier extends StateNotifier<List<String>> {
  final Ref ref;

  assaignTestNotifier(this.ref) : super([]);

  assaignTest(List<TestModel> mModel) async {
    var mList = await ref.read(apiProvider).assaignTestToUser(mModel);
    return mList;
  }
}*/

// for test
final selectWorkOrderProvider = StateProvider<TestModel?>((ref) => null);

// testList for test users
final selectedTestListNotifierProvider =
StateNotifierProvider<SelectedTestNotifier, List<TestModel>>((ref) {
  return SelectedTestNotifier(ref);
});

class SelectedTestNotifier extends StateNotifier<List<TestModel>> {
  final Ref ref;

  SelectedTestNotifier(this.ref) : super([]);

  saveSelectedList(List<TestModel> mList) {
    state = [];
    state = mList;
  }
}

// get Tests from excel
/*final extractExcelNotifierProvider =
StateNotifierProvider<ExtractExelNotifier, ExtractExcelState>((ref) {
  return ExtractExelNotifier(ref);
});

class ExtractExelNotifier extends StateNotifier<ExtractExcelState> {
  final Ref ref;

  ExtractExelNotifier(this.ref)
      : super(ExtractExcelState(false, const AsyncLoading(), ""));

  extract([String? testType]) async {
    state = _getLoadingState();
    Map finalData = await getTests();
    var selectedTests =
        ref
            .read(selectedTestListNotifierProvider.notifier)
            .state;

    Map<int, List<ExcelModel>> mMap = {};
    for (int i = 0; i < selectedTests.length; i++) {
      List<ExcelModel> mList = [];
      var element = selectedTests[i];
      finalData.forEach((key, value) {
        if (key != null) {
          if (key.toString().split('-')[2] == element.taskId!.split('-')[2]) {
            mList.add(value);
          }
        }
      });
      mMap[i] = mList;
    }
    if (mMap.isNotEmpty) {
      ExtractExcelEntity? entity;
        entity = await ref.read(apiProvider).getTestDetails();
      entity!.setExcelData(mMap);
      try {
        entity.settestIdentifyType(int.parse(testType!));
      }catch(e){
        entity.settestIdentifyType(1);
      }
      state = getDataState(entity);
      print("extract-top");
      print(entity.testIdentifyType);
    } else {
      state = getErrorState();
      print("extract-bottom");
    }

  }

  setLoadingState() {
    state = _getLoadingState();
  }

  _getLoadingState() {
    return ExtractExcelState(true, state.data, state.errorTxt);
  }

  getTests() async {
    var productID = ref.read(selectWorkOrderProvider.notifier).state!.productId;
    Map<String, ExcelModel> testList = {};
    var filePath;

      filePath = ref.read(selectWorkOrderProvider)!.filePath;

    final String downloadPath = (await getApplicationSupportDirectory()).path;
    if (filePath != null && filePath.toString().isNotEmpty) {
      Dio dio = Dio();
      String storagePath = downloadPath + '/Templates/' + filePath;
      await dio.download(
        ApiConstants.baseUrl + filePath,
        storagePath,
        onReceiveProgress: (_c, _t) async {
          print(_c / _t * 100);

          var file = downloadPath + '/Templates/' + filePath;
          var bytes = File(file).readAsBytesSync();
          var excel = Excel.decodeBytes(bytes);
          var template = excel.sheets['rax-template'];

          String testTitle = "";
          for (int i = 0; i < template!.rows.length; i++) {
            if (i > 2) {
              var row = template.row(i);
              if (row[1] != null) {
                testTitle = row[1]!.value.toString();
              }
              testList[row[0]!.value.toString()] = ExcelModel(
                  testNumber: row[0]!.value.toString(),
                  testTitle: testTitle,
                  testContent: row[2]?.value.toString(),
                  isOnlineTest: row[3]?.value.toString() == "1",
                  testType: row[4]?.value.toString(),
                  packetId: row[5]?.value.toString(),
                  packetType: row[6]?.value.toString(),
                  testUserEntry: row[7]?.value.toString(),
                  testUserWifiResult: row[8]?.value.toString(),
                  testUserPassCrieteria: row[9]?.value.toString(),
                  testRemark: row[10]?.value.toString(),
                  displayResult: testTitle == 'Title' ? 'Title' : 'UNDEFINED',
                  result: 'waiting for result'
              );
            }
          }
        },
      );
    }

    return testList;
  }

  getDataState(ExtractExcelEntity mList) {
    return ExtractExcelState(false, AsyncData(mList), state.errorTxt);
  }

  setSelectedState(dynamic mMap) {
    var data = state.data!.value;
    state = ExtractExcelState(
        false,
        AsyncData(ExtractExcelEntity(
          productName: data!.productName,
          taskId: data.taskId.toString(),
          excelData: mMap,
          serialNo: data.serialNo.toString(),
          workOrderName: data.workOrderName,
          testIdentifyType: data.testIdentifyType,
        )),
        state.errorTxt);
    print("setSelectedState");
    print(data.testIdentifyType);
  }

  getErrorState() {
    return ExtractExcelState(false, state.data, 'Something went wrong !');
  }

}*/

class ExtractExcelState {
  bool? isLoading;
  AsyncValue<ExtractExcelEntity>? data;
  String? errorTxt;

  ExtractExcelState(this.isLoading, this.data, this.errorTxt);
}

class ExtractExcelEntity {
  String? productName;
  String? workorderId;
  String? productId;
  String? workOrderName;
  String? serialNo;
  String? jigAddress;
  String? taskId;
  Map<dynamic, dynamic>? excelData;
  int? testIdentifyType;

  ExtractExcelEntity(
      { this.productName,
        this.workorderId,
        this.workOrderName,
        this.serialNo,
        this.jigAddress,
        this.taskId,
        this.excelData,
        this.productId,
        this.testIdentifyType});

  setExcelData(dynamic mList) {
    excelData = mList;
  }

  setSerialNumber(String serialNo) {
    this.serialNo = serialNo;
  }

  setjigaddress(String jigAddress) {
    this.jigAddress = jigAddress;
  }

  settestIdentifyType(int testIdentifyType) {
    this.testIdentifyType = testIdentifyType;
  }


}

// current Test
final currentStepProvider = StateProvider<int>((ref) => 0);

// save test result
/*
final saveTestResultNotifierProvider =
StateNotifierProvider<SaveTestResultNotifier, TestResultState>((ref) {
  return SaveTestResultNotifier(ref);
});

class SaveTestResultNotifier extends StateNotifier<TestResultState> {
  final Ref ref;

  SaveTestResultNotifier(this.ref)
      : super(TestResultState(TestResultStatus.initial, ''));

  saveTest(ExtractExcelEntity entity, int currentStep, String timeSpent) async {

    List<ExcelModel> testData = entity.excelData![currentStep];
    ref.read(testPdfProvider.notifier).state.addAll(testData);

    state = loadingState();
    print("saveTest");
    print(entity.testIdentifyType);
    var data = await ref.read(apiProvider).saveTestResult(testData, timeSpent, entity);
    if(data != null) {
      state = data;
      return true;
    } else {
      state = errorState();
      return false;
    }


  }

 */
/* abortTest(ExtractExcelEntity entity, int currentStep, String timeSpent) async {
    List<ExcelModel> testData = entity.excelData![currentStep];

    state = loadingState();
    print("abortTest");
    print(state);
    var data = await ref.read(apiProvider).abortTestResult(testData, timeSpent,entity);
    if(data != null) {
      state = data;

      return true;
    } else {
      state = errorState();
      return false;
    }


  }*/
/*


  loadingState() {
    return TestResultState(TestResultStatus.loading, '');
  }

  errorState() {
    return TestResultState(TestResultStatus.failure, '');
  }
}
*/

// TestResultState
enum TestResultStatus { initial, loading, success, failure }

class TestResultState {
  TestResultStatus? status;
  dynamic data;

  TestResultState(this.status, this.data);
}

class OnlineTestModel {
  String? packet;
  String? taskNo;



  OnlineTestModel(this.packet, this.taskNo);

}

// online Test
final onlineTestNotifierProvider = StateNotifierProvider<OnlineTestNotifier, TestResultState>((ref) {
  return OnlineTestNotifier(ref);
});

class OnlineTestNotifier extends StateNotifier<TestResultState> {
  Ref ref;

  OnlineTestNotifier(this.ref) : super(TestResultState(TestResultStatus.initial, ''));

  test(Map<int, OnlineTestModel> testMap) async {
    state = loadingState();
    List<OnlineTestModel> testList = [];
    testMap.forEach((key, value) {
      testList.add(value);
    });

    ref
        .read(tcpSendDataNotifier.notifier)
        .sendPacket(testList[0].packet.toString(), testList[0].taskNo.toString());

    for (int i = 1; i < testList.length; i++) {
      await Future.delayed(const Duration(seconds: 15), () {
        ref.read(tcpSendDataNotifier.notifier).sendPacket(
            testList[i].packet.toString(), testList[i].taskNo.toString());
      });
    }
  }

  loadingState() {
    return TestResultState(TestResultStatus.loading, '');
  }
}




// PDF_Provider
final testPdfProvider = StateProvider<List<ExcelModel>>((ref) => []);