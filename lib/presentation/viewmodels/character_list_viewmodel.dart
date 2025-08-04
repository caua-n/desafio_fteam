import 'package:flutter/material.dart';

import '../../../domain/entities/character_entity.dart';
import '../../../domain/usecases/get_characters_usecase.dart';
class CharacterListViewModel extends ChangeNotifier {
  final GetCharactersUseCase getCharactersUseCase;

  CharacterListViewModel({required this.getCharactersUseCase});

  List<CharacterEntity> _characters = [];
  List<CharacterEntity> get characters => _characters;

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  Future<void> loadCharacters({bool loadMore = false, String? query}) async {
    if (_isLoading || (!_hasMore && loadMore)) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newCharacters = await getCharactersUseCase(
        page: _page,
        filters: query != null ? {'name': query} : null,
      );
      if (loadMore) {
        _characters.addAll(newCharacters);
      } else {
        _characters = newCharacters;
      }
      if (newCharacters.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
      }
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }
}