part of 'profile_details_bloc.dart';

@immutable
sealed class ProfileDetailsState {}

final class ProfileDetailsInitial extends ProfileDetailsState {}
final class FetchedProfileDetailsSuccessfully extends ProfileDetailsState {
  
  final String userName;
   final String userEmail;
    final String userMobile;
     

  FetchedProfileDetailsSuccessfully({required this.userName,
  required this.userEmail,
  required this.userMobile,

  });

}
final class FetchedProfileDetailsFailed extends ProfileDetailsState{}

