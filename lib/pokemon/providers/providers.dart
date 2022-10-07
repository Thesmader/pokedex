import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/pokemon/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => HttpPokemonRepository(),
);

final pokemonProvider = FutureProvider.family((ref, int page) async {
  final pokemonRepository = ref.watch(pokemonRepositoryProvider);
  return pokemonRepository.getPokemon(page: page);
});

final resolvedPokemonProvider = Provider.family((ref, int page) {
  return ref.watch(pokemonProvider(page).future).then((pokemonPage) {
    return pokemonPage.results
        .map((_) => _.url)
        .map((_) => pokemonDetailsProvider(_))
        .toList();
  });
});

final pokemonDetailsProvider = FutureProvider.family(
  (ref, String url) {
    final pokemonRepository = ref.watch(pokemonRepositoryProvider);
    return pokemonRepository.getPokemonDetails(url: url);
  },
);

final totalCountProvider = Provider(
  (ref) => ref
      .watch(pokemonProvider(0))
      .whenData((paginatedResponse) => paginatedResponse.count),
);

final favouritePokemonProvider =
    StateNotifierProvider<FavouritePokemon, List<String>>((_) {
  throw UnimplementedError();
});

class FavouritePokemon extends StateNotifier<List<String>> {
  FavouritePokemon(super.state, this._preferences);
  final SharedPreferences _preferences;

  void addFavourite(String url) {
    state = [...state, url];
    _preferences.setStringList('favourites', state);
  }

  void removeFavourite(String url) {
    state = [...state]..remove(url);
    _preferences.setStringList('favourites', state);
  }

  bool isFavourite(String url) => state.contains(url);
}
