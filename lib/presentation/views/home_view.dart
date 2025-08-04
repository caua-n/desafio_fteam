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
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final vm = context.read<CharacterListViewModel>();
    vm.loadCharacters();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          vm.loadCharacters(loadMore: true);
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementar tela de busca futuramente
            },
          )
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= vm.characters.length) {
                  return vm.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : null;
                }
                final character = vm.characters[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(character.image)),
                  title: Text(character.name),
                  subtitle: Text(character.status.name),
                  onTap: () => context.push('/character/${character.id}'),
                );
              },
              childCount: vm.characters.length + (vm.isLoading ? 1 : 0),
            ),
          ),
        ],
      ),
    );
  }
}
