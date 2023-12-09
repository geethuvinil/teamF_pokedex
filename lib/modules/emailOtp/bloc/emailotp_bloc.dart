import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'emailotp_event.dart';
part 'emailotp_state.dart';

class EmailotpBloc extends Bloc<EmailotpEvent, EmailotpState> {
  EmailotpBloc() : super(EmailotpInitial()) {
    on<EmailotpEvent>((event, emit) async{
      if(event is SubmitEmailOtp){
Map<String,dynamic> otpCredentials = {
'submittedEmail': event.email,
'submittedOtp':event.emailOtp
};
try {
  dynamic response = await AuthService().verifyOtp(otpCredentials);
  if(response['statusCode'] == 200){
emit(VerificationSuccess());
  }
  if(response['statusCode'] == 404){
    emit(VerificationFailed());
  }
} catch (e) {
  print(e);
}
      }
    });
  }
}
