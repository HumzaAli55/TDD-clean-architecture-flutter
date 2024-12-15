import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/login/data/datasources/login_remote_datasource.dart';
import 'package:mock_api_practice/feature/login/data/models/login_model.dart';
import 'package:mock_api_practice/feature/login/domain/entities/login.dart';
import 'package:mock_api_practice/feature/login/domain/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepositoryImpl implements LoginRepository{

  final LoginRemoteDataSource _loginRemoteDataSource;
  final SharedPreferences prefs;

  LoginRepositoryImpl({required this.prefs, required LoginRemoteDataSource loginRemoteDataSource}) : _loginRemoteDataSource = loginRemoteDataSource;

  @override
  Future<DataState<LoginEntity>> loginUser({required String userEmail, required String password}) async {
    try{
    // Fetch the result from the remote data source
     DataState<LoginModel> dataState = await _loginRemoteDataSource.loginUser(userEmail, password);

    // If login is successful, save the token and return the result
     if(dataState is DataSuccess) await prefs.setString("token", dataState.data?.token ?? "");
     return dataState;

    }catch (e){
      // if(e is ServerException) {
      //   return DataError(e.message ?? "");
      // }
      return const DataError("Something Went Wrong");
    }
  }

}