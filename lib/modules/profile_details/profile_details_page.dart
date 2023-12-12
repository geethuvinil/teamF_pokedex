import 'package:app/modules/profile_details/bloc/profile_details_bloc.dart';
import 'package:app/modules/repository/auth.service.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  final String? emailId;
  final String? name;
  final String? phone;
  const ProfileDetailsPage({super.key, this.emailId,this.name,this.phone});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
 
  @override




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Text(
            'hi ${widget.emailId ?? ''} ',
            style: TextStyle(fontSize: 36),
          )),
           Center(
              child: Text(
            'name issss ${widget.name ?? ''} ',
            style: TextStyle(fontSize: 36),
          )),
           Center(
              child: Text(
            'mobile isss ${widget.phone ?? ''} ',
            style: TextStyle(fontSize: 36),
          )),
        
        ],
      ),
    );
  }
}
