import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String username;
  final String email;
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String token;
  final String refreshToken;

  const LoginEntity({required this.firstName,required this.lastName,required this.gender,required this.image,required this.token,required this.refreshToken, required this.email,required this.id, required this.username, });

  @override
  // TODO: implement props
  List<Object?> get props => [username,email,id,firstName,lastName,gender,image,token,refreshToken];

}