import 'package:desafio_fteam/domain/entities/location_entity.dart';
import 'package:desafio_fteam/domain/repositories/i_ram_repository.dart';

class GetLocationByIdUseCase {
  final IRamRepository repository;
  GetLocationByIdUseCase(this.repository);

  Future<LocationEntity> call(int id) {
    return repository.getLocationById(id);
  }
}
