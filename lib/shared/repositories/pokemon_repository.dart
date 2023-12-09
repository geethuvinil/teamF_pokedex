import 'dart:convert';

import 'package:app/shared/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:app/shared/models/pokemon.dart';
import 'package:app/shared/models/pokemon_summary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonRepository {
  Future<List<PokemonSummary>> fetchPokemonsSummary() async {
    try {
      final response =
          await http.get(Uri.parse(ApiConstants.pokedexSummaryData));

      return List<PokemonSummary>.from(
        json.decode(Utf8Decoder().convert(response.body.codeUnits)).map(
              (model) => PokemonSummary.fromJson(model),
            ),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> fetchFavoritesPokemonsSummary() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorites-pokemons');

      if (favorites == null) {
        return [];
      } else {
        return favorites;
      }
    } catch (e) {
      throw e;
    }
  }

  void saveFavoritePokemonSummary(List<String> favorites) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites-pokemons', favorites);
    } catch (e) {
      throw e;
    }
  }

  Future<Pokemon> fetchPokemon(String number) async {
    try {
      final response =
          await http.get(Uri.parse(ApiConstants.pokemonDetails(number)));

      return Pokemon.fromJson(
          jsonDecode(Utf8Decoder().convert(response.body.codeUnits)));
    } catch (e) {
      throw e;
    }
  }
}
