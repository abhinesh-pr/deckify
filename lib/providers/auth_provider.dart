import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart'; // Import the AuthService class

class AuthProvider extends GetxController {
  // Create an instance of AuthService
  final AuthService _authService = AuthService();

  var isAuthenticated = false.obs;
  var user = Rx<UserModel?>(null);

  // Initialize authentication state
  AuthProvider() {
    _initializeAuthState();
  }

  // Check if user is already logged in
  Future<void> _initializeAuthState() async {
    try {
      User? firebaseUser = _authService.currentUser;

      if (firebaseUser != null) {
        // Fetch user details from Firestore
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        if (doc.exists) {
          user.value = UserModel.fromMap(doc.data() as Map<String, dynamic>);
          isAuthenticated.value = true;
        }
      }
    } catch (e) {
      print("Error initializing auth state: $e");
    }
  }

  // Sign up user
  Future<void> signup(String email, String password, String name) async {
    try {
      User? firebaseUser = await _authService.signupUser(
        email: email,
        password: password,
        name: name,
      );
      if (firebaseUser != null) {
        // Store user data in Firestore
        UserModel newUser = UserModel(
          uid: firebaseUser.uid,
          name: name,
          email: email,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set(newUser.toMap());

        // Update local state
        user.value = newUser;
        isAuthenticated.value = true;
      }
    } catch (e) {
      print("Error during signup: $e");
      rethrow;
    }
  }

  // Login user
  Future<bool> login(String email, String password) async {
    try {
      User? firebaseUser = await _authService.loginUser(
        email: email,
        password: password,
      );
      if (firebaseUser != null) {
        // Fetch user details from Firestore
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        if (doc.exists) {
          user.value = UserModel.fromMap(doc.data() as Map<String, dynamic>);
          isAuthenticated.value = true;
          return true;  // Login successful
        }
      }
      return false; // Login failed
    } catch (e) {
      print("Error during login: $e");
      return false;  // Return false if an error occurs
    }
  }


  // Logout user
  Future<void> logout() async {
    try {
      await _authService.signOut();

      // Reset local state
      user.value = null;
      isAuthenticated.value = false;
    } catch (e) {
      print("Error during logout: $e");
      rethrow;
    }
  }
}
