import 'package:deutschvocab/colors.dart';
import 'package:deutschvocab/components/widgets/input_field.dart';
import 'package:deutschvocab/components/widgets/splash_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Log in to Deutsch Vocabulary'),
              InputField(
                controller: _emailController,
                labelText: 'Email',
              ),
              InputField(
                controller: _passwordController,
                labelText: 'Password',
                isPassword: true,
                showPassword: true,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SplashButtonCustom(
                  outlined: true,
                  outlineWidth: 3,
                  borderRadius: 15,
                  text: 'Log In'.toUpperCase(),
                  splashColor: darkYellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
