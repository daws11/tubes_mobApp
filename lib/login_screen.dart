import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'signup_screen.dart'; // Pastikan Anda telah membuat file ini
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                final UserCredential? result =
                    await authService.signInWithEmailAndPassword(
                  _emailController.text,
                  _passwordController.text,
                );
                if (result == 'Login Successful') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successful!')),
                  );
                  // TODO: Navigate to the home screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login Failed')),
                  );
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                String? result =
                    (await authService.signInWithGoogle()) as String?;
                if (result == 'Login Successful') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Login Successful with Google!')),
                  );
                  // TODO: Navigate to the home screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(result ?? 'Failed to login with Google')),
                  );
                }
              },
              child: const Text('Login with Google'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
            TextButton(
              onPressed: () {
                authService.sendPasswordResetEmail(_emailController.text);
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
