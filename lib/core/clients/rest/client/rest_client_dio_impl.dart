// rest_client_dio_impl.dart
import 'package:desafio_fteam/core/clients/rest/constants/dio_adapter.dart';
import 'package:desafio_fteam/core/clients/rest/i_rest_client.dart';
import 'package:desafio_fteam/core/clients/rest/i_rest_interceptor.dart';
import 'package:desafio_fteam/core/clients/rest/interceptors/rest_interceptor_impl.dart';
import 'package:desafio_fteam/core/clients/rest/models/rest_client_multipart.dart';
import 'package:desafio_fteam/core/clients/rest/models/rest_client_request.dart';
import 'package:desafio_fteam/core/clients/rest/models/rest_client_response.dart';
import 'package:dio/dio.dart';

// Remova a classe DioFactory inteira.

class RestClientDioImpl implements IRestClient {
  final Dio _dio;

  final Map<IRestInterceptor, Interceptor> _interceptors = {};

  RestClientDioImpl({required Dio dio}) : _dio = dio;

  @override
  void addInterceptor(IRestInterceptor interceptor) {
    _interceptors[interceptor] = RestInterceptorImpl(interceptor: interceptor);
    _dio.interceptors.add(_interceptors[interceptor]!);
  }

  @override
  void removeInterceptors(IRestInterceptor interceptor) {
    _dio.interceptors.remove(_interceptors[interceptor]);
  }

  @override
  Future<RestClientResponse> upload(RestClientMultipart multipart) async {
    final formData = FormData.fromMap({
      multipart.fileKey: MultipartFile.fromBytes(
        multipart.fileBytes ?? [],
        filename: multipart.fileName,
      ),
    });

    final baseOptions = BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api', //
      connectTimeout: Duration(milliseconds: 30000), //
      receiveTimeout: Duration(milliseconds: 30000), //
    );

    Dio dio = Dio(baseOptions); //
    final response = await dio.put(
      //
      multipart.path, //
      data: formData, //
    );

    return DioAdapter.toClientResponse(response); //
  }

  @override
  Future<RestClientResponse> delete(RestClientRequest request) async {
    try {
      final response = await _dio.delete(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  @override
  Future<RestClientResponse> get(RestClientRequest request) async {
    // Remova o bloco if/else e o try/finally.
    // A baseUrl já estará configurada na instância _dio.
    try {
      final response = await _dio.get(
        request.path,
        queryParameters: request.queryParameters,
        data: request.data,
        options: Options(headers: request.headers),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  @override
  Future<RestClientResponse> patch(RestClientRequest request) async {
    try {
      final response = await _dio.patch(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  @override
  Future<RestClientResponse> post(RestClientRequest request) async {
    // Remova o bloco if/else e o try/finally.
    // A baseUrl já estará configurada na instância _dio.
    try {
      final response = await _dio.post(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }

  @override
  Future<RestClientResponse> put(RestClientRequest request) async {
    try {
      final response = await _dio.put(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(headers: request.headers),
      );
      return DioAdapter.toClientResponse(response);
    } on DioException catch (e) {
      throw DioAdapter.toClientException(e);
    }
  }
}
