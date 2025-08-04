import 'package:flutter/material.dart';

import '../../../domain/entities/character_entity.dart';
import '../../../domain/usecases/get_characters_usecase.dart';

class CharacterListViewModel extends ChangeNotifier {
  final GetCharactersUseCase getCharactersUseCase;

  CharacterListViewModel({required this.getCharactersUseCase});

  String _lastQuery = '';
  List<CharacterEntity> _characters = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isSearchEmpty = false;

  bool get hasMore => _hasMore;
  bool get isSearchEmpty => _isSearchEmpty;
  List<CharacterEntity> get characters => _characters;

  Future<void> loadCharacters({
    String query = '',
    bool loadMore = false,
  }) async {
    // Se já estiver carregando ou sem mais páginas, interrompe
    if (_isLoading || (!_hasMore && loadMore)) return;

    // Se for nova busca (loadMore == false), reseta tudo
    if (!loadMore) {
      _lastQuery = query;
      _characters = [];
      _page = 1;
      _hasMore = true;
      _isSearchEmpty = false;
      notifyListeners();
    }

    _isLoading = true;
    notifyListeners();

    try {
      final filters = _lastQuery.isNotEmpty ? {'name': _lastQuery} : null;
      final newCharacters = await getCharactersUseCase(
        page: _page,
        filters: filters,
      );

      if (newCharacters.isEmpty) {
        if (!loadMore) {
          // busca vazia
          _isSearchEmpty = true;
        }
        _hasMore = false;
      } else {
        _characters.addAll(newCharacters);
        _page++;
      }
    } catch (_) {
      // trate erros aqui, se quiser
    }

    _isLoading = false;
    notifyListeners();
  }
}
