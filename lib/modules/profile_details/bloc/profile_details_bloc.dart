import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  ProfileDetailsBloc() : super(ProfileDetailsInitial()) {
    on<ProfileDetailsEvent>((event, emit) async{
      if(event is FetchedProfileDetailsSuccessfully){
      
      // try {
      //   dynamic response = await AuthService().fetchUserDetails();
      //   if(response['statusCode'] == 201){
      //     emit(FetchedProfileDetailsSuccessfully(userEmail: , userName: userName, userMobile: userMobile, userPassword: userPassword))
      //   }
      //   if (response['statusCode'] == 404) {
      //       print('5555555 $response');
      //       emit(FetchedProfileDetailsFailed());
      //     }
      // } catch (e) {
        
      // }
      }
    });
  }
}
