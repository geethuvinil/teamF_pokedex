import 'dart:math';

import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async  {
if(event is SubmitEnteredEmail){
 
  try {
    
    dynamic response = 
    await AuthService().sendOtpForPasswordReset(event.regEmail);
    if(response['statusCode'] == 201){
        int min = 10000;
            int max = 99999;
            Random random = Random();
            num otp = min + random.nextInt(max - min + 1);
            print(otp);
            print('objectttttttttttttt');
             String emailContent = '''Dear user,
Your One Time Password (OTP) to reset your password is $otp.

Enjoy using Pokedex.
''';

  await AuthService().sendOtpToUser(event.regEmail, 'OTP to reset your password', emailContent);
           
           emit(OtpSent(emailOtp: otp.toString()));
           print('otp in forgot bloc === ${otp.toString()}');
          }

          if (response['statusCode'] == 404) {
            print('5555555 $response');
            emit(EmailNotFound());
          }
    
  } catch (e) {
    
  }
}
  });
}
}