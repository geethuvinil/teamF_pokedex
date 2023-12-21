import 'package:app/common_widgets/common_textformfield.dart';
import 'package:app/modules/forgot_password/forgot_password.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/login/bloc/bloc/login_bloc.dart';
import 'package:app/modules/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
                print('qiockalerrtttt');
              QuickAlert.show(context: context, type: QuickAlertType.success,
              text: 'Logged in successfully',
             

              confirmBtnText: 'Continue',
              onConfirmBtnTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userEmailid: _emailController.text),
                ),
              );
              },

              );
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Login success.'),
              //   backgroundColor: Colors.green,
              // ));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         HomePage(userEmailid: _emailController.text),
              //   ),
              // );
            }
            if (state is LoginFailed) {
             
              QuickAlert.show(context: context, type: QuickAlertType.error,
              text: 'Login failed due to incorrect email or password',
              autoCloseDuration: Duration(seconds: 3),
              showConfirmBtn:false);
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Login failed. Please try again later.'),
              //   backgroundColor: Colors.red,
              // ));
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
                        children: <Widget>[
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Please Login to Continue...",
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
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 17),
                                child: CommonTextFormFieldWidget(
                                  controller: _emailController,
                                  labelString: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  prefixIconWidget: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(bottom: 17),
                                child: CommonTextFormFieldWidget(
                                  obscureText: true,
                                  maxLines: 1,
                                    controller: _passwordController,
                                    labelString: 'Password',
                                    prefixIconWidget: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPage(),
                                          ));
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(),
                                  ),
                                  child: BlocBuilder<LoginBloc, LoginState>(
                                    builder: (context, state) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          validateLoginDetails(
                                              _emailController.text,
                                              _passwordController.text,
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
                                          padding: const EdgeInsets.all(14.0),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 16),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupPage(),
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "Don't have an Account?",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        'SignUp',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(height: 10),
                            Image.asset(
                              "assets/images/pokefrds.png",
                              height: 400,
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

  validateLoginDetails(
      String loginEmail, String loginPassword, BuildContext context) {
    print('jdnjddn$loginEmail');
    if (loginEmail.isEmpty) {
      QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter your email',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Please enter an email')));
    } else if (loginPassword.isEmpty) {
         QuickAlert.show(context: context, type: QuickAlertType.warning,
      text:'Please enter your password',
      autoCloseDuration: Duration(seconds: 3),
      showConfirmBtn: false );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Please enter a password')));
    }
 
     else {
      context
          .read<LoginBloc>()
          .add(UserLogin(loginEmail: loginEmail, loginPassword: loginPassword));
    }
  }
}
