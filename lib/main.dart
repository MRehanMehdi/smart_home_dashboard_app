import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Home Dashboard",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),

        useMaterial3: true,

        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Colors.black87,
          ),
        ),

        appBarTheme: const AppBarTheme(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          shadowColor: Colors.black12,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),

        // ✅ Updated for Flutter 3.13+: use CardThemeData instead of CardTheme
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shadowColor: Colors.black12,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),

      home: DashboardScreen(),
    );
  }
}
