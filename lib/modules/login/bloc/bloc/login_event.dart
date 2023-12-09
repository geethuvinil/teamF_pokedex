part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class UserLogin extends LoginEvent{
  final String loginEmail;
  final String loginPassword;

  UserLogin({
required this.loginEmail,
required this.loginPassword
  });
}
