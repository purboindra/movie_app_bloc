import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_bloc/core/dio/api_interceptor.dart';
import 'package:imdb_bloc/domain/repositories/token_repository.dart';
import 'package:injectable/injectable.dart';

const _requestTimeOutInSeconds = Duration(seconds: 7);

@module
abstract class DioModule {
  @singleton
  Dio getAuthorizedDioClient(TokenRepository tokenRepository) {
    final dioClient = _dioClient();
    dioClient.interceptors
        .addAll([AuthorizedRequestInterceptor(tokenRepository)]);
    return dioClient;
  }

  @Named("Unauthorized")
  @singleton
  Dio getUnauthorizedDioClient() {
    final dioClient = _dioClient();
    dioClient.interceptors.addAll([
      UnauthorizedRequestInterceptor(),
    ]);
    return dioClient;
  }

  Dio _dioClient() {
    final baseOptions = BaseOptions(
        baseUrl: dotenv.get("BASEURL"),
        receiveDataWhenStatusError: true,
        connectTimeout: _requestTimeOutInSeconds,
        receiveTimeout: _requestTimeOutInSeconds);

    return Dio(baseOptions);
  }
}
