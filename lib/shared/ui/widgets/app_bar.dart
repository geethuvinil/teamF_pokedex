import 'package:app/modules/profile_details/profile_details_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/theme/app_theme.dart';

import '../../utils/app_constants.dart';
import '../enums/device_screen_type.dart';

class AppBarWidget extends StatefulWidget {
  final String title;
  final String? lottiePath;
  final String? userEmail;

  const AppBarWidget({Key? key, required this.title, this.lottiePath,this.userEmail})
      : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 170.0,
      collapsedHeight: 70,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(Icons.menu,
                color: AppTheme.getColors(context).appBarButtons),
          ),
        ),
        Padding(
         padding: EdgeInsets.only(top: 20,left: 5),
          child: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetailsPage(emailId: widget.userEmail),));
          }, icon: Icon(Icons.person,color: Colors.black,)),
        )
      ],
      flexibleSpace: Stack(children: [
        FlexibleSpaceBar(
          centerTitle: false,
          background: widget.lottiePath != null
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Lottie.asset(widget.lottiePath!, height: 140.0),
                )
              : Container(),
          titlePadding: EdgeInsets.only(left: 15, bottom: 10),
          title: Row(
            children: [
              AnimatedPokeballWidget(
                size: 24,
                color: AppTheme.getColors(context).pokeballLogoBlack,
              ),
              SizedBox(
                width: 5,
              ),
              Text(widget.title, style: textTheme.headline1),
              if (kIsWeb &&
                  getDeviceScreenType(context) != DeviceScreenType.CELLPHONE)
                SizedBox(
                  width: 5,
                ),
              if (kIsWeb &&
                  getDeviceScreenType(context) != DeviceScreenType.CELLPHONE)
                Image.network(
                  AppConstants.getRandomPokemonGif(),
                  height: 32,
                )
            ],
          ),
        ),
      ]),
    );
  }
}
