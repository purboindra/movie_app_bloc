import 'package:equatable/equatable.dart';

class TokenData with EquatableMixin {
  final String accessToken;
  final String refreshToken;

  TokenData({required this.accessToken, required this.refreshToken});

  @override
  List<Object> get props => [accessToken, refreshToken];
}
