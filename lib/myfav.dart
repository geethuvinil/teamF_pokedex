import 'package:app/modules/repository/auth.service.dart';
import 'package:flutter/material.dart';

class MyFavorites extends StatefulWidget {
  final String? userEmailid;
   MyFavorites({super.key,this.userEmailid});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
    var favDetails;
    AuthService _authService =AuthService();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:FutureBuilder(
          future: _authService.fetchFavorites(widget.userEmailid ?? ''),

         builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          
           else if(snapshot.hasError){
            return Text('error:${snapshot.error}');
           }
else{
favDetails = snapshot.data;
if(favDetails!=null){
  return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favDetails['data'].length,
                  itemBuilder: (context, index) {
                    return Text('${favDetails['data'][index]}');
                  },
                );
              } else {
                return Text('Favorite list is empty');
              }
}
})));
         }
     
  
  }
