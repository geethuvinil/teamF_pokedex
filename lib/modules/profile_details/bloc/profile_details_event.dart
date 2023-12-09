part of 'profile_details_bloc.dart';

@immutable
sealed class ProfileDetailsEvent {}
class UserProfileDetails extends ProfileDetailsEvent{
  final String userEmailId;
  UserProfileDetails({
    required this.userEmailId
  });
}
