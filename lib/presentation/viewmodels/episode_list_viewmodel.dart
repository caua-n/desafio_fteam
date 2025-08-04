import 'package:desafio_fteam/domain/entities/episode_entity.dart';
import 'package:desafio_fteam/domain/usecases/get_episodes_usecase.dart';
import 'package:flutter/material.dart';

class EpisodeListViewModel extends ChangeNotifier {
  final GetEpisodesUseCase getEpisodesUseCase;

  EpisodeListViewModel({required this.getEpisodesUseCase});

  final List<EpisodeEntity> _episodes = [];
  List<EpisodeEntity> get episodes => List.unmodifiable(_episodes);

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadEpisodes({bool loadMore = false}) async {
    if (_isLoading) return;
    if (!loadMore) {
      // resetar tudo
      _page = 1;
      _hasMore = true;
      _episodes.clear();
    } else if (!_hasMore) {
      return; // não carrega mais se não tiver páginas
    }

    _isLoading = true;
    notifyListeners();

    try {
      // assumindo que o usecase aceita page opcional
      final List<EpisodeEntity> result = await getEpisodesUseCase(page: _page);

      // adiciona itens (ou insere fresh)
      _episodes.addAll(result);

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
      }
    } catch (e) {
      _hasMore = false;
      // opcional: armazenar erro em uma variável para exibir UI
    }

    _isLoading = false;
    notifyListeners();
  }
}
