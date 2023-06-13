import 'dart:convert';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:production_automation_testing/Helper/helper.dart';
import 'package:production_automation_testing/Model/APIModel/dashboardscreen/workorder_model.dart';
import 'package:production_automation_testing/Model/APIModel/productcount.dart';
import 'package:production_automation_testing/Model/APIModel/templatemodel.dart';
import 'package:production_automation_testing/Model/APIModel/testerreport.dart';
import 'package:production_automation_testing/Model/APIModel/workorderbasedreport.dart';
import 'package:production_automation_testing/Model/APIModel/workorderprogressreport.dart';
import 'package:production_automation_testing/Model/APIModel/workorderunderproduct.dart';
import 'package:production_automation_testing/Model/readexcel/readecel.dart';
import 'package:production_automation_testing/Model/readexcelmodel.dart';
import 'package:production_automation_testing/Model/resultmodel.dart';
import 'package:production_automation_testing/Model/testlistmodel.dart';

import 'package:production_automation_testing/Provider/post_provider/template_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import '../Model/APIModel/productmodel.dart';
import '../Model/APIModel/productreport.dart';
import '../Model/APIModel/taskcount.dart';
import '../Model/APIModel/taskmodel.dart';
import '../Model/APIModel/usercountmodel.dart';
import '../Model/APIModel/usermodel.dart';
import '../Model/APIModel/workordercount.dart';
import '../Model/APIModel/workordermodel.dart';
import 'package:dio/dio.dart';

import '../Model/taskdetailsmodel.dart';
import '../noofpages/Users/user.dart';

Provider<ApiProider> apiProvider =
    Provider<ApiProider>((ref) => ApiProider(ref));

class ApiProider {
  final Ref ref;
  final client = Dio();

  ApiProider(this.ref)
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'http://192.168.1.10/PAT_API/api/',
            connectTimeout: 10000,
            receiveTimeout: 35000,
            responseType: ResponseType.json,
          ),
        );

  late final Dio _dio;

