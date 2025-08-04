import 'dart:async';

import 'errors/rest_client_exception.dart';
import 'models/rest_client_http_message.dart';
import 'models/rest_client_request.dart';
import 'models/rest_client_response.dart';

abstract interface class IRestInterceptor {
  FutureOr<RestClientHttpMessage> onResponse(RestClientResponse response);
  FutureOr<RestClientHttpMessage> onRequest(RestClientRequest request);
  FutureOr<RestClientHttpMessage> onError(RestClientException error);
}
