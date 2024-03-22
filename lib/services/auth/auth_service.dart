class AuthService {
  static Future<void> signUp(auth, String email, String password) async {
    await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
}
