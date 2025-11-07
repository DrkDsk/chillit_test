import 'package:chillit_test/src/features/login/ui/cubits/login_cubit.dart';
import 'package:chillit_test/src/features/login/ui/cubits/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
  }

  Future<void> login() async {
    _loginCubit.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state.status == LoginStateStatus.error) {
                  return Text(
                    state.error,
                    style: TextStyle(color: Colors.redAccent),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            ElevatedButton(
              onPressed: login,
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