/*  Future<dynamic> getTestType()async{
    List<Testtype> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbzNncXFIE8wuT8NQdtb1dE8ZYIrLli_PjFI-wYeM2wr2VnH8noBt9adwUZx_b4VrgDz/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});
    print(response);
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
      Testtype sub = Testtype(
          testType: result[i]["Test Type"]
      );
      finalData.add(sub);
    }
    return finalData;
  }*/

  Future<dynamic> getFirstTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbw-VCFeS5P_WmvqBsgdWztHLBoZY4n3NknKmT0SoljIwF15o8JVVIgxV07Wv0VCQMH7/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
    print("firsttest---------------->$response");
    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getSecondTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbx0wNiDLoWM6mZO-_2_72zryeuQV33lh_9mx3JOMzU4TWo-02zsih182Jpi3O3DmRLY/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
    print("firsttest---------------->$response");
    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getThirdTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbw3sJXw-ADcSb9tKPojkQRKlwi89vFCL1oxvNyzFnVjw9Hu6tEVIwxotxTKY8dQnAc/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getFourthTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbzhgyKBklzlNgOtWqe0PpHjHCxgylpBh1DUDPX_InScX6odmfPUo8R8XOcNYyvqChLX/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getFivthTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbwMvWSi3VHe9PzDYraX9S2_mWa-IWNkIZMY0uk1plxSrybKOfwV20MFYi8foQz0K73m/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getSixthTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbw_zo9JZXTtrF2avGi7JVPasFxqr7BOWRN8E0cxQ8We4tHLrxnRBQx9rcDrSysKVQ9x/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getSeventhTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse(
            "https://script.google.com/macros/s/AKfycbyPc7tGjV4XaZuTXTvndRBxN8piK6VQFuqZYcO-I9O3yG8SrH-5H-9eEaBu3i0zaA2A/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
        testnumber: result[i]["Test Number"],
        testtype: result[i]["Test Type"],
        testname: result[i]["Test Name"],
        isonline: result[i]["isOnline"],
        type: result[i]["Type"],
        packetid: result[i]["PacketID"],
        packettype: result[i]["Pkt Type"],
        userentry: result[i]["User Entry"],
        wifiresult: result[i]["Wifi Result"],
        passcrieteria: result[i]["Pass Crieteria"],
        remarks: result[i]["Remarks"],
      );
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getAllTest() async {
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse('http://192.168.1.10/PAT_API/api/ExcelRead'),
        //"https://script.google.com/macros/s/AKfycbxHbkHBtCNWLYUlDSKpeWR20lcuNMVgob7Dh2wefzCSHjLF-t72JXLh-i2oKhzZgBxQ/exec"),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      FirstTest sub = FirstTest(
          testnumber: result[i]["test_Number"],
          testtype: result[i]["test_Type"],
          testname: result[i]["test_Name"],
          isonline: result[i]["isOnline"],
          type: result[i]["type"],
          packetid: result[i]["packetID"],
          packettype: result[i]["pkt_Type"],
          userentry: result[i]["user_Entry"],
          wifiresult: result[i]["wifi_Result"],
          passcrieteria: result[i]["pass_Crieteria"],
          remarks: "",
          isSelected: false);
      finalData.add(sub);
    }
    return finalData;
  }

  Future<dynamic> getUsers() async {
    List<Users> finalData = [];
    final response =
        await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/User"));
    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      Users user = Users(
        userId: result[i]['user_id'],
        empId: result[i]['emp_id'],
        name: result[i]['name'],
        password: result[i]['password'],
        avatarId: result[i]['avatar_id'],
        emailid: result[i]['emailid'],
        phoneno: result[i]['phoneno'],
        role: result[i]['role'],
        createdBy: result[i]['created_by'],
        updatedBy: result[i]['updated_by'],
        createdDate: result[i]['created_date'],
        updatedDate: result[i]['updated_date'],
        flg: result[i]['flg'],
        isSelecteduser: false,
      );
      finalData.add(user);
    }
    return finalData;
  }


  Future<dynamic> getWorkOrders() async {
    List<WorkorderModel> finalData = [];
    final response =
        await http.get(Uri.parse('http://192.168.1.10/PAT_API/api/workorder'));
    dynamic result = jsonDecode(response.body);
    List<WorkorderList> wo_list = [];

    for (int i = 0; i < result.length; i++) {
      WorkorderModel workOrder = WorkorderModel(
          workorderId: result[i]['workorder_id'],
          workorderCode: result[i]['workorder_code'],
          quantity: result[i]['quantity'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          status: result[i]['status'],
          createdBy: result[i]['created_by'],
          updatedBy: result[i]['updated_by'],
          createdDate: result[i]['created_date'],
          updatedDate: result[i]['updated_date'],
          flg: result[i]['flg'],
          remarks: result[i]['remarks'],
          woList: wo_list
          // woList:
          );

      //  if(result[i]['workorder_id'] == result[i]['woList'][0]["workorder_id"]) {
      finalData.add(workOrder);
      //  }

      var datum = result[i]['woList'];

      for (int j = 0; j < datum.length; j++) {
        WorkorderList prolist = WorkorderList(
          id: datum[j]['id'],
          workorder_id: datum[j]['workorder_id'],
          quantity: datum[j]['quantity'],
          product_name: datum[j]['product_name'],
          product_id: datum[j]['product_id'],
          start_serial_no: datum[j]['start_serial_no'],
          end_serial_no: datum[j]['end_serial_no'],
          status: datum[j]['status'],
          testing_status: datum[j]['testing_status'],
          start_date: datum[j]['start_date'],
          end_date: datum[j]['end_date'],
          flg: datum[j]['flg'],
        );
        wo_list.add(prolist);
      }
    }
    return finalData;
  }

  Future<dynamic> getProducts() async {
    List<Productmodel> finalData = [];
    final response =
        await http.get(Uri.parse(HttpServices.baseUrl + HttpServices.Products));
    dynamic result = jsonDecode(response.body);
    List<Template> template = [];
    List<ExcelRead> excel_read = [];
    if (result == "No Reords Found") {
      return finalData = [];
    }
    for (int i = 0; i < result.length; i++) {
      Productmodel workOrder = Productmodel(
          productId: result[i]['product_id'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          description: result[i]['description'],
          templateId: result[i]['template_id'],
          quantity: result[i]['quantity'],
          status: result[i]['status'],
          createdBy: result[i]['created_by'],
          updatedBy: result[i]['updated_by'],
          createdDate: result[i]['created_date'],
          updatedDate: result[i]['updated_date'],
          flg: result[i]['flg'],
          remarks: result[i]['remarks'],
          timeRequired: result[i]['time_required'],
          macAddress: result[i]['mac_address'],
          template: template);
      finalData.add(workOrder);

      var datum = result[i]['template'];

      for (int j = 0; j < datum.length; j++) {
        Template templist = Template(
          templateId: datum[j]['template_id'],
          templateName: datum[j]['template_name'],
          filePath: datum[j]['file_path'],
          createdBy: datum[j]['created_by'],
          updatedBy: datum[j]['updated_by'],
          createdDate: datum[j]['created_date'],
          updatedDate: datum[j]['updated_date'],
          flg: datum[j]['flg'],
          remarks: datum[j]['remarks'],
          productid: datum[j]['product_id'],
          // excelread: excel_read
        );
        template.add(templist);

        /* var read = datum[j]['excelRead'];

        for(int k = 0; k<read.length; k++){
          ExcelRead excelRead = ExcelRead(
            testNumber: read[k]['test_Number'],
            testType: read[k]['test_Type'],
            testName: read[k]['test_Name'],
            isOnline: read[k]['isOnline'],
            type: read[k]['type'],
            packetId: read[k]['packetID'],
            pktType: read[k]['pkt_Type'],
            userEntry: read[k]['user_Entry'],
            wifiResult: read[k]['wifi_Result'],
            passCrieteria: read[k]['pass_Crieteria'],
            remarks: read[k]['remarks'],
          );
          excel_read.add(excelRead);

        }*/

      }
    }
    return finalData;
  }

  Future<dynamic> getTemplate() async {
    List<Template> finalData = [];
    final response =
        await http.get(Uri.parse(HttpServices.baseUrl + HttpServices.Template));
    dynamic result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      Template template = Template(
          templateId: 0,
          templateName: "",
          filePath: "",
          createdBy: 0,
          updatedBy: 0,
          createdDate: "",
          updatedDate: "",
          flg: 1,
          remarks: "",
          // excelread: result[i]["excelRead"],
          productid: "");
      finalData.add(template);
    } else {
      for (int i = 0; i < result.length; i++) {
        Template template = Template(
            templateId: result[i]["template_id"],
            templateName: result[i]["template_name"],
            filePath: result[i]["file_path"],
            createdBy: result[i]["created_by"],
            updatedBy: result[i]["updated_by"],
            createdDate: result[i]["created_date"],
            updatedDate: result[i]["updated_date"],
            flg: result[i]["flg"],
            remarks: result[i]["remarks"],
            // excelread: result[i]["excelRead"],
            productid: result[i]['product_id']);
        finalData.add(template);
      }
    }

    return finalData;
  }

  Future<dynamic> getResult() async {
    List<Results> finalData = [];
    final response =
    await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/Result"));
    dynamic result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        Results template = Results(
            resultId: result[i]["result_id"],
            testId: result[i]["test_id"],
            spendTime: result[i]["spend_time"],
            status: result[i]["status"],
            flg: result[i]["flg"],
            );
        finalData.add(template);
      }

    return finalData;
  }

  Future<dynamic> getTask() async {
    List<TaskModel> finalData = [];
    List<Testing> test = [];
    final response =
        await http.get(Uri.parse(HttpServices.baseUrl + HttpServices.Task));
    dynamic result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }
    for (int i = 0; i < result.length; i++) {
      TaskModel taskmodel = TaskModel(
          taskId: result[i]["task_id"],
          userId: result[i]["user_id"],
          assignId: result[i]["assign_id"],
          wolId: result[i]["wol_id"],
          quantity: result[i]["quantity"],
          startSerialNo: result[i]["start_serial_no"],
          endSerialNo: result[i]["end_serial_no"],
          status: result[i]["status"],
          testingStatus: result[i]["testing_status"],
          startDate: result[i]["start_date"],
          endDate: result[i]["end_date"],
          createdBy: result[i]["created_by"],
          updatedBy: result[i]["updated_by"],
          createdDate: result[i]["created_date"],
          updatedDate: result[i]["updated_date"],
          flg: result[i]["flg"],
          rating: result[i]["rating"],
          workorderid: result[i]["workorder_id"],
          productid: result[i]["product_id"],
          username: result[i]["name"],
          workorderCode: result[i]["workorder_code"],
          product_name: result[i]["product_name"],
          testing: test);
      finalData.add(taskmodel);

      var datum = result[i]['testing'];

      for (int j = 0; j < datum.length; j++) {
        Testing testing = Testing(
          testId: datum[j]['test_id'],
          taskId: datum[j]['task_id'],
          testStage: datum[j]['test_stage'],
          testStatus: datum[j]['test_status'],
          pass: datum[j]['pass'],
          fail: datum[j]['fail'],
          status: datum[j]['status'],
          flg: datum[j]['flg'],
          macAddress: datum[j]['mac_address'],
          testType: datum[j]['test_type'],
          testDate: datum[j]['test_date'],
          hoursTaken: datum[j]['hours_taken'],
          testNumber: datum[j]['test_number'],

          testName: datum[j]['test_Name'],
          isOnline: datum[j]['isOnline'],
          type: datum[j]['type'],
          packetId: datum[j]['packetID'],
          pktType: datum[j]['pkt_Type'],
          userEntry: datum[j]['user_Entry'],
          wifiResult: datum[j]['wifi_Result'],
          passCrieteria: datum[j]['pass_Crieteria'],
          serial_no: datum[j]['serial_no'],
        );
        test.add(testing);
      }
    }
    return finalData;
  }

  Future<dynamic> getNewTask() async {
    List<TaskNewModel> finalData = [];
    final response =
        await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/TaskView"));
    dynamic result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      TaskNewModel template = TaskNewModel(
        taskId: 0,
        userId: 0,
        username: "",
        assignId: 0,
        wolId: 0,
        workOrder: "",
        templateId: 0,
        templateName: "",
        productName: "",
        productCode: "",
        quantity: 0,
        startSerialNo: "",
        endSerialNo: "",
        status: "",
        testingStatus: "",
        startDate: "",
        endDate: "",
        createdBy: "",
        welcomeCreatedBy: 0,
        updatedBy: "",
        welcomeUpdatedBy: 0,
        createdDate: "",
        updatedDate: "",
        flg: 0,
        rating: 0,
      );
      finalData = [];
    } else {
      for (int i = 0; i < result.length; i++) {
        TaskNewModel taskmodel = TaskNewModel(
          taskId: result[i]["task_id"],
          userId: result[i]["user_id"],
          username: result[i]['username'],
          assignId: result[i]["assign_id"],
          wolId: result[i]["wol_id"],
          workOrder: result[i]['workOrder'],
          templateId: result[i]['template_id'],
          templateName: result[i]['template_name'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          quantity: result[i]["quantity"],
          startSerialNo: result[i]["start_serial_no"],
          endSerialNo: result[i]["end_serial_no"],
          status: result[i]["status"],
          testingStatus: result[i]["testing_status"],
          startDate: result[i]["start_date"],
          endDate: result[i]["end_date"],
          createdBy: result[i]["createdBy"],
          welcomeCreatedBy: result[i]["created_by"],
          updatedBy: result[i]["updatedBy"],
          welcomeUpdatedBy: result[i]["updated_by"],
          createdDate: result[i]["created_date"],
          updatedDate: result[i]["updated_date"],
          flg: result[i]["flg"],
          rating: result[i]["rating"],
        );
        finalData.add(taskmodel);
      }
    }

    return finalData;
  }

