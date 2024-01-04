import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: const MaterialApp(
        title: 'Firebase Auth Demo',
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return LoginScreen();
  }
}
