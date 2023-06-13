

import 'package:http/http.dart' as http;



class HttpService {

  multipart(var file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://192.168.1.10/PAT_API/api/Upload/SaveFile"));


    request.files.add(await http.MultipartFile.fromPath("fileurl", file));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    try {
      if (response.statusCode == 200) {
        return responsed;
      }
    } catch (e) {
      return e;
    }
  }


}
