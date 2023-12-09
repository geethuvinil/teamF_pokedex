part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordSuccess extends ResetPasswordState {}
final class ResetPasswordFailed extends ResetPasswordState {}