import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarnama/auth/bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_isLogin) {
      final confirm = _confirmController.text.trim();
      if (confirm != password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пароли не совпадают')),
        );
        return;
      }
      context.read<AuthBloc>().add(
            AuthSignUpRequested(email: email, password: password),
          );
    } else {
      context.read<AuthBloc>().add(
            AuthSignInRequested(email: email, password: password),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.isLoading || state.status == AuthStatus.loading;
          return Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isLogin ? 'Вход' : 'Регистрация',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите email';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Неверный email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Пароль',
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length < 6) {
                                      return 'Минимум 6 символов';
                                    }
                                    return null;
                                  },
                                ),
                                if (!_isLogin) ...[
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: _confirmController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Повторите пароль',
                                      prefixIcon: Icon(Icons.lock_outline),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _submit,
                              child: Text(_isLogin ? 'Войти' : 'Зарегистрироваться'),
                            ),
                          ),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () => setState(() => _isLogin = !_isLogin),
                            child: Text(
                              _isLogin
                                  ? 'Нет аккаунта? Зарегистрируйтесь'
                                  : 'Уже есть аккаунт? Войти',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
