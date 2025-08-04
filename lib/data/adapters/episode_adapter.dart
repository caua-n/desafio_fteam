import 'package:desafio_fteam/domain/entities/episode_entity.dart';

class EpisodeAdapter {
  static EpisodeEntity fromJson(Map<String, dynamic> json) {
    return EpisodeEntity(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      characters: List<String>.from(json['characters']),
      url: json['url'],
      created: DateTime.parse(json['created']),
    );
  }
}
