import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;

// api service implemented with error handing to reduce redundant code.
// allow for more specfic requests to be added in the future without breaking each page.

class ApiService {
  Future defaultGetRequest(baseurl, endpoint) async {
    try {
      var url = Uri.parse(baseurl + endpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future defaultPostRequest(baseurl, endpoint, body) async {
    try {
      var url = Uri.parse(baseurl, endpoint);
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
