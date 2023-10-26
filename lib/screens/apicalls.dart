import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCall {
  var emp = true;
  Future<List<dynamic>> fetchUsers(context, pageNo) async {
    final Uri url = Uri.parse('https://reqres.in/api/users?page=$pageNo');

    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> res = json.decode(response.body);

      List<dynamic> parsedData = res['data'];
      return parsedData;
    }

    return [];
  }
}
