// Flashcard Quiz App - Main Entry Point
// CodeAlpha App Development Internship Project
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/flashcard_provider.dart';
import 'services/hive_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive database
  await HiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Flashcard provider for state management
        ChangeNotifierProvider(
          create: (context) => FlashcardProvider(HiveService.getFlashcardBox()),
        ),
      ],
      child: MaterialApp(
        title: 'Flashcard Quiz',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}