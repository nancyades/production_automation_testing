import 'package:shared_preferences/shared_preferences.dart';

class ApplicationClass{

  String? formDigits(int digits, String value) {
    String? finalDigits;
    switch (digits) {
      case 0:
        finalDigits = value;
        break;
      case 1:
        finalDigits = ("0" + value).substring(value.length);
        break;
      case 2:
        finalDigits = ("00" + value).substring(value.length);
        break;

      case 3:
        finalDigits = ("000" + value).substring(value.length);
        break;

      case 4:
        finalDigits = ("0000" + value).substring(value.length);
        break;

      case 5:
        finalDigits = ("00000" + value).substring(value.length);
        break;

      case 6:
        finalDigits = ("000000" + value).substring(value.length);
        break;

      case 7:
        finalDigits = ("0000000" + value).substring(value.length);
        break;

      case 8:
        finalDigits = ("00000000" + value).substring(value.length);
        break;

      case 9:
        finalDigits = ("000000000" + value).substring(value.length);
        break;
      case 10:
        finalDigits = ("0000000000" + value).substring(value.length);
        break;
      case 11:
        finalDigits = ("00000000000" + value).substring(value.length);
        break;
      case 12:
        finalDigits = ("000000000000" + value).substring(value.length);
        break;
      case 13:
        finalDigits = ("0000000000000" + value).substring(value.length);
        break;
    }
    return finalDigits;
  }


  getStringFormSharePreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  getStringForm1SharePreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  removeStringFormSharePreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}