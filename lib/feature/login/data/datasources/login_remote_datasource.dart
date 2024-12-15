import 'dart:convert';

import 'package:http/http.dart';
import 'package:mock_api_practice/core/constants/api_constant.dart';
import 'package:mock_api_practice/core/http_client/http_client_imp.dart';
import 'package:mock_api_practice/core/http_client/http_interface/i_http_client.dart';
import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/login/data/models/login_model.dart';

abstract class LoginRemoteDataSource{
  Future<DataState<LoginModel>> loginUser(String userEmail, String password);
}

class LoginRemoteDataSourceImp implements LoginRemoteDataSource {

  final IHttpClient<Response> httpClient;

  LoginRemoteDataSourceImp(this.httpClient);

  @override
  Future<DataState<LoginModel>> loginUser(String userEmail, String password) async {
    final response = await httpClient.postRequest(endPoint: ApiConstant.loginApi, data: {
      "username":userEmail,
      "password":password
    });

    final json = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      // Successful response case
        final model = LoginModel.fromJson(json);
        return DataSuccess(model);

      case _:
      // Error handling cases
        if (json case {'message': String message}) {
          // If the JSON contains a 'message' key with a String value
          return DataError(message);
        } else {
          // Fallback if 'message' key is not found
          final errorReason = response.reasonPhrase ?? "Api Failed to load with Unknown Reason";
          print("Data Source Error: ${response.statusCode} $errorReason");
          return DataError(errorReason);
        }
    }

    // else{
    //
    //   print("Data Source Error: ${response.statusCode} ${response.reasonPhrase ?? "Api Failed to load with Unknown Reason"}");
    //
    //   return DataError(response.reasonPhrase ?? "Api Failed to load with Unknown Reason");
    // }

  }

}