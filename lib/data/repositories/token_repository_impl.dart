import 'package:imdb_bloc/data/local/token_storage.dart';
import 'package:imdb_bloc/domain/entities/token_data.dart';
import 'package:imdb_bloc/domain/repositories/token_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TokenRepository)
class TokenRepositoryImpl implements TokenRepository {
  final TokenStorage _tokenStorage;

  const TokenRepositoryImpl(this._tokenStorage);

  @override
  Future<TokenData?> getToken() async {
    return await _tokenStorage.getToken();
  }

  @override
  Future<String> getBearerToken() async {
    final token = await _tokenStorage.getToken();
    return 'Bearer ${token!.accessToken}';
  }
}
