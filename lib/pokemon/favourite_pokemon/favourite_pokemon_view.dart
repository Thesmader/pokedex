import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/pokemon/pokemon.dart';

class FavouritePokemonView extends ConsumerWidget {
  const FavouritePokemonView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouritePokemonProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
          key: const PageStorageKey('favourite-pokemon-grid'),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 186,
            mainAxisSpacing: 20,
          ),
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            final favourite = favourites[index];
            final pokemonValue = ref.watch(
              pokemonDetailsProvider(favourite),
            );
            return pokemonValue.when(
              data: (pokemon) {
                return PokemonCard(
                    pokemon: pokemon,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/detail',
                        arguments: favourite,
                      );
                    });
              },
              error: (error, st) => const Center(
                child: Text('Failed to load favourite pokemon'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
