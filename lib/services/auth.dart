import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future<AuthResult> signup(String email, String password) async {
    final authresault = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authresault;
  }

  Future<AuthResult> signin(String email, String password) async {
    final authresault = await auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authresault;
  }
}
