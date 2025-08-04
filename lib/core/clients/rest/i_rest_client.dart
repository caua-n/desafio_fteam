import 'i_rest_interceptor.dart';
import 'models/rest_client_multipart.dart';
import 'models/rest_client_request.dart';
import 'models/rest_client_response.dart';

abstract interface class IRestClient {
  Future<RestClientResponse> post(RestClientRequest request);

  Future<RestClientResponse> get(RestClientRequest request);

  Future<RestClientResponse> put(RestClientRequest request);

  Future<RestClientResponse> delete(RestClientRequest request);

  Future<RestClientResponse> patch(RestClientRequest request);

  Future<RestClientResponse> upload(RestClientMultipart multipart);

  void addInterceptor(IRestInterceptor interceptor);

  void removeInterceptors(IRestInterceptor interceptor);
}
