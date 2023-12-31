import 'package:app/modules/login/login_page.dart';
import 'package:app/modules/reset_password/bloc/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    print('reset pageeeeeeeee');
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => _resetPasswordBloc,
        child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content:
                      Center(child: Text('Password changed successfully.')),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
            if (state is ResetPasswordFailed) {
              SnackBar(
                backgroundColor: Colors.red,
                content: Center(
                    child: Text('Password reset failed. Please try later.')),
              );
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
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email id',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.confirmation_number,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
       SnackBar(
                backgroundColor: Colors.black,
                content: Center(
                    child: Text('Enter the email address')),
              );
    }
   else if(latestPassword.isEmpty){
       SnackBar(
                backgroundColor: Colors.black,
                content: Center(
                    child: Text('Enter the new password')),
              );
    }
    else if(confirmationPassword.isEmpty){
       SnackBar(
                backgroundColor: Colors.black,
                content: Center(
                    child: Text('Renter the new password')),
              );
    }
      else if(latestPassword != confirmationPassword){
       SnackBar(
                backgroundColor: Colors.black,
                content: Center(
                    child: Text('Passwords doesnot match each other')),
              );
    }
    else{
     context.read<ResetPasswordBloc>().add( SubmitNewPasswordEvent(email: emailId, newPassword: latestPassword));
    }
  }
}
