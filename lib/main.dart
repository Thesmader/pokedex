import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/home/home.dart';
import 'package:pokedex/pokemon/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(PokedexApp(preferences: prefs));
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key, required this.preferences});
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        favouritePokemonProvider.overrideWithProvider(
          StateNotifierProvider(
            (ref) {
              final state = preferences.getStringList('favourites');
              return FavouritePokemon(state ?? [], preferences);
            },
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeView(),
          '/detail': (context) => const PokemonDetailView(),
        },
      ),
    );
  }
}
