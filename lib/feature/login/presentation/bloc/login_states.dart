import 'package:equatable/equatable.dart';

abstract class LoginStates {}

class EmptyState extends Equatable implements LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Authenticating extends Equatable implements LoginStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginSuccess extends Equatable implements LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginFailed extends Equatable implements LoginStates {
 final String error;

  const LoginFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}