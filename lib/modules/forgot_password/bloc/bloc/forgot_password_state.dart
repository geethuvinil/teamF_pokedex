part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}
final class OtpSent extends ForgotPasswordState {

  final String emailOtp;
  OtpSent({required this.emailOtp});

}
final class EmailNotFound extends ForgotPasswordState {
  
}
