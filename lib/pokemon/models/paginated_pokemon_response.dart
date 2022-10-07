import 'package:freezed_annotation/freezed_annotation.dart';
part 'paginated_pokemon_response.g.dart';
part 'paginated_pokemon_response.freezed.dart';

@freezed
class PaginatedResponse with _$PaginatedResponse {
  const factory PaginatedResponse({
    required int count,
    String? next,
    String? previous,
    @Default([]) List<PokemonResponse> results,
  }) = _PaginatedResponse;

  factory PaginatedResponse.fromJson(Map<String, Object?> json) =>
      _$PaginatedResponseFromJson(json);
}

@freezed
class PokemonResponse with _$PokemonResponse {
  const factory PokemonResponse({
    required String name,
    required String url,
  }) = _PokemonResponse;
  factory PokemonResponse.fromJson(Map<String, Object?> json) =>
      _$PokemonResponseFromJson(json);
}
