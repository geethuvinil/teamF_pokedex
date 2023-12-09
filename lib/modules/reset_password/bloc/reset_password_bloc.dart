import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      if(event is SubmitNewPasswordEvent){
         Map<String, dynamic> credentials = {
          'email': event.email,
          'password': event.newPassword
        };

        try {
          dynamic response = await AuthService().resetPassword(credentials);
          if(response['statusCode'] == 201){
            emit(ResetPasswordSuccess());
          }
 if(response['statusCode'] == 402){
            emit(ResetPasswordFailed());
          }
        }

        catch(e){}
      }
    });

    }
  }

