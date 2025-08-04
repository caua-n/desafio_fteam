import 'package:desafio_fteam/domain/entities/episode_entity.dart';
import 'package:desafio_fteam/domain/repositories/i_ram_repository.dart';

class GetEpisodeByIdUseCase {
  final IRamRepository repository;
  GetEpisodeByIdUseCase(this.repository);

  Future<EpisodeEntity> call(int id) {
    return repository.getEpisodeById(id);
  }
}
