import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/signup/bloc/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sign up successfull.'),
                  backgroundColor: Colors.green,));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(userEmailid: _userEmailController.text,)),
              );
            }
            if (state is EmailExisting) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('This email already exist.'),
                  backgroundColor: Colors.orange,));
            }
            if (state is SignupFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Signup failed. Please try again later'),
                  backgroundColor: Colors.red,));
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
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 17),
                                  child: TextFormField(
                                    controller: _userNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 17),
                                  child: TextFormField(
                                    controller: _userEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 17),
                                  child: TextFormField(
                                    controller: _userMobileController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 17),
                                  child: TextFormField(
                                    controller: _userPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 17),
                                  child: TextFormField(
                                    controller: _userRePasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
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
                                          context
                                          );
                                          
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
                            SizedBox(height: 10),
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
  validateUserDetails(String userName,String userEmail,String userMobile,String userPassword,
  String userRePassword,BuildContext context){

     if(userName.isEmpty){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please enter a username')));
                                        }
                                        else if(userMobile.isEmpty){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please enter a 10 digit mobile number')));
                                        }
                                       else if(userEmail.isEmpty){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please enter an email address')));
                                        }
                                        else if(userPassword.isEmpty){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please enter a password')));
                                        }
                                          else if(userRePassword.isEmpty){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please re enter the password')));
                                        }
                                        else if((userPassword)!= (userRePassword)){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Both passwords are not same')));
                                        }
                                        else{
 context.read<SignupBloc>().add(
                                              SignupUser(
                                                userName: userName,
                                                userMobile: userMobile,
                                                userEmail: userEmail,
                                                userPassword: userPassword)
                                            );
                                        }
  }
}
