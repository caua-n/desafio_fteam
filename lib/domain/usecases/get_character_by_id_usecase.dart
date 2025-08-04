import 'package:desafio_fteam/domain/entities/character_entity.dart';
import 'package:desafio_fteam/domain/repositories/i_ram_repository.dart';

class GetCharacterByIdUseCase {
  final IRamRepository repository;
  GetCharacterByIdUseCase(this.repository);

  Future<CharacterEntity> call(int id) {
    return repository.getCharacterById(id);
  }
}