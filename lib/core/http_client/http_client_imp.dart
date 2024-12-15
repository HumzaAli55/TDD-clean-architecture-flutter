import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'http_interface/i_http_client.dart';

class HttpClient extends http.BaseClient implements IHttpClient<http.Response> {

  @override
  Future<http.Response> postRequest(
      {required String endPoint,
        required Map<String, dynamic> data
      }) {
    String url = endPoint;
    return http.post(Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.contentTypeHeader : 'application/json',
          HttpHeaders.acceptHeader : 'application/json',
        },
        encoding: Encoding.getByName("utf-8")
    );
  }

  // Future<http.Response> postRequestWithoutBody(
  //     {required String endPoint,
  //       required Map<String, String> header,
  //     }) {
  //   String url = endPoint;
  //   return post(Uri.parse(url),
  //       headers: header,
  //       encoding: Encoding.getByName("utf-8"));
  // }

  @override
  Future<http.Response> getRequest(
      {required String endPoint}) {
    String url = endPoint;
    return http.get(Uri.parse(url));
  }



////Headers////

  //  Map<String, String> getRequestHeaders() {
  //   return {
  //     HttpHeaders.contentTypeHeader : 'application/json',
  //     HttpHeaders.acceptHeader : 'application/json',
  //   };
  // }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

   if (prefs.containsKey("token")){
     request.headers["Authorization"] = "Bearer ${prefs.getString('token') ?? ""}";

   }

  return await request.send();
  }

}