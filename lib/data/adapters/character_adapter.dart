import 'package:desafio_fteam/domain/entities/character_entity.dart';
import 'package:desafio_fteam/domain/entities/character_location_entity.dart';
import 'package:desafio_fteam/domain/enums/character_especies_enum.dart';
import 'package:desafio_fteam/domain/enums/character_genders_enum.dart';
import 'package:desafio_fteam/domain/enums/character_status_enum.dart';

class CharacterAdapter {
  static CharacterEntity fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      id: json['id'],
      name: json['name'],
      status: CharacterStatusExtension.fromString(json['status']),
      species: CharacterSpeciesExtension.fromString(json['species']),
      gender: CharacterGendersExtension.fromString(json['gender']),
      type: json['type'] ?? '',
      image: json['image'],
      url: json['url'],
      episodes: List<String>.from(json['episode']),
      origin: CharacterLocationEntity(
        name: json['origin']['name'],
        url: json['origin']['url'],
      ),
      location: CharacterLocationEntity(
        name: json['location']['name'],
        url: json['location']['url'],
      ),
      created: DateTime.parse(json['created']),
    );
  }
}