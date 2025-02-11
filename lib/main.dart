import 'package:deckify/screens/decks/contributed_deck.dart';
import 'package:deckify/screens/decks/online_deck.dart';
import 'package:deckify/screens/decks/random_deck.dart';
import 'package:deckify/screens/decks/system_deck.dart';
import 'package:deckify/screens/decks/your_deck.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/shuffle_screen.dart';
import 'screens/create_flashcard_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/achievements_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/deck_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/themes.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'providers/auth_provider.dart';

//AppDa

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Handle any errors here, like showing an alert or logging the error
  }

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flashcards App',
      theme: lightTheme,  // Default light theme
      darkTheme: darkTheme,  // Dark theme
      themeMode: ThemeMode.system,  // Automatically adjust to system theme
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SignupScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/shuffle', page: () => ShuffleScreen()),
        GetPage(name: '/create_flashcard', page: () => CreateFlashcardScreen(deckId: '',)),
        GetPage(name: '/progress', page: () => ProgressScreen()),
        GetPage(name: '/achievements', page: () => AchievementsScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
        GetPage(name: '/deck', page: () => DeckScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/forgot_password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/your_deck', page: () => YourDeck()),
        GetPage(name: '/online_deck', page: () => OnlineDeck()),
        GetPage(name: '/random_deck', page: () => RandomDeck()),
        GetPage(name: '/system_deck', page: () => SystemDeck()),
        GetPage(name: '/contributed_deck', page: () => ContributedDeck()),

      ],
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<AuthProvider>(() => AuthProvider());  // Add AuthProvider binding
      }),
    );
  }
}
