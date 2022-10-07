import 'package:dio/dio.dart';
import 'package:pokedex/pokemon/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PokemonRepository {
  Future<PaginatedResponse> getPokemon({required int page});
  Future<Pokemon> getPokemonDetails({required String url});
}

const _pageSize = 20;

class HttpPokemonRepository implements PokemonRepository {
  HttpPokemonRepository() {
    init();
  }
  final _dio = Dio();
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setStringList('favourite-ids', []);
  }

  @override
  Future<PaginatedResponse> getPokemon({required int page}) async {
    final response =
        await _dio.get('https://pokeapi.co/api/v2/pokemon', queryParameters: {
      'limit': _pageSize,
      'offset': _pageSize * page,
    });
    return PaginatedResponse.fromJson(response.data);
  }

  @override
  Future<Pokemon> getPokemonDetails({required String url}) async {
    final response = await _dio.get(url);
    return Pokemon.fromJson(response.data);
  }
}
