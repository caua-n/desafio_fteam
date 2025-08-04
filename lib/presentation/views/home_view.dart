import 'package:desafio_fteam/domain/enums/character_status_enum.dart';
import 'package:desafio_fteam/presentation/viewmodels/character_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        context.read<CharacterListViewModel>().loadCharacters();
      }
    });

    Future.microtask(() {
      context.read<CharacterListViewModel>().loadCharacters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    context.read<CharacterListViewModel>().loadCharacters(query: query);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharacterListViewModel>();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personagens'),
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                onSubmitted: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Buscar personagem...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _onSearch('');
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (viewModel.characters.isEmpty &&
                      _searchController.text.isNotEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '🛸 Nenhum personagem encontrado!\nMorty provavelmente apertou o botão errado de novo...',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final character = viewModel.characters[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(character.image),
                            ),
                            title: Text(character.name),
                            subtitle: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(character.status),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(_getStatusLabel(character.status)),
                              ],
                            ),
                            onTap: () {
                              context.push('/character/${character.id}');
                            },
                          );
                        }, childCount: viewModel.characters.length),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getStatusLabel(CharacterStatus status) {
  switch (status) {
    case CharacterStatus.alive:
      return 'Vivinho da Silva';
    case CharacterStatus.dead:
      return 'Foi de base';
    case CharacterStatus.unknown:
    default:
      return _getRandomUnknownLabel();
  }
}

String _getRandomUnknownLabel() {
  final options = [
    'Desconhecido até para o Rick',
    'Fora do alcance do portal',
    'Paradoxo ambulante',
    'Nem o Conselho dos Ricks sabe',
    'Glitch na Matrix',
    'Transcendeu o espaço-tempo',
    'Morreu... quem dera',
    'Entidade fora do cânone',
    'NPC perdido no multiverso',
  ];
  options.shuffle();
  return options.first;
}

Color _getStatusColor(CharacterStatus status) {
  switch (status) {
    case CharacterStatus.alive:
      return Colors.green;
    case CharacterStatus.dead:
      return Colors.red;
    case CharacterStatus.unknown:
    default:
      return Colors.grey;
  }
}
