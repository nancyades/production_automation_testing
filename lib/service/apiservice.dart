import 'dart:convert';
import 'dart:io';

import 'package:production_automation_testing/Model/APIModel/productcount.dart';
import 'package:production_automation_testing/Model/APIModel/templatemodel.dart';
import 'package:production_automation_testing/Model/readexcel/readecel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import '../Model/APIModel/productmodel.dart';
import '../Model/APIModel/taskcount.dart';
import '../Model/APIModel/taskmodel.dart';
import '../Model/APIModel/usercountmodel.dart';
import '../Model/APIModel/usermodel.dart';
import '../Model/APIModel/workordercount.dart';
import '../Model/APIModel/workordermodel.dart';
import 'package:dio/dio.dart';





Provider<ApiProider> apiProvider = Provider<ApiProider>((ref) => ApiProider(ref));
class ApiProider{

  final Ref ref;
  final client = Dio();

  ApiProider(this.ref)
      : _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.69/PAT_API/api/',
      connectTimeout: 10000,
      receiveTimeout: 20000,
      responseType: ResponseType.json,
    ),
  );
   
  
  late final Dio _dio;


  Future<dynamic> getTestType()async{
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
  }

  Future<dynamic> getFirstTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbw-VCFeS5P_WmvqBsgdWztHLBoZY4n3NknKmT0SoljIwF15o8JVVIgxV07Wv0VCQMH7/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});
    print("firsttest---------------->$response");
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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

  Future<dynamic> getSecondTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbx0wNiDLoWM6mZO-_2_72zryeuQV33lh_9mx3JOMzU4TWo-02zsih182Jpi3O3DmRLY/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});
    print("firsttest---------------->$response");
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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



  Future<dynamic> getThirdTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbw3sJXw-ADcSb9tKPojkQRKlwi89vFCL1oxvNyzFnVjw9Hu6tEVIwxotxTKY8dQnAc/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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



  Future<dynamic> getFourthTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbzhgyKBklzlNgOtWqe0PpHjHCxgylpBh1DUDPX_InScX6odmfPUo8R8XOcNYyvqChLX/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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


  Future<dynamic> getFivthTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbwMvWSi3VHe9PzDYraX9S2_mWa-IWNkIZMY0uk1plxSrybKOfwV20MFYi8foQz0K73m/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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



  Future<dynamic> getSixthTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbw_zo9JZXTtrF2avGi7JVPasFxqr7BOWRN8E0cxQ8We4tHLrxnRBQx9rcDrSysKVQ9x/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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



  Future<dynamic> getSeventhTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbyPc7tGjV4XaZuTXTvndRBxN8piK6VQFuqZYcO-I9O3yG8SrH-5H-9eEaBu3i0zaA2A/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});

    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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





  Future<dynamic> getAllTest()async{
    List<FirstTest> finalData = [];
    final response = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbxHbkHBtCNWLYUlDSKpeWR20lcuNMVgob7Dh2wefzCSHjLF-t72JXLh-i2oKhzZgBxQ/exec"),
        headers: {'Content-Type': 'application/json','Charset': 'utf-8'});
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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


  Future<dynamic> getUsers() async{
    List<Users> finalData = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/User"));
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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
      );
      finalData.add(user);
    }
    return finalData;
  }

  Future<dynamic> getWorkOrders() async{
    List<WorkorderModel> finalData = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/workorder"));
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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
        remarks: result[i]['remarks']
      );
      finalData.add(workOrder);
    }
    return finalData;
  }

  Future<dynamic> getProducts() async{
    List<Productmodel> finalData = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/Product"));
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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
      );
      finalData.add(workOrder);
    }
    return finalData;
  }


  Future<dynamic> getTemplate() async{
    List<Template> finalData = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/Template"));
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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
      );
      finalData.add(template);
    }
    return finalData;
  }


  Future<dynamic> getTask() async{
    List<TaskModel> finalData = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/Task"));
    dynamic result = jsonDecode(response.body);
    for(int i=0;i<result.length;i++){
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
      );
      finalData.add(taskmodel);
    }
    return finalData;
  }

//*************************************************user count************************************************************
  Future<dynamic> getCountUser() async{
    List<UserCountModel> finalData = [];
    List data = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/UserCount"));
    dynamic result = jsonDecode(response.body);
    data.add(result);

    for(int i=0;i<data.length;i++){
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
  Future<dynamic> getWorkorderCount() async{
    List<WorkorderCount> finalData = [];
    List data = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/WOCount"));
    dynamic result = jsonDecode(response.body);
    data.add(result);

    for(int i=0;i<data.length;i++){
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
  Future<dynamic> getProductCount() async{
    List<ProductCount> finalData = [];
    List data = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/ProductCount"));
    dynamic result = jsonDecode(response.body);
    data.add(result);

    for(int i=0;i<data.length;i++){
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
  Future<dynamic> getTaskCount() async{
    List<TaskCount> finalData = [];
    List data = [];
    final response = await http.get(Uri.parse("http://192.168.1.69/PAT_API/api/TaskCount"));
    dynamic result = jsonDecode(response.body);
    data.add(result);

    for(int i=0;i<data.length;i++){
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

Future<dynamic> insertUser(var user) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/User',
        data:  jsonEncode(user),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
}


  Future<dynamic> updatetUser(var user) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/User/Update',
        data: jsonEncode(user),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }


//******************************************************post workorder*****************************************************************

  Future<dynamic> insertWorkorders(var workorder) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/workorder',
        data:  jsonEncode(workorder),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }

  Future<dynamic> UpdateWorkorders(var workorder) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/workorder/Update',
        data:  jsonEncode(workorder),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }


//******************************************************post product*****************************************************************

  Future<dynamic> insertProduct(var product) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/Product',
        data:  jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }

  Future<dynamic> UpdateProduct(var product) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/Product/Update',
        data:  jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }
  //******************************************************post template*****************************************************************

  Future<dynamic> insertTemplate(var product) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/Template',
        data:  jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }

  Future<dynamic> UpdateTemplate(var product) async{
    try{
      final response = await _dio.post('http://192.168.1.69/PAT_API/api/Template/Update',
        data:  jsonEncode(product),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );

      return response.toString();
    }
    catch (e){
      return e.toString();
    }
  }


}