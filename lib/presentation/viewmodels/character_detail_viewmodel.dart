import 'package:desafio_fteam/domain/entities/character_entity.dart';
import 'package:desafio_fteam/domain/usecases/get_character_by_id_usecase.dart';
import 'package:flutter/material.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final GetCharacterByIdUseCase getCharacterByIdUseCase;
  final int characterId;

  CharacterDetailViewModel(this.getCharacterByIdUseCase, this.characterId);

  CharacterEntity? _character;
  CharacterEntity? get character => _character;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadCharacter() async {
    _isLoading = true;
    notifyListeners();

    try {
      _character = await getCharacterByIdUseCase(characterId);
    } catch (_) {
      _character = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
