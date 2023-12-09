part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {}
class SubmitNewPasswordEvent extends ResetPasswordEvent{
  final String email;
  final String newPassword;
   SubmitNewPasswordEvent({
    required this.email,
    required this.newPassword
  });
}