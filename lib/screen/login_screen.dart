import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/login_request.dart';
import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email.';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              context.watch<AuthProvider>().isLoadingLogin
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final LoginRequest login = LoginRequest(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        final authRead = context.read<AuthProvider>();

                        final result = await authRead.login(login);

                        if (result) {
                          widget.onLogin();
                        } else {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Your email or password is invalid",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("LOGIN"),
                  ),

              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => widget.onRegister(),
                child: const Text("REGISTER"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
