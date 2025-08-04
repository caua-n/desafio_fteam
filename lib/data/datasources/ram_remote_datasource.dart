import 'package:desafio_fteam/core/clients/rest/i_rest_client.dart';
import 'package:desafio_fteam/core/clients/rest/models/rest_client_request.dart';

class RamRemoteDatasource {
  final IRestClient client;

  RamRemoteDatasource(this.client);

  Future<List<Map<String, dynamic>>> getCharacters({
    int page = 1,
    Map<String, String>? filters,
  }) async {
    final query = {'page': '$page', ...?filters};
    final response = await client.get(
      RestClientRequest(path: '/character', queryParameters: query),
    );
    return List<Map<String, dynamic>>.from(response.data['results']);
  }

  Future<Map<String, dynamic>> getCharacterById(int id) async {
    final response = await client.get(
      RestClientRequest(path: '/character/$id'),
    );
    return Map<String, dynamic>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getEpisodes({
    int page = 1,
    Map<String, String>? filters,
  }) async {
    final query = {'page': '$page', ...?filters};
    final response = await client.get(
      RestClientRequest(path: '/episode', queryParameters: query),
    );
    return List<Map<String, dynamic>>.from(response.data['results']);
  }

  Future<Map<String, dynamic>> getEpisodeById(int id) async {
    final response = await client.get(RestClientRequest(path: '/episode/$id'));
    return Map<String, dynamic>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getLocations({
    int page = 1,
    Map<String, String>? filters,
  }) async {
    final query = {'page': '$page', ...?filters};
    final response = await client.get(
      RestClientRequest(path: '/location', queryParameters: query),
    );
    return List<Map<String, dynamic>>.from(response.data['results']);
  }

  Future<Map<String, dynamic>> getLocationById(int id) async {
    final response = await client.get(RestClientRequest(path: '/location/$id'));
    return Map<String, dynamic>.from(response.data);
  }
}
