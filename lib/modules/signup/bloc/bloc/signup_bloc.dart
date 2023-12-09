import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is SignupUser) {
        Map<String, dynamic> userData = {
          'name': event.userName,
          'email': event.userEmail,
          'mobile': event.userMobile,
          'password': event.userPassword
        };
        // Converting the collected individual strings to Map
        try {
          dynamic response = await AuthService().registerUser(userData);

          // passing the collected data(now in map type) to the repository/AuthService
          print('Response: $response');
          if (response['statusCode'] == 201) {
            emit(SignupSuccess());
          }
          if (response['statusCode'] == 409) {
            print('email taken');
            emit(EmailExisting());
          }
        } catch (e) {
          print('Error: $e');
        }
      }
    });
  }
}
