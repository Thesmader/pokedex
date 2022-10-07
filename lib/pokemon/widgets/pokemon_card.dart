import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokemon/pokemon.dart';
import 'package:stringr/stringr.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
    required this.onTap,
  }) : super(key: key);

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final types = pokemon.types
        .map((typeSlot) => typeSlot.type.name.titleCase())
        .join(', ');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Hero(
                tag: 'img-hero-${pokemon.id}',
                child: CachedNetworkImage(
                  height: 100,
                  imageUrl: pokemon.spriteUrl,
                ),
              ),
            ),
            Text(
              '#${pokemon.id.toString().padLeft(4, '0')}',
            ),
            Text(
              pokemon.species.name.titleCase(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              types,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
