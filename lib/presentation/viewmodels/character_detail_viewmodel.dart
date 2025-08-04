import 'package:flutter/material.dart';

import '../../../domain/entities/character_entity.dart';
import '../../../domain/usecases/get_character_by_id_usecase.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final GetCharacterByIdUseCase _getCharacterByIdUseCase;
  final int characterId;

  CharacterDetailViewModel(this._getCharacterByIdUseCase, this.characterId);

  CharacterEntity? _character;
  CharacterEntity? get character => _character;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadCharacter() async {
    _isLoading = true;
    notifyListeners();

    try {
      _character = await _getCharacterByIdUseCase(characterId);
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }
}
