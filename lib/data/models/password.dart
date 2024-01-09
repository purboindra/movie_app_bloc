import 'package:formz/formz.dart';

enum PasswordInputError { invalid }

class Password extends FormzInput<String, PasswordInputError> {
  const Password.pure() : super.pure("");

  const Password.dirty([super.value = ""]) : super.dirty();

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordInputError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? "")
        ? PasswordInputError.invalid
        : null;
  }
}
