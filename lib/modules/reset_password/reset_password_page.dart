import 'package:app/common_widgets/common_textformfield.dart';
import 'package:app/modules/login/login_page.dart';
import 'package:app/modules/reset_password/bloc/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class RsestPasswordPage extends StatefulWidget {
  RsestPasswordPage({super.key});

  @override
  State<RsestPasswordPage> createState() => _RsestPasswordPageState();
}

class _RsestPasswordPageState extends State<RsestPasswordPage> {
  ResetPasswordBloc _resetPasswordBloc = ResetPasswordBloc();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _resetPasswordBloc,
        child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
             QuickAlert.show(context: context, type: QuickAlertType.success,
              text: 'Password changed successfully',
             

              confirmBtnText: 'Continue',
              onConfirmBtnTap: () {
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
              },

              );
             
            }
            if (state is ResetPasswordFailed) {
             QuickAlert.show(context: context, type: QuickAlertType.error,
             text: 'Password reset failed. Please try again later',
             autoCloseDuration: Duration(seconds: 2),
             showConfirmBtn: false);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/pokeball.jpg',
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: CommonTextFormFieldWidget(
                                    controller: _emailController,
                                    labelString: 'Email Id',
                                    prefixIconWidget: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ))
                    
                    
                    
             
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: CommonTextFormFieldWidget(
                      obscureText: true,
                      maxLines: 1,
                                    controller: _newPasswordController,
                                    labelString: 'New Password',
                                    prefixIconWidget: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ))
                    
                    
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child:  CommonTextFormFieldWidget(
                      obscureText: true,
                      maxLines: 1,
                                    controller: _confirmPasswordController,
                                    labelString: 'Confirm New Password',
                                    prefixIconWidget: Icon(
                                      Icons.confirmation_number,
                                      color: Colors.black,
                                    ))
                    
                    
                 
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 23),
                    child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            print('5555${_emailController.text}');
                            validateNewPassword(
                                _emailController.text,
                                _newPasswordController.text,
                                _confirmPasswordController.text,
                                context);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orangeAccent),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(
                                    color: Colors
                                        .black), // You can set the border color as needed
                              ),
                            ),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.orangeAccent.withOpacity(0.5);
                              }
                              return Colors.transparent;
                            }),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  validateNewPassword(String emailId, String latestPassword,
      String confirmationPassword, BuildContext context) {
    print('haii ${emailId}');
  if(emailId.isEmpty){
    QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Enter the email address',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
  }
   else if(latestPassword.isEmpty){
       QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Enter the new password',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    }
    else if(confirmationPassword.isEmpty){
      QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Re enter the new password',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    }
      else if(latestPassword != confirmationPassword){
       QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Passwords doesnot match each other',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    } 
    else{
     context.read<ResetPasswordBloc>().add( SubmitNewPasswordEvent(email: emailId, newPassword: latestPassword));
    }
  }
}
