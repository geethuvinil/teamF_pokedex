part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpEvent {}
class ResendOtp extends ResendOtpEvent{
  final String userEmail;
  
  ResendOtp({
  
   required this.userEmail
  });
}