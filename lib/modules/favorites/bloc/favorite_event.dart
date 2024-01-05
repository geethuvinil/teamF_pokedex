part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class AddToFav extends FavoriteEvent{
  final String email;
  final String pokedexName;

  AddToFav({
required this.email,
required this.pokedexName
  });
}
class RemoveFromFav extends FavoriteEvent{
  final String email;
  final String pokedexName;

  RemoveFromFav({
required this.email,
required this.pokedexName
  });
}