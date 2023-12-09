part of 'emailotp_bloc.dart';

@immutable
sealed class EmailotpEvent {}

class SubmitEmailOtp extends EmailotpEvent{
  final String email;
  final String emailOtp;
  SubmitEmailOtp({
   required this.email,
   required this.emailOtp
  });
}
