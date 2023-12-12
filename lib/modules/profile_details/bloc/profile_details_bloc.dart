import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc
    extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  ProfileDetailsBloc() : super(ProfileDetailsInitial()) {
    on<ProfileDetailsEvent>((event, emit) async {
      if (event is UserProfileDetails) {
        try {
          dynamic response =
              await AuthService().fetchUserDetails(event.userEmailId);
          print('response code == ${response['statusCode']}');
          if (response['statusCode'] == 201 ) {
            print('hihiijsfsdfs');
            print('name is ${response['userData']['name']}');
            print('email is ${response['userData']['email']}');
            print('mobile is ${response['userData']['mobile']}');
          emit(FetchedProfileDetailsSuccessfully(
            userName: response['userData']['name'], 
            userEmail: response['userData']['email'],
             userMobile: response['userData']['mobile'].toString()));
         
          }
          if (response['statusCode'] == 404) {
            print('5555555 $response');
            emit(FetchedProfileDetailsFailed());
          }
        } catch (e) {
          print('$e');
        }
      }
    });
  }
}
