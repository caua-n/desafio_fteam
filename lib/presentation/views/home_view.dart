import 'package:desafio_fteam/domain/entities/episode_entity.dart';
import 'package:desafio_fteam/domain/entities/location_entity.dart';
import 'package:desafio_fteam/domain/enums/character_status_enum.dart';
import 'package:desafio_fteam/presentation/viewmodels/character_list_viewmodel.dart';
import 'package:desafio_fteam/presentation/viewmodels/episode_list_viewmodel.dart';
import 'package:desafio_fteam/presentation/viewmodels/location_list_viewmodel.dart';
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
  final ScrollController _characterScrollController = ScrollController();
  final ScrollController _episodeScrollController = ScrollController();
  final ScrollController _locationScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CharacterListViewModel>().loadCharacters();
      context.read<EpisodeListViewModel>().loadEpisodes();
      context.read<LocationListViewModel>().loadLocations();
    });
    final viewModel = context.read<CharacterListViewModel>();

    _searchController.addListener(() {
      final text = _searchController.text;
      if (text.isEmpty) {
        viewModel.loadCharacters(query: '', loadMore: false);
      }
    });

    _characterScrollController.addListener(() {
      final vm = context.read<CharacterListViewModel>();
      final query = _searchController.text;

      if (!vm.isSearchEmpty &&
          vm.hasMore &&
          _characterScrollController.position.pixels >=
              _characterScrollController.position.maxScrollExtent - 300) {
        vm.loadCharacters(query: query, loadMore: true);
      }
    });

    _episodeScrollController.addListener(() {
      final epVM = context.read<EpisodeListViewModel>();
      if (_episodeScrollController.position.pixels >=
              _episodeScrollController.position.maxScrollExtent - 300 &&
          epVM.hasMore) {
        epVM.loadEpisodes(loadMore: true);
      }
    });

    _locationScrollController.addListener(() {
      final locVM = context.read<LocationListViewModel>();
      if (_locationScrollController.position.pixels >=
              _locationScrollController.position.maxScrollExtent - 300 &&
          locVM.hasMore) {
        locVM.loadLocations(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _characterScrollController.dispose();
    _episodeScrollController.dispose();
    _locationScrollController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    context.read<CharacterListViewModel>().loadCharacters(
      query: query,
      loadMore: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final characterVM = context.watch<CharacterListViewModel>();
    final episodeVM = context.watch<EpisodeListViewModel>();
    final locationVM = context.watch<LocationListViewModel>();

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _characterScrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: true,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              expandedHeight: 200.0,
              toolbarHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: _onSearch,
                    decoration: InputDecoration(
                      hintText: 'Buscar personagem...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearch('');
                                FocusScope.of(context).unfocus();
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Episódios',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      controller: _episodeScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: episodeVM.episodes.length,
                      itemBuilder: (context, index) {
                        final EpisodeEntity episode = episodeVM.episodes[index];
                        return Card(
                          color: Colors.lightGreen.shade100,
                          margin: const EdgeInsets.only(left: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode.name,
                                  style: TextStyle(
                                    color: Color(0xff24325f),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  episode.episode,
                                  style: TextStyle(color: Color(0xff24325f)),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 16,
                                      color: Color(0xff24325f),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      episode.airDate,
                                      style: TextStyle(
                                        color: Color(0xff24325f),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Localizações',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      controller: _locationScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationVM.locations.length,
                      itemBuilder: (context, index) {
                        final LocationEntity location =
                            locationVM.locations[index];
                        return Card(
                          color: Colors.lightGreen.shade300,
                          margin: const EdgeInsets.only(left: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location.name,
                                  style: TextStyle(
                                    color: Color(0xff24325f),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  location.type,
                                  style: TextStyle(color: Color(0xff24325f)),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.place_rounded,
                                      size: 16,
                                      color: Color(0xff24325f),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      location.dimension,
                                      style: TextStyle(
                                        color: Color(0xff24325f),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  'Personagens',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (characterVM.characters.isEmpty &&
                _searchController.text.isNotEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nenhum personagem encontrado!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: Image.asset(
                            'assets/gifs/rickandmortypixel.gif',
                            filterQuality: FilterQuality.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final character = characterVM.characters[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        tileColor: Colors.lightGreen.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            color: Color.fromARGB(255, 0, 78, 0),
                            padding: const EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(character.image),
                            ),
                          ),
                        ),
                        title: Text(
                          character.name,
                          style: TextStyle(
                            color: Color(0xff24325f),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                            Text(
                              _getStatusLabel(character.status),
                              style: TextStyle(color: Color(0xff24325f)),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.info_outline,
                          color: Color(0xff24325f),
                        ),
                        onTap: () {
                          context.push('/character/${character.id}');
                        },
                      ),
                    );
                  }, childCount: characterVM.characters.length),
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
      return Color.fromARGB(255, 17, 4, 104);
    case CharacterStatus.dead:
      return const Color.fromARGB(255, 207, 57, 2);
    case CharacterStatus.unknown:
    default:
      return const Color.fromARGB(255, 74, 74, 74);
  }
}
