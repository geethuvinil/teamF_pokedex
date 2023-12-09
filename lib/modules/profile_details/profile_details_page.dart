import 'package:app/modules/repository/auth.service.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  final String? emailId;
  const ProfileDetailsPage({super.key,this.emailId});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails();
  }

userDetails()async{
dynamic userData = await AuthService().fetchUserDetails(widget.emailId?? '');
print('------------$userData');
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('hi ${widget.emailId} ',
          style: TextStyle(fontSize: 36),)),
              Center(child: Text('hi ${widget.emailId} ',
          style: TextStyle(fontSize: 36),)),
        ],
      ),
    );
  }
}