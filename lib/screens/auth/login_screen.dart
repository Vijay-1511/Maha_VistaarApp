import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../core/widgets/custom_button.dart';
import '../../provider/auth_provider.dart';
import '../../app/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _login() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok = await auth.login(email.text, password.text);
    if (ok) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      final msg = auth.error ?? 'Login failed';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 6),
            CustomTextField(controller: email, hint: 'Email', keyboard: TextInputType.emailAddress),
            const SizedBox(height: 12),
            CustomTextField(controller: password, hint: 'Password', obscure: true),
            const SizedBox(height: 20),
            CustomButton(label: 'Login', onPressed: _login, loading: auth.loading),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, Routes.register),
                child: const Text('Register'),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
