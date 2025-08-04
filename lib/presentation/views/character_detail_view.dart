import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/character_detail_viewmodel.dart';

class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterDetailViewModel>();
    final character = vm.character;

    return Scaffold(
      appBar: AppBar(title: Text(character?.name ?? 'Personagem')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : character == null
              ? const Center(child: Text('Personagem não encontrado.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(character.image, height: 200),
                      ),
                      const SizedBox(height: 16),
                      Text('Nome: ${character.name}'),
                      Text('Status: ${character.status.name}'),
                      Text('Espécie: ${character.species.name}'),
                      Text('Gênero: ${character.gender.name}'),
                      Text('Origem: ${character.origin.name}'),
                      Text('Localização: ${character.location.name}'),
                    ],
                  ),
                ),
    );
  }
}
