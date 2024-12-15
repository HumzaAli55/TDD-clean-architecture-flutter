abstract class LoginEvents{
 final String userEmail;
 final String password;

  LoginEvents({required this.userEmail, required this.password});

}

class AuthenticateUser extends LoginEvents {
  AuthenticateUser({required String userEmail,required String password}) : super(userEmail: userEmail, password: password);
}