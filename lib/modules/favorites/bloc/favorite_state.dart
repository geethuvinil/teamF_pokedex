part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}
final class AddToFavoritesSuccess extends FavoriteState{
    final bool isFavorite;
  AddToFavoritesSuccess({required this.isFavorite});

}
final class AddToFavoritesFailed extends FavoriteState{}

final class RemoveFromFavoritesSuccess extends FavoriteState{
  
}
final class RemoveFromFavoritesFailed extends FavoriteState{}

final class FetchFavoritesSuccess extends FavoriteState{
 final List favoritesList;

  FetchFavoritesSuccess({required this.favoritesList}); 
}
final class FavoritesListEmpty extends FavoriteState{}
final class FecthFavoritesFailed extends FavoriteState{}

