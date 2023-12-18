import 'package:app/modules/profile_details/bloc/profile_details_bloc.dart';
import 'package:app/modules/repository/auth.service.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  final String? emailId;
  final String? name;
  final String? phone;
  const ProfileDetailsPage({super.key, this.emailId, this.name, this.phone});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'My Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            profileDetailsWidget(
                heading: 'Username',
                subHeading: '${widget.name}',
                iconName: Icons.person),
            profileDetailsWidget(
                heading: 'Email Id',
                subHeading: '${widget.emailId}',
                iconName: Icons.email),
            profileDetailsWidget(
                heading: 'Mobile Number',
                subHeading: '${widget.phone}',
                iconName: Icons.phone),
          ],
        ),
      ),
    );
  }

  profileDetailsWidget(
      {String? heading, String? subHeading, IconData? iconName}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.blue.shade50,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: ListTile(
          title: Text(
            heading ?? '',
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          subtitle: Text(
            subHeading ?? '',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          leading: Icon(
            iconName,
            size: 32,
          ),
        ),
      ),
    );
  }
}
