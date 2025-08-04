import 'package:desafio_fteam/presentation/viewmodels/character_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharacterDetailViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Personagem')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.character == null
          ? const Center(child: Text('Personagem não encontrado.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(viewModel.character!.image),
                  Text(
                    viewModel.character!.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Status: ${viewModel.character!.status.name}'),
                  Text('Espécie: ${viewModel.character!.species.name}'),
                  Text('Gênero: ${viewModel.character!.gender.name}'),
                  Text('Origem: ${viewModel.character!.origin.name}'),
                ],
              ),
            ),
    );
  }
}
