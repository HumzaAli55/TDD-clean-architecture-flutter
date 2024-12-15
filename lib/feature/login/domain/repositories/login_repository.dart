import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/login/domain/entities/login.dart';

abstract class LoginRepository{
 Future<DataState<LoginEntity>> loginUser({required String userEmail,required String password});
}