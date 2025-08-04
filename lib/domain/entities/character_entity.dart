
import 'package:desafio_fteam/domain/entities/character_location_entity.dart';
import 'package:desafio_fteam/domain/enums/character_especies_enum.dart';
import 'package:desafio_fteam/domain/enums/character_genders_enum.dart';
import 'package:desafio_fteam/domain/enums/character_status_enum.dart';

class CharacterEntity {
  final int id;
  final String name;
  final CharacterStatus status;
  final CharacterSpecies species;
  final CharacterGenders gender;
  final String type;
  final String image;
  final String url;
  final List<String> episodes;
  final CharacterLocationEntity origin;
  final CharacterLocationEntity location;
  final DateTime created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.type,
    required this.image,
    required this.url,
    required this.episodes,
    required this.origin,
    required this.location,
    required this.created,
  });
}
