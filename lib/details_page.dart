import 'package:app/modules/favorites/bloc/favorite_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DetailPage extends StatefulWidget {
  final pokemonDetail;
  final Color color;
  final int heroTag;
  final String? emailId;

  const DetailPage(
      {super.key,
      this.pokemonDetail,
      this.emailId,
      required this.color,
      required this.heroTag});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  FavoriteBloc _favoriteBloc = FavoriteBloc();
  bool isFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('pokemon details === ${widget.pokemonDetail}');
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.color,
      body: BlocProvider(
        create: (context) => _favoriteBloc,
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is AddToFavoritesSuccess) {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Added to Favorites',
                  autoCloseDuration: Duration(seconds: 2),
                  showConfirmBtn: false);
            }

            if (state is AddToFavoritesFailed) {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  text: 'Adding to favorites failed. Please try again later',
                  autoCloseDuration: Duration(seconds: 2),
                  showConfirmBtn: false);
            }
            if (state is RemoveFromFavoritesSuccess) {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Removed from Favorites',
                  autoCloseDuration: Duration(seconds: 2),
                  showConfirmBtn: false);
            }
            if (state is RemoveFromFavoritesFailed) {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  text:
                      'Removing from favorites failed. Please try again later',
                  autoCloseDuration: Duration(seconds: 2),
                  showConfirmBtn: false);
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 35,
                  left: 18,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ),
                Positioned(
                    top: 35,
                    right: 18,
                    child: BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                              print(
                                  'set state value of isFavorite ==$isFavorite');
                            });
                            if (!isFavorite) {
                              print('remove from fav');
                              context.read<FavoriteBloc>().add(RemoveFromFav(
                                  email: widget.emailId ?? '',
                                  pokedexName: (widget.pokemonDetail['name'])
                                      .toString()));
                            } else {
                              print('add to fav');
                              context.read<FavoriteBloc>().add(AddToFav(
                                    email: widget.emailId ?? '',
                                    pokedexName: (widget.pokemonDetail['name'])
                                        .toString(),
                                  ));
                            }
                          },
                          icon: Icon(Icons.favorite),
                          color: isFavorite ? Colors.yellow : Colors.white,
                          iconSize: 25,
                        );
                      },
                    )),
                Positioned(
                    top: 80,
                    left: 20,
                    child: Text(
                      widget.pokemonDetail['name'],
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
                Positioned(
                    top: 140,
                    left: 20,
                    child: Container(
                      child: Text(
                        widget.pokemonDetail['type'].join(', '),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                    top: height * 0.18,
                    right: -30,
                    child: Image.asset(
                      'assets/images/pball.png',
                      height: 200,
                      fit: BoxFit.fitHeight,
                      color: Colors.white,
                    )),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: height * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Height',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['height'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Weight',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['weight'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Weight',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['weight'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Spawn Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['spawn_time'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Candy',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['candy'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        'Candycount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black26),
                                      )),
                                  Container(
                                      width: width * 0.3,
                                      child: Text(
                                        widget.pokemonDetail['candy_count']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: (height * 0.18),
                    right: (width / 2) - 100,
                    child: CachedNetworkImage(
                      imageUrl: widget.pokemonDetail['img'],
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
