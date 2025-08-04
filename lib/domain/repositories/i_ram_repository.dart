import '../../domain/entities/character_entity.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/entities/location_entity.dart';

abstract class IRamRepository {
  Future<List<CharacterEntity>> getCharacters({
    int page,
    Map<String, String>? filters,
  });
  Future<CharacterEntity> getCharacterById(int id);

  Future<List<EpisodeEntity>> getEpisodes({
    int page,
    Map<String, String>? filters,
  });
  Future<EpisodeEntity> getEpisodeById(int id);

  Future<List<LocationEntity>> getLocations({
    int page,
    Map<String, String>? filters,
  });
  Future<LocationEntity> getLocationById(int id);
}
