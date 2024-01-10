import 'dart:convert';

import 'package:imdb_bloc/domain/repositories/auth_repository.dart';
import 'package:imdb_bloc/utils/debug_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  late SharedPreferences sharedPreferences;

  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      final user = {
        "email": email,
        "password": password,
      };

      final checkUser = sharedPreferences.getString("token");

      AppPrint.debugPrint('CHECK USER $checkUser');

      if (checkUser != null) return true;

      final userEncode = jsonEncode(user);
      sharedPreferences.setString(email, userEncode);

      // SAVE TOKEN USER WHEN LOGIN SUCCESSFULLY
      final token = sharedPreferences.setString("token", "$email-$password");

      AppPrint.debugPrint('USER $userEncode TOKEN $token');

      return true;
    } catch (e) {
      AppPrint.debugPrint("ERRO FROM AUTH REPO IMP $e");
      return false;
    }
  }

  @override
  Future<bool> getCurrentUser({required String email}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    final user = sharedPreferences.getString(email);
    if (user != null) {
      AppPrint.debugPrint("GET CURRENT USER $user");
      return true;
    }
    return false;
  }

  @override
  Future<bool> signOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove("token");
  }
}
