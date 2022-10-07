import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/pokemon/pokemon.dart';
import 'package:stringr/stringr.dart';

const _tableDataStyle = TextStyle(fontSize: 14);
const _tableHeaderStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Color(0xFF6B6B6B),
);

class PokemonDetailView extends ConsumerWidget {
  const PokemonDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonUrl = ModalRoute.of(context)!.settings.arguments! as String;
    final pokemonData = ref.watch(pokemonDetailsProvider(pokemonUrl));
    final favouriteNotifier = ref.read(favouritePokemonProvider.notifier);
    final favouritesState = ref.watch(favouritePokemonProvider);
    final isFavourite = favouritesState.contains(pokemonUrl);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (!isFavourite) {
              favouriteNotifier.addFavourite(pokemonUrl);
            } else {
              favouriteNotifier.removeFavourite(pokemonUrl);
            }
          },
          backgroundColor: isFavourite ? Colors.indigo.shade100 : Colors.indigo,
          label: isFavourite
              ? const Text(
                  'Remove from favourites',
                  style: TextStyle(
                    color: Colors.indigo,
                  ),
                )
              : const Text('Mark as favourite'),
        ),
        body: pokemonData.when(
          data: (pokemon) {
            final bmi = pokemon.weight / (pokemon.height * pokemon.height);
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: FractionallySizedBox(
                              heightFactor: 0.5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pokemon.species.name.titleCase(),
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      pokemon.types
                                          .map((typeData) =>
                                              typeData.type.name.titleCase())
                                          .join(', '),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '#${pokemon.id.toString().padLeft(4, '0')}',
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 10,
                            child: Hero(
                              tag: 'img-hero-${pokemon.id}',
                              child: CachedNetworkImage(
                                imageUrl: pokemon.spriteUrl,
                                height: 125,
                                width: 125,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Table(
                        children: [
                          const TableRow(children: [
                            TableCell(
                              child: Text(
                                'Height',
                                style: _tableHeaderStyle,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Weight',
                                style: _tableHeaderStyle,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'BMI',
                                style: _tableHeaderStyle,
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            TableCell(
                              child: Text(
                                pokemon.height.toString(),
                                style: _tableDataStyle,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                pokemon.weight.toString(),
                                style: _tableDataStyle,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                bmi.toStringAsFixed(1),
                                style: _tableDataStyle,
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 12,
                  ),
                ),
                SliverToBoxAdapter(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Base Stats',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(),
                          ...pokemon.stats.map((statData) {
                            final statName = statData.stat.name
                                .snakeCase()
                                .split('_')
                                .join(' ')
                                .titleCase();
                            return StatUI(
                              title: statName,
                              value: statData.baseStat,
                            );
                          }).toList(),
                          StatUI(
                            title: 'Avg. Power',
                            value: pokemon.averagePower,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, st) => const Center(
            child: Text('Failed to load pokemon'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
