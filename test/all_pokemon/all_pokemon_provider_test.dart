import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/pokemon/pokemon.dart';

import '../mocks/mocks.dart';

void main() {
  final mockPokemonRepository = MockPokemonRepository();

  setUp(
    () {
      when(() => mockPokemonRepository.getPokemon(page: 1)).thenAnswer(
        (_) async => const PaginatedResponse(count: 10),
      );
      when(() => mockPokemonRepository.getPokemon(page: 2)).thenAnswer(
        (_) async => const PaginatedResponse(count: 100),
      );
    },
  );

  testWidgets('Future state is preserved across widgets', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
        ],
        child: const MaterialApp(
          home: PokeWidget(),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Success'), findsOneWidget);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
        ],
        child: const MaterialApp(
          home: Poke2Widget(),
        ),
      ),
    );
    expect(find.text('Loading'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Success'), findsOneWidget);
  });
}

class PokeWidget extends ConsumerWidget {
  const PokeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(pokemonProvider(1));
    return value.when(
      data: (data) => const Text('Success'),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}

class Poke2Widget extends ConsumerWidget {
  const Poke2Widget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(pokemonProvider(2));
    return value.when(
      data: (data) => const Text('Success'),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
