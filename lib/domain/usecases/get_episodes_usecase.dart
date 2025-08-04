import 'package:desafio_fteam/domain/entities/episode_entity.dart';
import 'package:desafio_fteam/domain/repositories/i_ram_repository.dart';

class GetEpisodesUseCase {
  final IRamRepository repository;
  GetEpisodesUseCase(this.repository);

  Future<List<EpisodeEntity>> call({
    int page = 1,
    Map<String, String>? filters,
  }) {
    return repository.getEpisodes(page: page, filters: filters);
  }
}