//*************************************************user count************************************************************
  Future<dynamic> getCountUser() async {
    List<UserCountModel> finalData = [];
    List data = [];
    final response = await http
        .get(Uri.parse(HttpServices.baseUrl + HttpServices.CountUser));
    dynamic result = jsonDecode(response.body);
    data.add(result);

    for (int i = 0; i < data.length; i++) {
      UserCountModel userCountModel = UserCountModel(
        userCount: data[i]['user_Count'],
        superAdmin: data[i]['super_Admin'],
        designUser: data[i]['design_User'],
        designAdmin: data[i]['design_Admin'],
        testAdmin: data[i]['test_Admin'],
        testUser: data[i]['test_User'],
      );
      finalData.add(userCountModel);
    }
    return finalData;
  }

//*************************************************workorder count************************************************************
  Future<dynamic> getWorkorderCount() async {
    List<WorkorderCount> finalData = [];
    List data = [];
    final response = await http
        .get(Uri.parse(HttpServices.baseUrl + HttpServices.WorkorderCount));
    dynamic result = jsonDecode(response.body);
    data.add(result);

    for (int i = 0; i < data.length; i++) {
      WorkorderCount workorderCountModel = WorkorderCount(
        wOCount: data[i]["wO_Count"],
        created: data[i]["created"],
        verified: data[i]["verified"],
        approved: data[i]["approved"],
        rejected: data[i]["rejected"],
      );
      finalData.add(workorderCountModel);
    }
    return finalData;
  }

