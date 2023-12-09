import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/evolution/widgets/evolution_chain_item.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';

class PreviousEvolutionChainWidget extends StatelessWidget {
  final PokemonStore _pokemonStore = GetIt.instance<PokemonStore>();

  final List<EvolutionChainItemWidget> evolutionChain;

  PreviousEvolutionChainWidget({Key? key, required this.evolutionChain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          "Previous Evolution${_pokemonStore.pokemon!.previousEvolutions.length > 1 ? "s" : ""}",
          style: textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
        ),
        ...evolutionChain
            .where((element) =>
                element.previousEvolution.type.index
                    .compareTo(_pokemonStore.pokemon!.evolutionType.index) ==
                -1)
            .toList(),
      ],
    );
  }
}
