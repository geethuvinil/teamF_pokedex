import 'package:app/myfav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';

 
class MyDrawer extends StatefulWidget {
    final String? emailid;
  MyDrawer({Key? key, this.emailid}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    double drawerWidth = MediaQuery.of(context).size.width * 0.1;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.orange,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 38,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                 SizedBox(height: 10),
                // Text(
                //   'Ashika',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                
                Text(
                  '${widget.emailid}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.lock),
          //   title: Text('Privacy Policy'),
          //   onTap: () {
          //    Navigator.pop(context);
          //   },
          // ),
             ListTile(
            leading: Icon(Icons.lock),
            title: Text('Fav'),
            onTap: () {
             Navigator.pop(context);
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyFavorites(
              userEmailid: widget.emailid,
             ),));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              Navigator.pop(context);
              showExitPopUp();
            },
          ),
        ],
      ),
    );
  }
  showExitPopUp() async { 
    return await QuickAlert.show(context: context,
     type: QuickAlertType.confirm,
     text: 'Do you really want to exit from the app?',
     confirmBtnText: 'Yes',
     onConfirmBtnTap: () {
      SystemNavigator.pop();
     },
   );

  }
}