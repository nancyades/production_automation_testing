import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Helper/application_class.dart';
import 'package:production_automation_testing/Helper/packet_control.dart';
import 'package:production_automation_testing/Model/excelModel.dart';
import 'package:production_automation_testing/Provider/excelprovider.dart';
import 'package:production_automation_testing/Provider/generalProvider.dart';
import 'package:production_automation_testing/Provider/testProvider.dart';
import '../../Helper/helper.dart';
import '../../Model/readexcel/readecel.dart';
import '../../service/tcpclient.dart';
import '../../state/tcp_state.dart';


final tcpReceiveDataNotifier =
StateNotifierProvider.autoDispose<TcpReceiveDataProvider, TcpResponseSate>(
        (ref) {
      return TcpReceiveDataProvider(ref);
    });

class TcpReceiveDataProvider extends StateNotifier<TcpResponseSate> {
  final Ref ref;

  TcpReceiveDataProvider(this.ref)
      : super(TcpResponseSate(false, const AsyncLoading(), ''));

  void getResponseData(String receivedData) {

    state = _dataState(receivedData);
    if (receivedData.isNotEmpty) {

      List<FirstTest>? alltest   = ref.watch(getallestNotifier).value;
      List<int> ind=[];
      List<List<FirstTest>> ind2 =[];
      List<List<FirstTest>> ind3 =[];
      List<FirstTest> ss= <FirstTest>[];
      int j=0;
      int k=0;
      List<FirstTest> testlist = [];



        print(Helper.testType.length);


        for(int i=0; i<alltest!.length;i++) {
          if (Helper.testType[0].length > j) {
            if (alltest[i].testtype != "" && alltest[i].testtype != "Title") {
              ind.add(i);


              if (ss.length != 0) {
                ind2.add(ss);
                ss = <FirstTest>[];
              }
              ss.add(alltest[i]);
            }
            else if(alltest[i].testtype != "Title"){
              ss.add(alltest[i]);
            }
          }
        }

        ind2.add(ss);

        for(int i=0;i<ind2.length;i++)
        {
          List<FirstTest> list1= <FirstTest>[];
          list1=ind2[i].toList();

          if(Helper.testType[0].length>j)
          {
            if(Helper.testType[j].toString() == list1[0].testtype.toString())
            {
              ind3.add(list1);
              j++;
            }
          }
        }


        // if(ind3.length >= k && test.isEmpty){
        //   test.add(ind3[k]);
        // }


      for(int i =0; i<ind3[k].length; i++){
        FirstTest testvalue = FirstTest(
          testnumber: ind3[k][i].testnumber,
          testtype: ind3[k][i].testtype,
          testname: ind3[k][i].testname,
          isonline: ind3[k][i].isonline,
          type: ind3[k][i].type,
          packetid: ind3[k][i].packetid,
          packettype: ind3[k][i].packettype,
          passcrieteria: ind3[k][i].passcrieteria,
          wifiresult: ind3[k][i].wifiresult,
          remarks: ind3[k][i].remarks,
          userentry: ind3[k][i].userentry,
          radiotype: ind3[k][i].radiotype,
          displayResult: ind3[k][i].displayResult,
          result: ind3[k][i].result,
          userAckValue: ind3[k][i].userAckValue,
        );
        testlist.add(testvalue);
      }



      var currentStep = ref.read(currentStepProvider);
      var lastTestSent = ref.read(lastTestSentProvider);
      var lastPacketSent = ref.read(lastPacketSentProvider);

      for (var element in testlist) {
        if (element.testnumber.toString() == lastTestSent) {
          if (receivedData == "TimeOut") {
            element.setResult('TimeOut');
            element.setDisplayResult('FAIL');

          } else {
            if (receivedData.contains('ST*') && receivedData.contains('*ED')) {
              var splitData = receivedData.split('*')[1].split(r'$');
              if (lastPacketSent!.contains('ST*') &&
                  lastPacketSent.contains('*ED')) {
                if (splitData[0].toString() == PacketControl.readPacket) {
                  if (splitData[1].toString() ==
                      lastPacketSent.split('*')[1].split(r'$')[1]) {
                    switch (splitData[2]) {
                      case '0':
                      // NACK PACKET - ACK WITHOUT DATA and APPLICATION ITSELF SHOULD CONFIRM THE FUNCTION FAIL todo - ST*001$0*ED
                        element.setResult('FAIL');
                        element.setDisplayResult('FAIL');
                        break;

                      case '1':
                      // ACK WITHOUT DATA and APPLICATION ITSELF SHOULD CONFIRM THE FUNCTION PASS todo - ST*001$1*ED
                        element.result = "PASS";
                        element.setDisplayResult('PASS');
                        break;

                      case '2':
                      // ACK WITHOUT DATA and TESTER TO CONFIRM the FUNCTION PASS/FAIL todo - ST*001$2*ED
                        element.setResult('USERACK');
                        element.setDisplayResult('UNDEFINED');

                        break;

                      case '3':
                      //  ACK WITH DATA and TESTER TO CONFIRM the FUNCTION PASS/FAIL todo - ST*001$3$1544516*ED

                        var mData = element;
                        var val = splitData[3].toString().trim();
                        if (mData.type!.contains('MAC')) {
                          element.setResult('USERID');
                          if (val.contains("000000000000000000")) {
                            element.setUserAckVal(val);
                            element.setDisplayResult('NO MAC');
                          } else {
                            element.setUserAckVal(val);
                            element.setDisplayResult('PASS');

                            ref.read(macAddressTestProvider.notifier).state = val;
                            /* ref.read(serialNoTCPProvider.notifier).state = val;*/
                          }
                        } else if (mData.type!.contains('SERIALNO')) {
                          if (val == "0000000000") {
                            String pck = "SST*" +
                                PacketControl.writePacket +
                                PacketControl.splitChar +
                                ApplicationClass().formDigits(
                                    3,
                                    lastPacketSent
                                        .split('*')[1]
                                        .split(r'$')[1])! +
                                PacketControl.splitChar +
                                ref.read(serialNoTestProvider.notifier).state +
                                "*ED";
                            ref.read(tcpProvider).sendPackets(pck);

                            element.setResult('PASS');
                            element.setUserAckVal(val);
                            element.setDisplayResult('PASS');
                          } else {
                            element.setResult('USERACK');
                            element.setUserAckVal(val);
                            element.setDisplayResult('UNDEFINED');
                            /* ref.read(serialNoTCPProvider.notifier).state = val;*/
                          }
                        }
                        break;

                      case '4':
                      // ACK WITH DATA AND APPLICATION ITSELF SHOULD CONFIRM THE FUNCTION PASS/FAIL todo - ST*001$4$1544516*ED
                        var mData = element;
                        var val = splitData[3].toString().trim();

                        if (mData.type!.contains('MAC')) {
                          element.setResult('PASS');
                          element.setUserAckVal(val);
                          element.setDisplayResult('PASS');

                          ref.read(macAddressTestProvider.notifier).state = val;
                        } else {
                          List<String> wifiResultSplit =
                          mData.wifiresult!.split(',');
                          List<String> testUserPassCrieteriaSplit =
                          mData.passcrieteria!.split('-');
                          int splitIndex = 3;
                          List<String> responseValueList = [];
                          List<String> givenValueList = [];
                          List<dynamic> mResult = [];
                          for (var mSplit in wifiResultSplit) {
                            responseValueList
                                .add(splitData[splitIndex].toString().trim());
                            splitIndex = 1 + splitIndex;
                          }
                          for (var mSplit in testUserPassCrieteriaSplit) {
                            givenValueList.add(mSplit);
                          }
                          for (int i = 0; i < givenValueList.length; i++) {
                            num given = double.parse(givenValueList[i]);
                            for (int j = 0; j < responseValueList.length; j++) {
                              num wifiValue =
                              double.parse(responseValueList[j]);
                              if (responseValueList.length > 1) {
                                if ((i == 0 && j == 0) &&
                                    (wifiValue >= given)) {
                                  mResult.add('PASS');
                                } else if ((i == 0 && j == 1) ||
                                    (i == 1 && j == 0)) {
                                } else if ((i == 1 && j == 1) &&
                                    (wifiValue <= given)) {
                                  mResult.add('PASS');
                                } else {
                                  mResult.add('FAIL');
                                }
                              } else {
                                if (i == 0 && (wifiValue >= given)) {
                                  mResult.add('PASS');
                                } else if (i == 1 && (wifiValue <= given)) {
                                  mResult.add('PASS');
                                } else {
                                  mResult.add('FAIL');
                                }
                              }
                            }
                          }
                          int passCount = 0, failCount = 0;
                          for (var res in mResult) {
                            if (res == 'PASS') {
                              passCount = passCount + 1;
                            } else if (res == 'FAIL') {
                              failCount = failCount + 1;
                            }
                          }
                          int largest = max(passCount, failCount);
                          if (passCount == failCount) {
                            element.setResult('FAIL');
                            element.setDisplayResult('FAIL');
                          } else if (largest == passCount) {
                            element.setResult('PASS');
                            element.setDisplayResult('PASS');
                          } else if (largest == failCount) {
                            element.setResult('FAIL');
                            element.setDisplayResult('FAIL');
                          }
                        }

                        break;

                      default:
                      // DATA ERROR todo - ST*001$9*ED
                        element.setResult('FAIL');
                        element.setDisplayResult('FAIL');
                        break;
                    }
                  } else {
                    element.setResult('FAIL');
                    element.setDisplayResult('FAIL');
                  }
                }
                else if (splitData[0] == PacketControl.writePacket) {
                  if (splitData[1].toString() ==
                      lastPacketSent.split('*')[1].split(r'$')[1]) {
                    switch (splitData[2]) {
                      case '0':
                      // NACK PACKET - ACK WITHOUT DATA and APPLICATION ITSELF SHOULD CONFIRM THE FUNCTION FAIL todo - ST*001$0*ED
                        element.setResult('FAIL');
                        element.setDisplayResult('FAIL');
                        break;

                      case '1':
                      // ACK WITHOUT DATA and APPLICATION ITSELF SHOULD CONFIRM THE FUNCTION PASS todo - ST*001$1*ED
                        element.setResult('PASS');
                        element.setDisplayResult('PASS');
                        var mData = element;
                        if (mData.type!.contains('FAILACK')) {
                          element.setRemarks("Failed");
                        }
                        break;

                      case '2':
                      // ACK WITHOUT DATA and TESTER TO CONFIRM the FUNCTION PASS/FAIL todo - ST*001$2*ED
                        element.setResult('USERACK');
                        element.setDisplayResult('UNDEFINED');
                        break;

                      case '3':
                      //  ACK WITH DATA and TESTER TO CONFIRM the FUNCTION PASS/FAIL todo - ST*001$3$1544516*ED
                        var mData = element;
                        var val = splitData[3].toString().trim();
                        if(splitData[2]=='003'){
                          element.setResult('3');
                          element.setUserAckVal(splitData[2]);
                          element.setDisplayResult('PASS');
                        }
                        else if (splitData[2]=='004') {
                          element.setResult('PASS');
                          element.setUserAckVal(splitData[2]);
                          element.setDisplayResult('PASS');
                        }
                        break;

                      case '4':
                        print('Mac');
                        // ACK WITH DATA AND APPLICATION ITSELF SHOULD CONFIRM THE FUNCTION PASS/FAIL todo - ST*001$4$1544516*ED
                        var mData = element;
                        var val = splitData[3].toString().trim();

                        if (mData.type!.contains('MAC')) {
                          element.setResult('3');
                          element.setUserAckVal(splitData[2]);
                          element.setDisplayResult('PASS');
                          /* ref.read(serialNoTCPProvider.notifier).state = val;*/

                        } else {
                          List<String> wifiResultSplit =
                          mData.wifiresult!.split(',');
                          List<String> testUserPassCrieteriaSplit =
                          mData.passcrieteria!.split('-');
                          int splitIndex = 3;
                          List<String> responseValueList = [];
                          List<String> givenValueList = [];
                          List<dynamic> mResult = [];
                          for (var mSplit in wifiResultSplit) {
                            responseValueList
                                .add(splitData[splitIndex].toString().trim());
                            splitIndex = 1 + splitIndex;
                          }
                          for (var mSplit in testUserPassCrieteriaSplit) {
                            givenValueList.add(mSplit);
                          }
                          for (int i = 0; i < givenValueList.length; i++) {
                            num given = double.parse(givenValueList[i]);
                            for (int j = 0; j < responseValueList.length; j++) {
                              num wifiValue =
                              double.parse(responseValueList[j]);
                              if (given < wifiValue || given > wifiValue) {
                                mResult.add('PASS');
                              } else {
                                mResult.add('FAIL');
                              }
                            }
                          }
                          int passCount = 0, failCount = 0;
                          for (var res in mResult) {
                            if (res == 'PASS') {
                              passCount = passCount + 1;
                            } else if (res == 'FAIL') {
                              failCount = failCount + 1;
                            }
                          }
                          int largest = max(passCount, failCount);
                          if (largest == passCount) {
                            element.setResult('PASS');
                          } else if (largest == failCount) {
                            element.setDisplayResult('FAIL');
                          }
                        }

                        break;
                      case '5':
                        if(splitData[1]=='005'){
                          element.setResult('PASS');
                          element.setUserAckVal(splitData[2]);
                          element.setDisplayResult('PASS');
                        }

                        break;
                      default:
                      // DATA ERROR todo - ST*001$9*ED
                        element.setResult('FAIL');
                        element.setDisplayResult('FAIL');
                        break;
                    }
                  } else {
                    element.setResult('FAIL');
                    element.setDisplayResult('FAIL');
                  }
                }
              }
              print('');
            }
          }
        }
      }
      testlist.remove(currentStep);


      //res[currentStep] = mList;
     /* map[currentStep] = mList;
      state.excelData = map;
      ref.read(extractExcelNotifierProvider.notifier).state =
          ExtractExcelState(false, AsyncData(state), '');*/
    }
  }

  TcpResponseSate _dataState(String entity) {
    return TcpResponseSate(false, AsyncData(entity), '');
  }

  TcpResponseSate _loading() {
    return TcpResponseSate(true, state.id, '');
  }

  TcpResponseSate _errorState(int statusCode, String errMsg) {
    return TcpResponseSate(
        false, state.id, 'response code $statusCode  msg $errMsg');
  }
}
