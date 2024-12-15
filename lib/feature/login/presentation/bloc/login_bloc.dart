import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/login/domain/usecases/login.dart';
import 'package:mock_api_practice/feature/login/presentation/bloc/login_events.dart';
import 'package:mock_api_practice/feature/login/presentation/bloc/login_states.dart';

class LoginBloc extends Bloc<LoginEvents,LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(EmptyState()){
    on<AuthenticateUser>(onUserLogin);
  }

 Future<void> onUserLogin(LoginEvents events,Emitter<LoginStates> emit) async {
    emit(Authenticating());
    final dataState = await _loginUseCase(params:Params(userEmail: events.userEmail, password:events.password));
    if(dataState is DataSuccess){
      emit(LoginSuccess());
    }
    
    if(dataState is DataError){
      emit(LoginFailed(error: dataState.error.toString()));
    }
  }

}