part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupSuccess extends SignupState {}

final class EmailExisting extends SignupState {}

final class SignupFailed extends SignupState {}



////   final String email;
 //// SignupSuccess({required this.email});
 
 // the above 2 lines are given in state.dart file, if we have to show any data(eg: email, number,name of the user),
 // in the UI. to show this we need to take these data from the DB.