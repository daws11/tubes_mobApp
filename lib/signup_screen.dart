import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String? result = await authService.signUpWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (result == 'Sign Up Successful') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign Up Successful!')),
                  );
                  // Navigate to home screen or login screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result ?? 'Sign Up Failed')),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