//*************************************************product count************************************************************
  Future<dynamic> getProductCount() async {
    List<ProductCount> finalData = [];
    List data = [];
    final response = await http
        .get(Uri.parse(HttpServices.baseUrl + HttpServices.ProductCount));
    dynamic result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      ProductCount productCountModel = ProductCount(
        productCount: "0",
        created: "0",
        verified: "0",
        approved: "0",
        rejected: "0",
      );
      finalData.add(productCountModel);
      return finalData;
    }
    data.add(result);

    for (int i = 0; i < data.length; i++) {
      ProductCount productCountModel = ProductCount(
        productCount: data[i]["product_Count"],
        created: data[i]["created"],
        verified: data[i]["verified"],
        approved: data[i]["approved"],
        rejected: data[i]["rejected"],
      );
      finalData.add(productCountModel);
    }
    return finalData;
  }

//*************************************************Task count************************************************************
  Future<dynamic> getTaskCount() async {
    List<TaskCount> finalData = [];
    List data = [];
    final response = await http
        .get(Uri.parse(HttpServices.baseUrl + HttpServices.TaskCount));
    dynamic result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      TaskCount productCountModel = TaskCount(
        taskCount: "0",
        inprogress: "0",
        completed: "0",
      );
      finalData.add(productCountModel);
      return finalData;
    }
    data.add(result);

    for (int i = 0; i < data.length; i++) {
      TaskCount taskCount = TaskCount(
        taskCount: data[i]["task_Count"],
        inprogress: data[i]["inprogress"],
        completed: data[i]["completed"],
      );
      finalData.add(taskCount);
    }
    return finalData;
  }

