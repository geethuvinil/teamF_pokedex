import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/evolution/widgets/empty_evolution_chain.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/evolution/widgets/next_evolution_chain.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/evolution/widgets/previous_evolution_chain.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/evolution/widgets/super_evolution_chain.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/utils/evolution_chain_utils.dart';

import '../../pokemon_mobile_panel.dart';

class EvolutionPage extends StatelessWidget {
  static final _pokemonStore = GetIt.instance<PokemonStore>();

  const EvolutionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final horizontalPadding = getDetailsPanelsPadding(size);

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      child: Observer(builder: (_) {
        final evolutionChain =
            EvolutionChainUtils.buildEvolutionChain(_pokemonStore.pokemon!);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_pokemonStore.pokemon!.previousEvolutions.isNotEmpty)
              PreviousEvolutionChainWidget(evolutionChain: evolutionChain),
            if (_pokemonStore.pokemon!.nextEvolutions.isNotEmpty)
              NextEvolutionChainWidget(evolutionChain: evolutionChain),
            if (_pokemonStore.pokemon!.superEvolutions.isNotEmpty)
              SuperEvolutionChainWidget(),
            if (!_pokemonStore.pokemon!.hasEvolutions)
              EmptyEvolutionChainWidget(),
            SizedBox(
              height: 100,
            )
          ],
        );
      }),
    );
  }
}
