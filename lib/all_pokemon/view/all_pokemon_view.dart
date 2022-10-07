import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/pokemon/pokemon.dart';

class AllPokemonView extends ConsumerWidget {
  const AllPokemonView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCount = ref.watch(totalCountProvider);

    return totalCount.when(
      data: (count) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          key: const PageStorageKey('all-pokemon-grid'),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 186,
            mainAxisSpacing: 20,
          ),
          itemCount: count,
          itemBuilder: (context, index) {
            final pokemonValue = ref
                .watch(resolvedPokemonProvider(index ~/ 20))
                .then((pokemonProviders) => pokemonProviders[index % 20]);

            return FutureBuilder(
                future: pokemonValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final pokemon = ref.watch(snapshot.data!);
                    return pokemon.when(
                      data: (pok) {
                        return PokemonCard(
                            pokemon: pok,
                            onTap: () {
                              Navigator.of(context).pushNamed('/detail',
                                  arguments: snapshot.data!.argument);
                            });
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const Icon(Icons.error_outline_rounded),
                    );
                  }
                  return const SizedBox.shrink();
                });
          },
        ),
      ),
      error: (error, st) => const Text('Failed to load pokemon'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
