import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imdb_bloc/domain/repositories/token_repository.dart';
import 'package:imdb_bloc/utils/debug_print.dart';

const _baseHeaders = {
  'Content-Type': 'application/json',
  'charset': 'utf-8',
};

class UnauthorizedRequestInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(_baseHeaders);
    final data = {
      "options_method": options.method,
      "options_uri": options.uri,
      "query_paramaters": options.queryParameters,
      "request_data": options.data,
    };
    AppPrint.debugPrint('ON REQUEST $data');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    final data = {
      "method": response.requestOptions.method,
      "uri": response.requestOptions.uri,
      "data": response.data,
    };
    AppPrint.debugPrint('ON RESPONSE $data');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final data = {
      "method": err.requestOptions.method,
      "uri": err.requestOptions.uri,
      "data": err.response?.data,
    };
    AppPrint.debugPrint("ON ERROR $data");
    handler.next(err);
  }
}

class AuthorizedRequestInterceptor extends UnauthorizedRequestInterceptor {
  AuthorizedRequestInterceptor(this._tokenRepository);

  final TokenRepository _tokenRepository;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers[HttpHeaders.authorizationHeader] =
          await _tokenRepository.getBearerToken();

      AppPrint.debugPrint("HEADERS ${options.headers}");

      super.onRequest(options, handler);
    } on DioException catch (e) {
      handler.reject(e);
    } on Object catch (e) {
      AppPrint.debugPrint("ERROR onRequest ${e.toString()}");
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      // TODO
    } else {
      super.onError(err, handler);
    }
  }
}
