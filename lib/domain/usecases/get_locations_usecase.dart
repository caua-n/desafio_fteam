import 'package:desafio_fteam/domain/entities/location_entity.dart';
import 'package:desafio_fteam/domain/repositories/i_ram_repository.dart';

class GetLocationsUseCase {
  final IRamRepository repository;
  GetLocationsUseCase(this.repository);

  Future<List<LocationEntity>> call({
    int page = 1,
    Map<String, String>? filters,
  }) {
    return repository.getLocations(page: page, filters: filters);
  }
}
