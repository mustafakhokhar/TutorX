import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = "https://backend-seven-hazel.vercel.app";
// const String baseUrl = "http://10.130.9.65:3000";

class BaseClient {
  var client = http.Client();
  /*-----For headers ------*/
  // var _headers = {
  //   'Authorization' : 'xyz',
  //   'api_key': 'xyz'
  // };

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);
    // var response = await client.get(url, headers: _headers)
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, body: _payload, headers: _headers);

    if (response.statusCode == 201) {
      return response.body;
    } else {}
  }

  // pass id
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var response = await client.put(url, body: _payload, headers: _headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.delete(url);
    // var response = await client.get(url, headers: _headers)
    if (response.statusCode == 200) {
      return response.body;
    } else {}
  }
}
