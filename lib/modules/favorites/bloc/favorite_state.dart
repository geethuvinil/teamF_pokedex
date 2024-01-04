part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}
final class AddToFavorites extends FavoriteState{
    final bool isFavorite;
  AddToFavorites({required this.isFavorite});

}
final class RemoveFromFavorites extends FavoriteState{}
