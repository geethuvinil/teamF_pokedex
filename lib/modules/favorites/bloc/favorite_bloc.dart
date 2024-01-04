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
          emit(AddToFavorites(isFavorite: true));
        }
        if(response['statusCode'] == 204){
            print('----------------------${response['statusCode']}');
          emit(RemoveFromFavorites());
        }
      } catch (e) {
        print('Error: $e');
      }
   }
    });
  }
}
