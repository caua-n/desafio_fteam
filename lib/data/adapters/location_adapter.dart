import 'package:desafio_fteam/domain/entities/location_entity.dart';

class LocationAdapter {
  static LocationEntity fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      residents: List<String>.from(json['residents']),
      url: json['url'],
      created: DateTime.parse(json['created']),
    );
  }
}