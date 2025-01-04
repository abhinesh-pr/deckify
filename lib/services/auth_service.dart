import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up user
  Future<User?> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await cred.user?.updateProfile(displayName: name);
        await cred.user?.reload();

        return cred.user;
      } else {
        Get.snackbar("Error", "Please fill in all fields",
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (err) {
      Get.snackbar("Error", err.toString(), snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // Login user
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        return cred.user;
      } else {
        Get.snackbar("Error", "Please fill in all fields",
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (err) {
      Get.snackbar("Error", err.toString(), snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user details
  User? get currentUser => _auth.currentUser;

  // Get login status
  bool get isLoggedIn => _auth.currentUser != null;

  // Reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset email: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
