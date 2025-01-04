import 'package:flutter/material.dart';

// Define light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF9B87FF), // Soft Purple
  hintColor: const Color(0xFFA3D5FF),  // Pastel Blue
  scaffoldBackgroundColor: const Color(0xFFF9F9F9), // Light Theme Background
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF333333)), // Light Theme Text (Main)
    bodyMedium: TextStyle(color: Color(0xFF333333)),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF9B87FF), // Primary button color
    textTheme: ButtonTextTheme.normal, // Ensure text style will not override color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black, backgroundColor: const Color(0xFF9B87FF), // Text color for buttons in light theme
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF9B87FF),     // Primary Color
    secondary: Color(0xFFC1B7FF),   // Secondary Color (Slightly lighter purple)
    background: Color(0xFFF9F9F9),  // Light Theme Background Color
    onBackground: Color(0xFF333333), // Dark Text on Light Background
    surface: Color(0xFFFFFFFF),     // Surface color (e.g., cards)
    onSurface: Color(0xFF333333),   // Text on Surface (Dark text)
    tertiary: Color(0xFFA3D5FF),    // Tertiary color (Pastel Blue for additional elements)
  ),
  cardColor: const Color(0xFFFFFFFF), // Default card color for light theme
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// Define dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF9B87FF), // Soft Purple
  hintColor: const Color(0xFFA3D5FF),  // Pastel Blue
  scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Dark Theme Background
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFEAEAEA)), // Dark Theme Text (Main)
    bodyMedium: TextStyle(color: Color(0xFFEAEAEA)),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF9B87FF), // Primary button color
    textTheme: ButtonTextTheme.normal, // Ensure text style will not override color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: const Color(0xFF9B87FF), // Text color for buttons in dark theme
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF9B87FF),      // Primary Color
    secondary: Color(0xFFC1B7FF),    // Secondary Color (Slightly lighter purple)
    background: Color(0xFF1A1A1A),   // Dark Theme Background Color
    onBackground: Color(0xFFEAEAEA), // Light Text on Dark Background
    surface: Color(0xFF2A2A2A),      // Surface color (e.g., cards)
    onSurface: Color(0xFFEAEAEA),    // Text on Surface (Light text)
    tertiary: Color(0xFFA3D5FF),     // Tertiary color (Pastel Blue for additional elements)
  ),
  cardColor: const Color(0xFF2A2A2A), // Default card color for dark theme
  visualDensity: VisualDensity.adaptivePlatformDensity,
);