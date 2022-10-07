import 'package:freezed_annotation/freezed_annotation.dart';
part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const Pokemon._();
  const factory Pokemon({
    required Species species,
    @Default([]) List<TypeSlot> types,
    required List<StatData> stats,
    required Map<String, Object?> sprites,
    required int height,
    required int weight,
    required int id,
  }) = _Pokemon;
  factory Pokemon.fromJson(Map<String, Object?> json) =>
      _$PokemonFromJson(json);

  String get spriteUrl =>
      ((sprites['other']! as Map<String, Object?>)['official-artwork']!
          as Map<String, Object?>)['front_default'] as String;

  int get averagePower =>
      stats.fold(0, (acc, statData) => acc + statData.baseStat) ~/ 6;
}

@freezed
class Species with _$Species {
  const factory Species({
    required String name,
  }) = _Species;
  factory Species.fromJson(Map<String, Object?> json) =>
      _$SpeciesFromJson(json);
}

@freezed
class StatData with _$StatData {
  const factory StatData({
    @JsonKey(name: 'base_stat') required int baseStat,
    required Stat stat,
  }) = _StatData;
  factory StatData.fromJson(Map<String, Object?> json) =>
      _$StatDataFromJson(json);
}

@freezed
class Stat with _$Stat {
  const factory Stat(String name) = _Stat;
  factory Stat.fromJson(Map<String, Object?> json) => _$StatFromJson(json);
}

@freezed
class Sprites with _$Sprites {
  const factory Sprites() = _Sprites;
  factory Sprites.fromJson(Map<String, Object?> json) =>
      _$SpritesFromJson(json);
}

@freezed
class TypeSlot with _$TypeSlot {
  const factory TypeSlot({
    required TypeData type,
  }) = _TypeSlot;
  factory TypeSlot.fromJson(Map<String, Object?> json) =>
      _$TypeSlotFromJson(json);
}

@freezed
class TypeData with _$TypeData {
  const factory TypeData({
    required String name,
  }) = _TypeData;
  factory TypeData.fromJson(Map<String, Object?> json) =>
      _$TypeDataFromJson(json);
}
