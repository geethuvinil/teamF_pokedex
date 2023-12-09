part of 'profile_details_bloc.dart';

@immutable
sealed class ProfileDetailsState {}

final class ProfileDetailsInitial extends ProfileDetailsState {}
final class FetchedProfileDetailsSuccessfully extends ProfileDetailsState {
  
  final String userName;
   final String userEmail;
    final String userMobile;
     final String userPassword;

  FetchedProfileDetailsSuccessfully({required this.userEmail,
  required this.userName,
  required this.userMobile,
  required this.userPassword
  });

}
final class FetchedProfileDetailsFailed extends ProfileDetailsState{}

