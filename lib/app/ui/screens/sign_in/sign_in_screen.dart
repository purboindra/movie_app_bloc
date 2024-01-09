import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_bloc/domain/bloc/auth_bloc.dart';
import 'package:imdb_bloc/domain/event/auth_event.dart';
import 'package:imdb_bloc/domain/state/auth_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.goNamed('/main', extra: {
              "email": _emailC.value.text,
            });
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailC,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passwordC,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(SignInEvent(
                                  email: _emailC.text,
                                  password: _passwordC.text));
                            },
                            child: Text(state is AuthLoadingState
                                ? "Loading..."
                                : "Sign In"),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
