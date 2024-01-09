import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/auth.service.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
   if(event is AddToFav){
    Map<String,dynamic> details =  {
'email':event.email,
'pokeName':event.pokedexName
      };
         try {
        dynamic response = await AuthService().addToFavorites(details);
      
        if(response['statusCode'] == 201){
          print('525555a25625adsd${response['statusCode']}');
          emit(AddToFavoritesSuccess(isFavorite: true));
        }
        if(response['statusCode'] == 409){
          print('525555a25625adsd${response['statusCode']}');
          emit(ExistInFavorites());
        }
        if(response['statusCode'] == 500){
            print('----------------------${response['statusCode']}');
          emit(AddToFavoritesFailed());
        }
      } catch (e) {
        print('Error: $e');
      }
   }
   if(event is RemoveFromFav){
      Map<String,dynamic> details =  {
'email':event.email,
'pokeName':event.pokedexName
      };
         try {
        dynamic response = await AuthService().removeFromFavorites(details);
      
        if(response['statusCode'] == 201){
          print('525555a25625adsd${response['statusCode']}');
          emit(RemoveFromFavoritesSuccess());
        }
        if(response['statusCode'] == 204){
            print('----------------------${response['statusCode']}');
          emit(RemoveFromFavoritesFailed());
        }
      } catch (e) {
        print('Error: $e');
      }
   }

if(event is FetchFav){
      Map<String,dynamic> details =  {
'email':event.email,

      };
         try {
        dynamic response = await AuthService().fetchFavorites(event.email);
      
        if(response['statusCode'] == 201){
          print('525555a25625adsd${response['statusCode']}');
          emit(FetchFavoritesSuccess(favoritesList: response['favoritesList']));
        }
         if(response['statusCode'] == 409){
          print('525555a25625adsd${response['statusCode']}');
          emit(FavoritesListEmpty());
        }
        if(response['statusCode'] == 500){
            print('----------------------${response['statusCode']}');
          emit(FecthFavoritesFailed());
        }
      } catch (e) {
        print('Error: $e');
      }
   }

    });
  }
  
}
