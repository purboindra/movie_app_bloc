abstract class AuthRepository {
  Future<bool> signIn({required String email, required String password});
  Future<bool> getCurrentUser({required String email});
  Future<bool> signOut();
}
