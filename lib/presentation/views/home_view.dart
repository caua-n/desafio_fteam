import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../viewmodels/character_list_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CharacterListViewModel>().loadCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharacterListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        actions: [
          IconButton(
            onPressed: () async {
              final query = await context.push<String>('/search');
              if (query != null) {
                context.read<CharacterListViewModel>().loadCharacters(query: query);
              }
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final character = viewModel.characters[index];
                return ListTile(
                  title: Text(character.name),
                  subtitle: Text(character.status.name),
                  onTap: () {
                    context.push('/character/${character.id}');
                  },
                );
              },
              childCount: viewModel.characters.length,
            ),
          ),
        ],
      ),
    );
  }
}