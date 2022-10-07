import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/all_pokemon/view/all_pokemon_view.dart';
import 'package:pokedex/pokemon/favourite_pokemon/favourite_pokemon_view.dart';
import 'package:pokedex/pokemon/pokemon.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritesCount = ref.watch(favouritePokemonProvider).length;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFE8E8E8),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/pokeball.png'),
                const SizedBox(width: 8),
                const Text(
                  'Pokedex',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xFF161A33),
                  ),
                ),
              ],
            ),
            elevation: 0,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              indicatorWeight: 4,
              tabs: [
                const Tab(text: 'All Pokemon'),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Favourites'),
                      if (favouritesCount > 0)
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Text(favouritesCount.toString()),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AllPokemonView(),
              FavouritePokemonView(),
            ],
          ),
        ),
      ),
    );
  }
}
