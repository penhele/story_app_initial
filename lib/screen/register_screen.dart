import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/register_request.dart';
import '../provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const RegisterScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
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

              context.watch<AuthProvider>().isLoadingRegister
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final RegisterRequest register = RegisterRequest(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        final authRead = context.read<AuthProvider>();

                        final result = await authRead.register(register);

                        if (result) widget.onRegister();
                      }
                    },
                    child: const Text("REGISTER"),
                  ),

              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => widget.onLogin(),
                child: const Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
