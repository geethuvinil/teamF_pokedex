import 'package:app/common_widgets/common_textformfield.dart';
import 'package:app/modules/emailOtp/emailOtp_page.dart';
import 'package:app/modules/forgot_password/bloc/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _forgotPasswordBloc,
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is OtpSent) {
                           QuickAlert.show(context: context, type: QuickAlertType.success,
              text: 'OTP has been sent to your registered email address',
             

              confirmBtnText: 'Continue',
              onConfirmBtnTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpPage(
                      typedOtp: state.emailOtp,
                      userEmailId: _emailController.text,
                      isResendOtp: false,
                  ))
              );
              },

              );
              
            }

            if (state is EmailNotFound) {
              QuickAlert.show(context: context, type: QuickAlertType.error,
              text: 'Email not found',
              showConfirmBtn: false,
              autoCloseDuration: Duration(seconds: 2));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16, top: 25),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/fire.png",
                      width: 250,
                      height: 250,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Enter your Email to Reset Password",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child:  CommonTextFormFieldWidget(
                                    controller: _emailController,
                                    labelString: 'Email',
                                    prefixIconWidget: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ))
                      
                      
                      
                   
                      
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                          if(_emailController.text.isEmpty){
                                QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter your registered email',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
                                     }
                                      QuickAlert.show(context: context, type: QuickAlertType.loading,
      text:'Loading',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
                                   context.read<ForgotPasswordBloc>().add(SubmitEnteredEmail(
                                    regEmail: _emailController.text,
                                    
                                 ));
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
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
                                'Reset Password',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
