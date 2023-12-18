import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
     if(event is UserLogin){
      Map<String,dynamic> loginCredentials = {
'email':event.loginEmail,
'password':event.loginPassword
      };
      try {
        dynamic response = await AuthService().userLogin(loginCredentials);
        if(response['statusCode'] == 201){
          emit(LoginSuccess());
        }
        if(response['statusCode'] == 405){
          emit(LoginFailed());
        }
      } catch (e) {
        print('Error: $e');
      }
     }


    });
  }
}
