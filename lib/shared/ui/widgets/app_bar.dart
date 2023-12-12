import 'package:app/modules/profile_details/bloc/profile_details_bloc.dart';
import 'package:app/modules/profile_details/profile_details_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/theme/app_theme.dart';

import '../../utils/app_constants.dart';
import '../enums/device_screen_type.dart';

class AppBarWidget extends StatefulWidget {
  final String title;
  final String? lottiePath;
  final String? userEmail;

  const AppBarWidget(
      {Key? key, required this.title, this.lottiePath, this.userEmail})
      : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    print('appbar page');
    return BlocProvider(
      create: (context) => _profileDetailsBloc,
      child: BlocConsumer<ProfileDetailsBloc, ProfileDetailsState>(
        listener: (context, state) {
            print('state is  $state');
            print('emailid issssssss  ${widget.userEmail}');
                if (state is FetchedProfileDetailsSuccessfully) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileDetailsPage(emailId: widget.userEmail,name: state.userName,phone: state.userMobile),
                      ));
                }
                if (state is FetchedProfileDetailsFailed) {
                  // AlertDialog(
                  //   title: Text('No user found'),
                  // );
                  SnackBar(
          backgroundColor: Colors.green,
          content: Center(child: Text('235566')),
        );
                }
        },
        builder: (context, state) {
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
                padding: EdgeInsets.only(top: 20, left: 5),
                child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context.read<ProfileDetailsBloc>().add(
                              UserProfileDetails(
                                  userEmailId: widget.userEmail ?? ''));
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ));
                  },
                ),
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
                        getDeviceScreenType(context) !=
                            DeviceScreenType.CELLPHONE)
                      SizedBox(
                        width: 5,
                      ),
                    if (kIsWeb &&
                        getDeviceScreenType(context) !=
                            DeviceScreenType.CELLPHONE)
                      Image.network(
                        AppConstants.getRandomPokemonGif(),
                        height: 32,
                      )
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
