import 'package:production_automation_testing/Database/Curd_operation/HiveModel/templatemodel.dart';
import '../../Model/APIModel/workordermodel.dart';
import 'HiveModel/productmodel.dart';
import 'HiveModel/usermanagement.dart';
import 'HiveModel/workordermodel.dart';
import 'boxes.dart';

/*class DataBase {
  Future<dynamic>? addUsers(String emp_id, String name, String password,
      String email, String phoneno, bool isActive) {
    final usermodel = UserManagementmodel()
      ..emp_id = emp_id
      ..name = name
      ..password = password
      ..email = email
      ..phoneno = phoneno
      ..isActive = isActive;

    final box = Boxes.getUsers();
    box.add(usermodel);
  }

  */

/*void editUser(
      Usermodel _usermodel,
      String emp_id,
      String name,
      String email,
      String phoneno,
      bool isActive,
      ){
    _usermodel.emp_id = emp_id;
    _usermodel.name = name;
    _usermodel.email = email;
    _usermodel.phoneno = phoneno;
    _usermodel.isActive = isActive;


    _usermodel.save();
    final box = Boxes.getUsers();
    box.values.first.save();
  }
*/
/*
*/
/*  Future updateUser({required int index,required Usermodel userModel}) async {
    final box = Boxes.getUsers();
    await box.putAt(index,userModel);
  }*/
/*

  void deleteUser(UserManagementmodel usermodel) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    usermodel.delete();
  }

}*/




class Template {
  Future<dynamic>? addTemplate(String template_name, String file_path,
      String remarks) {
    final templatemodel = TemplateModel()
      ..Template_Name = template_name
      ..File_Path = file_path
      ..Remarks = remarks;
    final box = Templates.getTemplate();
    box.add(templatemodel);
  }

  void deleteUser(TemplateModel templateModel) {
    templateModel.delete();
  }
}

//*****************************************************USERS********************************************************

class User {
  Future<dynamic>? addUsers(String User_id, String emp_id, String name,
      String password, String avatar_id, String emailid,
      String phoneno, String role, String created_by,
      String updated_by, String created_date, String updated_date, bool flg
      ) {
    final usermodel = UserManagementmodel()
      ..user_id = User_id
      ..emp_id = emp_id
      ..name = name
      ..password = password
      ..avatar_id = avatar_id
      ..emailid = emailid
      ..phoneno = phoneno
      ..role = role
      ..created_by = created_by
      ..updated_by = updated_by
      ..created_date = created_date
      ..updated_date = updated_date
    ..flg = flg;


    final box = Usersvalue.getUsers();
    box.add(usermodel);
  }


  void deleteUser(UserManagementmodel usermodel) {
    usermodel.delete();
  }
}


//*****************************************************WORKORDERS********************************************************

class WorkOrder {
  Future<dynamic>? addWorkorder(String Workorder_id, String Workorder_code, String Quantity,
      String Start_serialno, String End_serialno, String Status,
      String Created_by, String updated_by, String created_date,
      String updated_date, bool flg, String Remarks) {
    final workordermodel = WorkOrderModel()
      ..workorder_id = Workorder_id
      ..workorder_code = Workorder_code
      ..quantity = Quantity
      ..start_serial_no = Start_serialno
      ..end_serial_no = End_serialno
      ..status = Status
      ..created_by = Created_by
      ..updated_by = updated_by
      ..created_date = created_date
      ..updated_date = updated_date
      ..flg = flg
      ..remarks = Remarks;


    final box = WorkOrders.getWorkorders();
    box.add(workordermodel);
  }

  void deleteworkorder(WorkOrderModel workorderModel) {
    workorderModel.delete();
  }

}


class Product {
  Future<dynamic>? addProduct(String Product_Id, String Product_Name,
      String Product_Code, String description, String Template_Id, String quantity,
      String status, String Created_By,String Updated_By, String Created_Date,
      String Updated_Date, bool flg,String remarks,
      String Time_Required,String MAC_address, ) {
    final productmodel = ProductModel()
    ..product_id = Product_Id
      ..product_name = Product_Name
      ..product_code = Product_Code
      ..description = description
      ..template_id = Template_Id
      ..quantity = quantity
      ..status = status
      ..created_by = Created_By
      ..updated_by = Updated_By
      ..created_date = Created_Date
      ..updated_date = Updated_Date
      ..flg = flg
      ..remarks = remarks
      ..time_required = Time_Required
      ..mac_address = MAC_address;


    final box = Products.getProducts();
    box.add(productmodel);
  }

  void deleteProduct(ProductModel productModel) {
    productModel.delete();
  }

}
