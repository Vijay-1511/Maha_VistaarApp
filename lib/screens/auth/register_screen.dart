import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_textfield.dart';
import '../../core/widgets/custom_button.dart';
import '../../provider/auth_provider.dart';
import '../../app/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _register() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok = await auth.register(name.text, email.text, password.text);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful. Please login.')));
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      final msg = auth.error ?? 'Registration failed';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: name, hint: 'Full name'),
            const SizedBox(height: 12),
            CustomTextField(controller: email, hint: 'Email', keyboard: TextInputType.emailAddress),
            const SizedBox(height: 12),
            CustomTextField(controller: password, hint: 'Password', obscure: true),
            const SizedBox(height: 20),
            CustomButton(label: 'Register', onPressed: _register, loading: auth.loading),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Already have an account?'),
              TextButton(onPressed: () => Navigator.pushReplacementNamed(context, Routes.login), child: const Text('Login'))
            ]),
          ],
        ),
      ),
    );
  }
}
