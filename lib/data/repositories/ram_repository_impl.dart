import '../../domain/entities/character_entity.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/i_ram_repository.dart';
import '../adapters/character_adapter.dart';
import '../adapters/episode_adapter.dart';
import '../adapters/location_adapter.dart';
import '../datasources/ram_remote_datasource.dart';

class RamRepositoryImpl implements IRamRepository {
  final RamRemoteDatasource datasource;

  RamRepositoryImpl(this.datasource);

  @override
  Future<List<CharacterEntity>> getCharacters({int page = 1, Map<String, String>? filters}) async {
    final result = await datasource.getCharacters(page: page, filters: filters);
    return result.map(CharacterAdapter.fromJson).toList();
  }

  @override
  Future<CharacterEntity> getCharacterById(int id) async {
    final result = await datasource.getCharacterById(id);
    return CharacterAdapter.fromJson(result);
  }

  @override
  Future<List<EpisodeEntity>> getEpisodes({int page = 1, Map<String, String>? filters}) async {
    final result = await datasource.getEpisodes(page: page, filters: filters);
    return result.map(EpisodeAdapter.fromJson).toList();
  }

  @override
  Future<EpisodeEntity> getEpisodeById(int id) async {
    final result = await datasource.getEpisodeById(id);
    return EpisodeAdapter.fromJson(result);
  }

  @override
  Future<List<LocationEntity>> getLocations({int page = 1, Map<String, String>? filters}) async {
    final result = await datasource.getLocations(page: page, filters: filters);
    return result.map(LocationAdapter.fromJson).toList();
  }

  @override
  Future<LocationEntity> getLocationById(int id) async {
    final result = await datasource.getLocationById(id);
    return LocationAdapter.fromJson(result);
  }
}