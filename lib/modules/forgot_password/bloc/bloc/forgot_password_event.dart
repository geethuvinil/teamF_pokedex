part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class SubmitEnteredEmail extends ForgotPasswordEvent {
  final String regEmail;

  SubmitEnteredEmail({
    required this.regEmail,
  });
}
