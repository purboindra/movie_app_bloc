import 'package:imdb_bloc/domain/entities/token_data.dart';

abstract class TokenRepository {
  Future<TokenData?> getToken();

  Future<String> getBearerToken();
  // Future<TokenData> refreshToken(TokenData toke);
  // Future<void> saveToken(TokenData token);
  // Future<void> deleteToken(TokenData token);
}