//**************************************************POST*****************************************************************

  Future<dynamic> insertUser(var user) async {
    try {
      String json = jsonEncode(user);
      final response = await _dio.post(
        "http://192.168.1.10/PAT_API/api/User",
        data: jsonEncode(user),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> updatetUser(var user) async {
    try {
      final response = await _dio.post(
        "http://192.168.1.10/PAT_API/api/User/Update",
        data: jsonEncode(user),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

//******************************************************post workorder*****************************************************************

  Future<dynamic> insertWorkorders(var workorder) async {
    try {
      String json = jsonEncode(workorder);

      final response = await _dio.post(
        HttpServices.baseUrl + HttpServices.insertWorkorders,
        data: jsonEncode(workorder),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> UpdateWorkorders(var workorder) async {
    try {
      String json = jsonEncode(workorder);
      final response = await _dio.post(
        HttpServices.baseUrl +
            HttpServices.WorkOrders +
            ('/') +
            HttpServices.UpdateWorkorders,
        data: jsonEncode(workorder),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

//******************************************************post product*****************************************************************

  Future<dynamic> insertProduct(var product) async {
    print("product runtype----------> ${product.runtimeType}");

    try {
      String json = jsonEncode(product);

      final response = await _dio.post(
        HttpServices.baseUrl + HttpServices.insertProduct,
        data: json,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      Helper.product_id = response.toString();
      return response.toString();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<dynamic> UpdateProduct(var product) async {
    try {
      String json = jsonEncode(product);

      final response = await _dio.post(
        HttpServices.baseUrl +
            HttpServices.Products +
            ('/') +
            HttpServices.UpdateProduct,
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //******************************************************post template*****************************************************************

  Future<dynamic> insertTemplate(var product) async {
    String json = jsonEncode(product);
    try {
      final response = await _dio.post(
        HttpServices.baseUrl + HttpServices.insertTemplate,
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> UpdateTemplate(var product) async {
    String json = jsonEncode(product);
    try {
      final response = await _dio.post(
        HttpServices.baseUrl +
            HttpServices.Template +
            ('/') +
            HttpServices.UpdateTemplate,
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //******************************************************post task*****************************************************************

  Future<dynamic> insertTask(var product) async {
    String json = jsonEncode(product);
    try {
      final response = await _dio.post(
        "http://192.168.1.10/PAT_API/api/Task",
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      Helper.task_id = response;

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> UpdateTask(var product) async {
    String json = jsonEncode(product);
    try {
      final response = await _dio.post(
        'http://192.168.1.10/PAT_API/api/Task/Update',
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //******************************************************post test*****************************************************************

  Future<dynamic> insertTest(var product) async {
    String json = jsonEncode(product);
    try {
      final response = await _dio.post(
        "http://192.168.1.10/PAT_API/api/testing",
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //******************************************************post update test*****************************************************************

  Future<dynamic> UpdateTest(var product) async {
    String json = jsonEncode(product);
    try {
      final response = await _dio.post(
        "http://192.168.1.10/PAT_API/api/testing/Update",
        data: jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //******************************************************post result*****************************************************************

  Future<dynamic> insertResult(var result) async {
    String json = jsonEncode(result);
    try {
      final response = await _dio.post(
        "http://192.168.1.10/PAT_API/api/Result",
        data: jsonEncode(result),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }
  //****************************************product release report ****************************************************

  Future<dynamic> getProductsreport() async {
    List<ProductReportmodel> finalData = [];
    final response = await http
        .get(Uri.parse("http://192.168.1.10/PAT_API/api/ProductReport"));
    dynamic result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }
    for (int i = 0; i < result.length; i++) {
      ProductReportmodel productReportmodel = ProductReportmodel(
        productId: result[i]['product_id'],
        productName: result[i]['productName'],
        productTemplate: result[i]['productTemplate'],
        createdBy: result[i]['createdBy'],
        releasedDate: result[i]['releasedDate'],
        status: result[i]['status'],
      );
      finalData.add(productReportmodel);
    }
    return finalData;
  }

  //****************************************All Workorder release report ****************************************************

  Future<dynamic> getAllWorkordersreport() async {
    List<AllWorkorder> finalData = [];
    final response = await http
        .get(Uri.parse("http://192.168.1.10/PAT_API/api/WOReport/WODashboard"));
    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      AllWorkorder productReportmodel = AllWorkorder(
        workorderId: result[i]['workorder_id'],
        workOrder: result[i]['workOrder'],
        workOrderQty: result[i]['workOrderQty'],
        startingSerialNumber: result[i]['startingSerialNumber'],
        endingSerialNumber: result[i]['endingSerialNumber'],
        totalTestUnit: result[i]['totalTestUnit'],
        testStartDate: result[i]['testStartDate'],
        testEndDate: result[i]['testEndDate'],
        qtyPassed: result[i]['qtyPassed'],
        qtyFailed: result[i]['qtyFailed'],
        testingStatus: result[i]['testingStatus'],
      );
      finalData.add(productReportmodel);
    }
    return finalData;
  }

  //****************************************All Workorder progress report ****************************************************

  Future<dynamic> getWorkordersprogressreport() async {
    List<Work_order_progress_report> finalData = [];
    List<PproductwiseWoReport> pro_list = [];
    final response = await http
        .get(Uri.parse("http://192.168.1.10/PAT_API/api/WOReport/PWODashboard"));
    dynamic result = jsonDecode(response.body);
    for (int i = 0; i < result.length; i++) {
      Work_order_progress_report work_order_progress_report = Work_order_progress_report(
        workorderId: result[i]["workorder_id"],
        workOrder: result[i]["workOrder"],
        workOrderQty: result[i]["workOrderQty"],
        pproductwiseWoReport: pro_list,
      );
      var datum = result[i]['pproductwiseWOReport'];
      for (int j = 0; j < datum.length; j++) {
        if(result[i]["workorder_id"] == datum[j]["workorder_id"]){
          PproductwiseWoReport prolist = PproductwiseWoReport(
            workorderId:  datum[j]["workorder_id"],
            productId: datum[j]["product_id"],
            productCode: datum[j]["product_code"],
            productName: datum[j]["product_name"],
            productQty: datum[j]["productQty"],
            startingSerialNumber: datum[j]["startingSerialNumber"],
            endingSerialNumber: datum[j]["endingSerialNumber"],
            totalTestUnit: datum[j]["totalTestUnit"],
            testStartDate: datum[j]["testStartDate"],
            testEndDate: datum[j]["testEndDate"],
            qtyPassed: datum[j]["qtyPassed"],
            qtyFailed: datum[j]["qtyFailed"],
            testingStatus: datum[j]["testingStatus"],
          );
          pro_list.add(prolist);
        }
      }
      finalData.add(work_order_progress_report);

    }
    return finalData;
  }
  //****************************************Single test report ****************************************************

  getSingleTesterreport(var userid) async {
    List<TesterReportModel> finalData = [];
    final response = await http.get(Uri.parse(
        "http://192.168.1.10/PAT_API/api/TestingReport/Userwisereport?UserId=${userid}"));
    var result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }
    else{
      for (int i = 0; i < result.length; i++) {
        TesterReportModel testerReportModel = TesterReportModel(
          workorderId: result[i]['workorder_id'],
          workOrder: result[i]['workOrder'],
          productId: result[i]['product_id'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          spendTime: result[i]['spend_time'],
          hoursTaken: result[i]['hours_taken'],
          macAddress: result[i]['mac_address'],
          testType: result[i]['test_type'],
          testedBy: result[i]['testedBy'],
          testedDate: result[i]['testedDate'],
          testname: result[i]['testName'],
          testResult: result[i]['testResult'],
          testStage: result[i]['testStage'],
          serial_no: result[i]['serial_no'],
        );
        finalData.add(testerReportModel);
      }
    }


    return finalData;
  }
//****************************************workorder progress report ****************************************************

  getworkorderprogressreport(var userid, var startdate, var enddate) async {
    List<WorkorderProgressReportModel> finalData = [];
    final response = await http.get(Uri.parse(
        "http://192.168.1.10/PAT_API/api/WOReport?UserId=${userid}&startdate=${startdate}&enddate=${enddate}"));
    var result = jsonDecode(response.body);

    if (result == "No Reords Found") {
      return finalData = [];
    }else{
      for (int i = 0; i < result.length; i++) {
        WorkorderProgressReportModel workorderReportmodel =
        WorkorderProgressReportModel(
          workorderId: result[i]['workorder_id'],
          workOrder: result[i]['workOrder'],
          workOrderQty: result[i]['workOrderQty'],
          startingSerialNumber: result[i]['startingSerialNumber'],
          endingSerialNumber: result[i]['endingSerialNumber'],
          totalTestUnit: result[i]['totalTestUnit'],
          testStartDate: result[i]['testStartDate'],
          testEndDate: result[i]['testEndDate'],
          qtyPassed: result[i]['qtyPassed'],
          qtyFailed: result[i]['qtyFailed'],
          testingStatus: result[i]['testingStatus'],
        );
        finalData.add(workorderReportmodel);
      }
    }


    return  finalData;
  }

  //****************************************Tester report *****************************************************************

  getTesterreport(var userid, var startdate, var enddate) async {
    List<TesterReportModel> finalData = [];
    final response = await http.get(Uri.parse(
      "http://192.168.1.10/PAT_API/api/TestingReport/Taskwisereport?UserId=${userid}&startdate=${startdate}&enddate=${enddate}"));
    var result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }
  else{
      for (int i = 0; i < result.length; i++) {
        TesterReportModel testerReportModel = TesterReportModel(
          workorderId: result[i]['workorder_id'],
          workOrder: result[i]['workOrder'],
          productId: result[i]['product_id'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          spendTime: result[i]['spend_time'],
          hoursTaken: result[i]['hours_taken'],
          macAddress: result[i]['mac_address'],
          testType: result[i]['test_type'],
          testedBy: result[i]['testedBy'],
          testedDate: result[i]['testedDate'],
          testname: result[i]['testName'],
          testResult: result[i]['testResult'],
            testStage: result[i]['testStage'],
          serial_no: result[i]['serial_no'],
        );
        finalData.add(testerReportModel);
      }
    }


    return finalData;
  }



  //****************************************workorderbased report *****************************************************************

  getWorkorderbasedreport(var userid) async {
    List<WorkorderbasedReport> finalData = [];
    final response = await http.get(Uri.parse(
        "http://192.168.1.10/PAT_API/api/WOBReport?Workorderid=${userid}"));
    var result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }else{
      for (int i = 0; i < result.length; i++) {
        WorkorderbasedReport testerReportModel = WorkorderbasedReport(
          workorderId: result[i]['workorder_id'],
          workOrder: result[i]['workOrder'],
          productId: result[i]['product_id'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          spendTime: result[i]['spend_time'],
          hoursTaken: result[i]['hours_taken'],
          macAddress: result[i]['mac_address'],
          testType: result[i]['test_type'],
          testedBy: result[i]['testedBy'],
          testedDate: result[i]['testedDate'],
          testResult: result[i]['testResult'],
          testName: result[i]['testName'],
        );
        finalData.add(testerReportModel);
      }
    }

    return finalData;
  }

  //****************************************workorderbased report *****************************************************************

  getNewWorkorderbasedreport(var workorderid) async {
    List<NewWorkorderbasedReport> finalData = [];
    final response = await http.get(Uri.parse(
      "http://192.168.1.10/PAT_API/api/WOBReport?Workorderid=${workorderid}"));
    var result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }else{
      for (int i = 0; i < result.length; i++) {
        NewWorkorderbasedReport testerReportModel = NewWorkorderbasedReport(
          workorderId: result[i]['workorder_id'],
          workOrder: result[i]['workOrder'],
          productId: result[i]['product_id'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          spendTime: result[i]['spend_time'],
          hoursTaken: result[i]['hours_taken'],
          macAddress: result[i]['mac_address'],
          testType: result[i]['test_type'],
          assignedBy: result[i]['assignedBy'],
          testedBy: result[i]['testedBy'],
          testedDate: result[i]['testedDate'],
          testName: result[i]['testName'],
          testResult: result[i]['testResult'],
          testStage: result[i]['testStage'],
          serialNo: result[i]['serial_no'],

        );
        finalData.add(testerReportModel);
      }
    }

    return finalData;
  }


  //****************************************workorderbased report *****************************************************************

  getproductunderWorkorderreport(var workorderid) async {
    List<workorderunderproduct> finalData = [];
    final response = await http.get(Uri.parse(
        "http://192.168.1.10/PAT_API/api/WOReport/WO_ProductReport?WorkOrderID=${workorderid}"));
    var result = jsonDecode(response.body);
    if (result == "No Reords Found") {
      return finalData = [];
    }else{
      for (int i = 0; i < result.length; i++) {
        workorderunderproduct testerReportModel = workorderunderproduct(
          productId: result[i]['product_id'],
          productCode: result[i]['product_code'],
          productName: result[i]['product_name'],
          workorderId: result[i]['workorder_id'],
          workOrder: result[i]['workOrder'],
          workOrderQty: result[i]['workOrderQty'],
          startingSerialNumber: result[i]['startingSerialNumber'],
          endingSerialNumber: result[i]['endingSerialNumber'],
          totalTestUnit: result[i]['totalTestUnit'],
          testStartDate: result[i]['testStartDate'],
          testEndDate: result[i]['testEndDate'],
          qtyPassed: result[i]['qtyPassed'],
          qtyFailed: result[i]['qtyFailed'],
          testingStatus: result[i]['testingStatus'],
        );
        finalData.add(testerReportModel);
      }
    }

    return finalData;
  }




  //****************************************workorderbased report *****************************************************************
  var gg;


  Future<void> downloadExcelFile(String url, String savePath) async {
    final response = await http.get(Uri.parse(url));
    final file = File(savePath);



    await file.writeAsBytes(response.bodyBytes);

  }

  void openExcelFile(String filePath) {

    OpenFile.open(filePath);

  }



  Future<void> _prepareSaveDir() async {

    var _localPath = (await _findLocalPath())!;



    print("_localPath------------------> ${_localPath}");
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var directory = await getApplicationDocumentsDirectory();
    gg = directory.path + Platform.pathSeparator + 'Download';
    print("ggg-----> ${gg}");
    return directory.path + Platform.pathSeparator + 'Download';

  }

  getWorkorderbasedexcelreport(var workorderid, var productid, var serial_no) async {
    final response = await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/WOReport/WOReportExcelExport?Workorderid=$workorderid&&Productid=$productid&&serialno=$serial_no"));
    var result = jsonDecode(response.body);

    _prepareSaveDir();
    print("ggg111111111-----> ${gg}");

    Future.delayed(const Duration(milliseconds: 700), () {
      var apiLink = result;
      var savePath = gg  + "\\"  "WOReportExcelExport_100_17-05-2023.xls" ;
      downloadExcelFile(apiLink!, savePath!);

      final downloadedFilePath = savePath;

      return openExcelFile(downloadedFilePath!);
    });



  }


  getTesterexcelreport(var productid, var serial_no) async {
    final response = await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/TestingReport/TestingReportExcelExport?Productid=$productid&serialno=$serial_no"));
    var result = jsonDecode(response.body);

    _prepareSaveDir();

    var apiLink = result;
    var savePath = gg  + "\\"  "TestingReportExcelExport_252_18-05-2023.xls" ;
    downloadExcelFile(apiLink!, savePath!);

    final downloadedFilePath = savePath;

    return openExcelFile(downloadedFilePath!);

  }

  getProductReleseexportreport() async {
    final response = await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/ProductReport/Productreportexcel"));
    var result = jsonDecode(response.body);

    _prepareSaveDir();

    var apiLink = result;
    var savePath = gg  + "\\"  "Productreportexcel_24-05-2023.xls" ;
    downloadExcelFile(apiLink!, savePath!);

    final downloadedFilePath = savePath;

    return openExcelFile(downloadedFilePath!);

  }


  getworkorderprogressexportexcelreport(var userid, var startdate, var enddate) async {
    final response = await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/WOReport/WOReportExcel?UserId=$userid&startdate=$startdate&enddate=$enddate"));
    var result = jsonDecode(response.body);

    _prepareSaveDir();

    var apiLink = result;
    var savePath = gg  + "\\"  "WOReportExcel_160_24-05-2023.xls" ;
    downloadExcelFile(apiLink!, savePath!);

    final downloadedFilePath = savePath;

    return openExcelFile(downloadedFilePath!);

  }

  getTesterexportexcelreport(var userid, var startdate, var enddate) async {
    final response = await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/TestingReport/Taskwisereportexcel?UserId=${userid}&startdate=${startdate}&enddate=${enddate}"));
    var result = jsonDecode(response.body);

    _prepareSaveDir();

    var apiLink = result;
    var savePath = gg  + "\\"  "Taskwisereportexcel_162_03-06-2023.xls" ;
    downloadExcelFile(apiLink!, savePath!);

    final downloadedFilePath = savePath;

    return openExcelFile(downloadedFilePath!);

  }

  getworkorderbasedtestexportexcelreport(var workorderid) async {
    final response = await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/WOReport/WOReportExcelWID?Workorderid=${workorderid}"));
    var result = jsonDecode(response.body);

    _prepareSaveDir();

    var apiLink = result;
    var savePath = gg  + "\\"  "WOReportExcelWID_107_24-05-2023.xls" ;
    downloadExcelFile(apiLink!, savePath!);

    final downloadedFilePath = savePath;

    return openExcelFile(downloadedFilePath!);

  }

//******************************************Read excel by passing productid*********************************************
  getTemplateexcel(var product_id) async {
    List<Productmodel> finalData = [];
    final response = await http.get(Uri.parse(
        'http://192.168.1.10/PAT_API/api/Product/ByID?id=${product_id}'));
    dynamic result = jsonDecode(response.body);
    List<ExcelRead> excel_read = [];
    List<Template> template = [];
    if (result == "No Reords Found") {
      return finalData = [];
    }
    for (int i = 0; i < result.length; i++) {
      Productmodel workOrder = Productmodel(
          productId: result[i]['product_id'],
          productName: result[i]['product_name'],
          productCode: result[i]['product_code'],
          description: result[i]['description'],
          templateId: result[i]['template_id'],
          quantity: result[i]['quantity'],
          status: result[i]['status'],
          createdBy: result[i]['created_by'],
          updatedBy: result[i]['updated_by'],
          createdDate: result[i]['created_date'],
          updatedDate: result[i]['updated_date'],
          flg: result[i]['flg'],
          remarks: result[i]['remarks'],
          timeRequired: result[i]['time_required'],
          macAddress: result[i]['mac_address'],
          template: template);
      finalData.add(workOrder);

      var datum = result[i]['template'];

      for (int j = 0; j < datum.length; j++) {
        Template templist = Template(
            templateId: datum[j]['template_id'],
            templateName: datum[j]['template_name'],
            filePath: datum[j]['file_path'],
            createdBy: datum[j]['created_by'],
            updatedBy: datum[j]['updated_by'],
            createdDate: datum[j]['created_date'],
            updatedDate: datum[j]['updated_date'],
            flg: datum[j]['flg'],
            remarks: datum[j]['remarks'],
            productid: datum[j]['product_id'],
            excelread: excel_read);
        template.add(templist);

        var read = datum[j]['excelRead'];

        for (int k = 0; k < read.length; k++) {
          ExcelRead excelRead = ExcelRead(
            testNumber: read[k]['test_Number'],
            testType: read[k]['test_Type'],
            testName: read[k]['test_Name'],
            isOnline: read[k]['isOnline'],
            type: read[k]['type'],
            packetId: read[k]['packetID'],
            pktType: read[k]['pkt_Type'],
            userEntry: read[k]['user_Entry'],
            wifiResult: read[k]['wifi_Result'],
            passCrieteria: read[k]['pass_Crieteria'],
            remarks: read[k]['remarks'],
            isSelected: false,
          );
          excel_read.add(excelRead);
        }
      }
    }

    return finalData;
  }

  //****************************************get task details *****************************************************************

  gettaskdetails(var workid, var productid) async {
    List<TaskDetails> finalData = [];
    final response = await http.get(Uri.parse(
        "http://192.168.1.10/PAT_API/api/WO_List/GetWolistbywoid?workorderid=${workid}&productid=${productid}"));
    var result = jsonDecode(response.body);
    if (result != "No Reords Found") {
      for (int i = 0; i < result.length; i++) {
        TaskDetails testerReportModel = TaskDetails(
          id: result[i]['id'],
          workorderId: result[i]['workorder_id'],
          productId: result[i]['product_id'],
          quantity: result[i]['quantity'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          status: result[i]['status'],
          testingStatus: result[i]['testing_status'],
          startDate: result[i]['start_date'],
          endDate: result[i]['end_date'],
          flg: result[i]['flg'],
        );
        finalData.add(testerReportModel);
      }
    }
    return result != "No Reords Found" ? finalData : result;
  }


  //****************************************get single user task list *****************************************************************

  getsingleusertasklist(var user_id) async {
    List<TaskModel> finalData = [];
    List<Testing> test = [];
    List<TemplateValue> temp = [];
    final response =
    await http.get(Uri.parse("http://192.168.1.10/PAT_API/api/Task/TaskByUser?Userid=${user_id}"));
    dynamic result = jsonDecode(response.body);

    for (int i = 0; i < result.length; i++) {
      TemplateValue templist = TemplateValue(
        templateId: result[i]['product']['template'][0]['template_id'],
        templateName: result[i]['product']['template'][0]['template_name'],
        filePath: result[i]['product']['template'][0]['file_path'],
        createdBy: result[i]['product']['template'][0]['created_by'],
        updatedBy: result[i]['product']['template'][0]['updated_by'],
        createdDate: result[i]['product']['template'][0]['created_date'],
        updatedDate: result[i]['product']['template'][0]['updated_date'],
        flg: result[i]['product']['template'][0]['flg'],
        remarks: result[i]['product']['template'][0]['remarks'],
        productId: result[i]['product']['template'][0]['product_id'],
        excelRead:  result[i]['product']['template'][0]['excelRead'],
      );
      temp.add(templist);

      Productvalue pro = Productvalue(
        productId:result[i]['product']['product_id'],
        productName: result[i]['product']['product_name'],
        productCode:result[i]['product']['product_code'],
        description:result[i]['product']['description'],
        templateId:result[i]['product']['template_id'],
        quantity:result[i]['product']['quantity'],
        status:result[i]['product']['status'],
        createdBy:result[i]['product']['created_by'],
        updatedBy:result[i]['product']['updated_by'],
        createdDate:result[i]['product']['created_date'],
        updatedDate:result[i]['product']['updated_date'],
        flg:result[i]['product']['flg'],
        remarks:result[i]['product']['remarks'],
        timeRequired:result[i]['product']['time_required'],
        macAddress:result[i]['product']['mac_address'],
        template:temp,
      );
      TaskModel taskmodel = TaskModel(
          taskId: result[i]["task_id"],
          userId: result[i]["user_id"],
          assignId: result[i]["assign_id"],
          wolId: result[i]["wol_id"],
          quantity: result[i]["quantity"],
          startSerialNo: result[i]["start_serial_no"],
          endSerialNo: result[i]["end_serial_no"],
          status: result[i]["status"],
          testingStatus: result[i]["testing_status"],
          startDate: result[i]["start_date"],
          endDate: result[i]["end_date"],
          createdBy: result[i]["created_by"],
          updatedBy: result[i]["updated_by"],
          createdDate: result[i]["created_date"],
          updatedDate: result[i]["updated_date"],
          flg: result[i]["flg"],
          rating: result[i]["rating"],
          workorderid: result[i]["workorder_id"],
          workorderCode: result[i]["workorder_code"],
          productid: result[i]["product_id"],
          username: result[i]["name"],
          testedunit: result[i]["totalTestedUnit"],
          product: pro,

          testing: test);


      finalData.add(taskmodel);

      var datum = result[i]['testing'];

      for (int j = 0; j < datum.length; j++) {
        Testing testing = Testing(
          testId: datum[j]['test_id'],
          taskId: datum[j]['task_id'],
          testStage: datum[j]['test_stage'],
          testStatus: datum[j]['test_status'],
          pass: datum[j]['pass'],
          fail: datum[j]['fail'],
          status: datum[j]['status'],
          flg: datum[j]['flg'],
          macAddress: datum[j]['mac_address'],
          testType: datum[j]['test_type'],
          testDate: datum[j]['test_date'],
          hoursTaken: datum[j]['hours_taken'],
          testNumber: datum[j]['test_number'],
            testName: datum[j]['test_Name'],
            isOnline: datum[j]['isOnline'],
            type: datum[j]['type'],
            packetId: datum[j]['packetID'],
            pktType: datum[j]['pkt_Type'],
            userEntry: datum[j]['user_Entry'],
            wifiResult: datum[j]['wifi_Result'],
            passCrieteria: datum[j]['pass_Crieteria'],

          isSelected: false
        );
        test.add(testing);
      }
    }
    return finalData;
  }



/*  gettestlist(var workid, var productid) async {
    List<TestList> finalData = [];
    final response = await http.get(Uri.parse(
        "http://192.168.1.10/PAT_API/api/WO_List/GetWolistbywoid?workorderid=${workid}&productid=${productid}"));
    var result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        TestList testerReportModel = TestList(
          id: result[i]['id'],
          workorderId: result[i]['workorder_id'],
          productId: result[i]['product_id'],
          quantity: result[i]['quantity'],
          startSerialNo: result[i]['start_serial_no'],
          endSerialNo: result[i]['end_serial_no'],
          status: result[i]['status'],
          testingStatus: result[i]['testing_status'],
          startDate: result[i]['start_date'],
          endDate: result[i]['end_date'],
          flg: result[i]['flg'],
          task:
        );
        finalData.add(testerReportModel);
      }

    return result != "No Reords Found" ? finalData : result;
  }*/


}

class HttpServices {
  static String baseUrl = 'http://192.168.1.10/PAT_API/api/';
  static String user = 'User';
  static String WorkOrders = 'workorder';
  static String Products = 'Product';
  static String Template = 'Template';
  static String Task = 'Task';
  static String CountUser = 'UserCount';
  static String WorkorderCount = 'WOCount';
  static String ProductCount = 'ProductCount';
  static String TaskCount = 'TaskCount';
  static String insertUser = 'User';
  static String updatetUser = 'Update';
  static String insertWorkorders = 'workorder';
  static String UpdateWorkorders = 'Update';
  static String insertProduct = 'Product';
  static String UpdateProduct = 'Update';
  static String insertTemplate = 'Template';
  static String UpdateTemplate = 'Update';
}
