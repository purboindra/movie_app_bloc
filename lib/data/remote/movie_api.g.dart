// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MovieApi implements MovieApi {
  _MovieApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PaginatedResponse<MovieResponse>> getTrendingMoviesOfThisWeek() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaginatedResponse<MovieResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/trending/movie/week',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaginatedResponse<MovieResponse>.fromJson(
      _result.data!,
      (json) => MovieResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PaginatedResponse<MovieResponse>> getNowPlayingMovies() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaginatedResponse<MovieResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/movie/now_playing',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaginatedResponse<MovieResponse>.fromJson(
      _result.data!,
      (json) => MovieResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<DetailMovieResponse> getDetailMovie(String id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DetailMovieResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/movie/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DetailMovieResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> addToFav(
    String accountId,
    Map<String, dynamic> body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/account/${accountId}/favorite',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<PaginatedResponse<FavoriteMovieResponse>> getFavoriteMovie(
      String accountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaginatedResponse<FavoriteMovieResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/account/${accountId}/favorite/movies',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaginatedResponse<FavoriteMovieResponse>.fromJson(
      _result.data!,
      (json) => FavoriteMovieResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<void> addToWatchlist(
    String accountId,
    Map<String, dynamic> body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/account/${accountId}/watchlist',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<PaginatedResponse<FavoriteMovieResponse>> getWatchlistMovie(
      String accountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaginatedResponse<FavoriteMovieResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/account/${accountId}/watchlist/movies',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaginatedResponse<FavoriteMovieResponse>.fromJson(
      _result.data!,
      (json) => FavoriteMovieResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
