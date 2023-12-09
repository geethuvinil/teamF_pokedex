part of 'emailotp_bloc.dart';

@immutable
sealed class EmailotpState {}

final class EmailotpInitial extends EmailotpState {}
final class VerificationSuccess extends EmailotpState{}
final class VerificationFailed extends EmailotpState{}
