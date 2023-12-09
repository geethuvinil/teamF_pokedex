part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpState {}

final class ResendOtpInitial extends ResendOtpState {}
final class ResendOtpSuccess extends ResendOtpState {}
final class ResendOtpSent extends ResendOtpState {
  
  final String newOtp;
  ResendOtpSent({required this.newOtp});

}

final class ResendOtpFailed extends ResendOtpState {}