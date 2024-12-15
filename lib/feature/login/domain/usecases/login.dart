import 'package:equatable/equatable.dart';
import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/core/usecase/usecase.dart';
import 'package:mock_api_practice/feature/login/domain/entities/login.dart';
import 'package:mock_api_practice/feature/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<DataState<LoginEntity>,Params>{
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<DataState<LoginEntity>> call({required params}) {
   return repository.loginUser(userEmail: params.userEmail, password: params.password);
  }
}

class Params extends Equatable {
  final String userEmail;
  final String password;

  Params({required this.userEmail, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [userEmail,password];


}