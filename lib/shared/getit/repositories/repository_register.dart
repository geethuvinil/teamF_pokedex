import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/shared/repositories/item_repository.dart';
import 'package:app/shared/repositories/pokemon_repository.dart';

class RepositoryRegister extends IGetItRegister {
  @override
  void register() {
    GetIt getIt = GetIt.instance;

    if (!GetIt.I.isRegistered<PokemonRepository>()) {
      getIt.registerSingleton<PokemonRepository>(PokemonRepository());
    }

    if (!GetIt.I.isRegistered<ItemRepository>()) {
      getIt.registerSingleton<ItemRepository>(ItemRepository(Dio()));
    }
  }
}
