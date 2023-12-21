import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/home/home_page_store.dart';
import 'package:app/modules/items/items_page.dart';
import 'package:app/modules/pokemon_grid/pokemon_grid_page.dart';
import 'package:app/modules/profile_details/bloc/profile_details_bloc.dart';
import 'package:app/modules/profile_details/profile_details_page.dart';
import 'package:app/shared/stores/item_store/item_store.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/ui/enums/device_screen_type.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/ui/widgets/app_bar.dart';
import 'package:app/shared/ui/widgets/drawer_menu/drawer_menu.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  final String? userEmailid;
  HomePage({Key? key, this.userEmailid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _backgroundAnimationController;
  late Animation<double> _blackBackgroundOpacityAnimation;

  late AnimationController _fabAnimationRotationController;
  late AnimationController _fabAnimationOpenController;
  late Animation<double> _fabRotateAnimation;
  late Animation<double> _fabSizeAnimation;

  late PokemonStore _pokemonStore;
  late ItemStore _itemStore;
  late HomePageStore _homeStore;
  late PanelController _panelController;

  late List<ReactionDisposer> reactionDisposer = [];
  ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();

  @override
  void initState() {
    super.initState();
    print('92828252545${widget.userEmailid}');
    _pokemonStore = GetIt.instance<PokemonStore>();
    _itemStore = GetIt.instance<ItemStore>();
    _homeStore = GetIt.instance<HomePageStore>();
    _panelController = PanelController();

    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _blackBackgroundOpacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_backgroundAnimationController);

    _fabAnimationRotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fabAnimationOpenController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _fabRotateAnimation = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.easeOut, parent: _fabAnimationRotationController));

    _fabSizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 80.0),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 20.0),
    ]).animate(_fabAnimationRotationController);

    reactionDisposer.add(
      reaction((_) => _homeStore.isFilterOpen, (_) {
        if (_homeStore.isFilterOpen) {
          _panelController.open();
          _homeStore.showBackgroundBlack();
          _homeStore.hideFloatActionButton();
        } else {
          _panelController.close();
          _homeStore.hideBackgroundBlack();
          _homeStore.showFloatActionButton();
        }
      }),
    );

    reactionDisposer.add(
      reaction((_) => _homeStore.isBackgroundBlack, (_) {
        if (_homeStore.isBackgroundBlack) {
          _backgroundAnimationController.forward();
        } else {
          _backgroundAnimationController.reverse();
        }
      }),
    );

    reactionDisposer.add(
      reaction((_) => _homeStore.isFabVisible, (_) {
        if (_homeStore.isFabVisible) {
          _fabAnimationRotationController.forward();
        } else {
          _fabAnimationRotationController.reverse();
        }
      }),
    );

    _fabAnimationRotationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        print('welcomezllLaz');
        return BlocProvider(
          create: (context) => _profileDetailsBloc,
          child: BlocConsumer<ProfileDetailsBloc, ProfileDetailsState>(
            listener: (context, state) {
               print('state is  $state');
                // if (state is FetchedProfileDetailsSuccessfully) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) =>
                //             ProfileDetailsPage(emailId: state.userEmail),
                //       ));
                // }
                // if (state is FetchedProfileDetailsFailed) {
                //   AlertDialog(
                //     title: Text('No user found'),
                //   );
                // }
            },
            builder: (context, state) {
              return Scaffold(
                key: const Key('home_page'),
                backgroundColor: Theme.of(context).colorScheme.background,
                endDrawer: const Drawer(
                  child: DrawerMenuWidget(),
                ),
                body: WillPopScope(
                  onWillPop: showExitPopUp,
                  child: Stack(children: [
                    SafeArea(
                      bottom: false,
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            sliver: Observer(
                              builder: (_) => AppBarWidget(
                                title: _homeStore.page.description,
                                lottiePath: AppConstants.squirtleLottie,
                                userEmail: widget.userEmailid,
                              ),
                             
                            ),
                          ),
                          Observer(
                            builder: (_) {
                              switch (_homeStore.page) {
                                case HomePageType.POKEMON_GRID:
                                  return PokemonGridPage();
                                case HomePageType.ITENS:
                                  return ItemsPage();
                                default:
                                  return PokemonGridPage();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Future<bool> showExitPopUp() async { 
    return await QuickAlert.show(context: context,
     type: QuickAlertType.confirm,
     text: 'Do you really want to exit from the app?',
     confirmBtnText: 'Yes',
     onConfirmBtnTap: () {
      SystemNavigator.pop();
     },
     cancelBtnText: 'No',
    
     onCancelBtnTap: () {
       Navigator.pop(context);
     },);
  
  }
}
