part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}
class SignupUser extends SignupEvent{
  final String userName;
  final String userEmail;
  final String userMobile;
  final String userPassword;

  SignupUser({
required this.userName,
required this.userEmail,
required this.userMobile,
required this.userPassword
  });
}
