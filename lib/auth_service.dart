import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "tubes-mobapp-9c34b.apps.googleusercontent.com",
  );

  // Login dengan Email dan Password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign Up dengan Email, Password, dan Username
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Membuat pengguna dengan email dan password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jika berhasil, tambahkan data pengguna ke Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        // Anda dapat menambahkan lebih banyak field sesuai kebutuhan
      });

      return 'Sign Up Successful';
    } on FirebaseAuthException catch (e) {
      // Tangani kesalahan yang mungkin terjadi
      return e.message;
    } catch (e) {
      // Tangani kesalahan lainnya
      return e.toString();
    }
  }

  // Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Login dengan Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // Pengguna membatalkan proses login
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Tangani kesalahan autentikasi dari Firebase
      print('Firebase Auth Error: $e');
      return null;
    } on Exception catch (e) {
      // Tangani kesalahan lainnya
      print('General Error: $e');
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    return await _firebaseAuth.signOut();
  }

  // Cek status login
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
