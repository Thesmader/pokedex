# Pokedex
Pokedex flutter application built using [PokeAPI](https://pokeapi.co)

## Running the application
- Clone this repository
- Run `flutter pub get`
- Run `flutter pub run build_runner build`
- Run the app using your IDE of `flutter run`

## Explanation of pokemonDetailsProvider logic (To see the providers go to lib/pokemon/providers/providers.dart)
- `pokemonProvider` fetches a page of pokemon from API based on the `index` argument
- the `/pokemon` endpoint just gives a list of objects with pokemon name and the `url` for fetching details. To show the UI I need images as well which will fetched from the `url` in each object.
- To tackle the above problem `resolvedPokemonProvider` uses `pokemonProvider` under the hood and maps the result from `pokemonProvider` to a list of `pokemonDetailsProvider`
- `pokemonDetailsProvider` is a `FutureProvider` responsible for fetching the details of a pokemon, given the `url` as an argument
- In the grid UI each item listens to their corresponding `pokemonDetailsProvider` to render the UI according to the value of the provider

## References
- Code snippets
    - Pagination logic inspired from Roaa94's [movies_app](https://github.com/Roaa94/movies_app/blob/1ad17b00b1e16cd2d545977c2b615cfeeeac4c5c/lib/features/people/views/widgets/popular_people_list.dart#L31)

- [Riverpod documentation](https://riverpod.dev)
