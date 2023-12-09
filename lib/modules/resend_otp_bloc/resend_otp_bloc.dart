
import 'dart:math';

import 'package:app/modules/emailOtp/emailOtp_page.dart';
import 'package:app/modules/forgot_password/bloc/bloc/forgot_password_bloc.dart';
import 'package:app/modules/repository/auth.service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  ResendOtpBloc() : super(ResendOtpInitial()) {
    on<ResendOtpEvent>((event, emit) async {
      num otp = 0;
      if (event is ResendOtp) {
        Map<String, dynamic> credentials = {
          'email': event.userEmail,
        };
        try {
          dynamic response =  await AuthService().resendOtp(credentials);
          if(response['statusCode'] == 201){
int min = 10000;
            int max = 99999;
            Random random = Random();
             otp = min + random.nextInt(max - min + 1);
            print(otp);
        String emailContent = '''Dear user,
Your new One Time Password (OTP) to reset your password is $otp.

Enjoy using Pokedex.
''';
        print('//////////////////////');
        await AuthService().sendOtpToUser(
          event.userEmail, 
          'We have sent a new OTP', 
          emailContent);
        
          emit(
            ResendOtpSent(newOtp: otp.toString()));
            print('otp in resend bloc === ${otp.toString()}');
          }
    
                  
if (response['statusCode'] == 404) {
            print('5555555 $response');
            emit(ResendOtpFailed());
          }

        } catch (e) {
          
        }
        
        
    }});
  }
}
