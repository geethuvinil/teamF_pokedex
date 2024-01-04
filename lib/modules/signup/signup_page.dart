import 'package:app/common_widgets/common_textformfield.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/signup/bloc/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userMobileController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userRePasswordController = TextEditingController();

  SignupBloc _signupBloc = SignupBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _signupBloc,
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              QuickAlert.show(context: context, type: QuickAlertType.success,
              text: 'Signup completed successfully',
             

              confirmBtnText: 'Continue',
              onConfirmBtnTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userEmailid: _userEmailController.text),
                ),
              );
              },

              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => HomePage(
              //             userEmailid: _userEmailController.text,
              //           )),
              // );
            }
            if (state is EmailExisting) {
              QuickAlert.show(context: context, type: QuickAlertType.error,
              text: 'This email already exist.',
              autoCloseDuration: Duration(seconds: 3),
              showConfirmBtn:false);
            }
            if (state is SignupFailed) {
             QuickAlert.show(context: context, type: QuickAlertType.error,
              text: 'Signup failed. Please try again later.',
              autoCloseDuration: Duration(seconds: 3),
              showConfirmBtn:false);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.yellow,
                      Colors.orange,
                      Colors.orange,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello There',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Let's Get Started!",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 17),
                                    child: CommonTextFormFieldWidget(
                                        controller: _userNameController,
                                        labelString: 'Name',
                                        prefixIconWidget: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ))),

                                Padding(
                                    padding: EdgeInsets.only(bottom: 17),
                                    child: CommonTextFormFieldWidget(
                                        controller: _userEmailController,
                                        labelString: 'Email',
                                        prefixIconWidget: Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        ))),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 17),
                                  child: IntlPhoneField(
                                    controller: _userMobileController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                // Padding(
                                //   padding: EdgeInsets.only(bottom: 17),
                                //   child:  CommonTextFormFieldWidget(
                                //     controller: _userMobileController,
                                //     labelString: 'Phone Number',
                                //     prefixIconWidget: Icon(
                                //       Icons.phone,
                                //       color: Colors.black,
                                //     ))
                                // ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 17),
                                    child: CommonTextFormFieldWidget(
                                      obscureText: true,
                                      maxLines: 1,
                                        controller: _userPasswordController,
                                        labelString: 'Password',
                                        prefixIconWidget: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ))),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 17),
                                    child: CommonTextFormFieldWidget(
                                      maxLines: 1,
                                      obscureText: true,
                                        controller: _userRePasswordController,
                                        labelString: 'Confirm Password',
                                        prefixIconWidget: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ))),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .only(), // Adjust the value to control the curve
                                  ),
                                  child: BlocBuilder<SignupBloc, SignupState>(
                                    builder: (context, state) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          validateUserDetails(
                                              _userNameController.text,
                                              _userEmailController.text,
                                              _userMobileController.text,
                                              _userPasswordController.text,
                                              _userRePasswordController.text,
                                              context);
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orangeAccent),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              side: BorderSide(
                                                  color: Colors
                                                      .black), // You can set the border color as needed
                                            ),
                                          ),
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color>((states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Colors.orangeAccent
                                                  .withOpacity(0.5);
                                            }
                                            return Colors.transparent;
                                          }),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 14, top: 8, right: 14),
                                          child: Text(
                                            'SignUp',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                           
                            Image.asset(
                              "assets/images/poke.png",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
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

  validateUserDetails(String userName, String userEmail, String userMobile,
      String userPassword, String userRePassword, BuildContext context) {
        
    if (userName.isEmpty) {
       QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter a username',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Please enter a username')));
    }  else if (userEmail.isEmpty) {
   QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter an email address',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    }else if (userMobile.isEmpty) {
       QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter a 10 digit mobile number',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    } 
    else if (userPassword.isEmpty) {
      QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter a password',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    } else if (userRePassword.isEmpty) {
  QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please re enter the password',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    } else if ((userPassword) != (userRePassword)) {
      QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Both passwords doesnot match each other',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
    } else {
      context.read<SignupBloc>().add(SignupUser(
          userName: userName,
          userMobile: userMobile,
          userEmail: userEmail,
          userPassword: userPassword));
    }
  }
}
