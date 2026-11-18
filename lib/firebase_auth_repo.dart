import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<User?> register(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<void> signOut() async => _auth.signOut();
  Stream<User?> get userStream => _auth.authStateChanges();
}
