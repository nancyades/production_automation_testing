
import 'package:production_automation_testing/Database/Curd_operation/HiveModel/usermanagement.dart';

import 'boxes.dart';




class DataBase {



  Future<dynamic>? addUsers(String emp_id, String name, String password, String email, String phoneno, bool isActive){
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
/*  Future updateUser({required int index,required Usermodel userModel}) async {
    final box = Boxes.getUsers();
    await box.putAt(index,userModel);
  }*/

  void deleteUser(UserManagementmodel usermodel) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    usermodel.delete();

  }

}
