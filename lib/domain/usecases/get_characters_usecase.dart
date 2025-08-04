import 'package:desafio_fteam/domain/entities/character_entity.dart';
import 'package:desafio_fteam/domain/repositories/i_ram_repository.dart';

class GetCharactersUseCase {
  final IRamRepository repository;
  GetCharactersUseCase(this.repository);

  Future<List<CharacterEntity>> call({int page = 1, Map<String, String>? filters}) {
    return repository.getCharacters(page: page, filters: filters);
  }
}