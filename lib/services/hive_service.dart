// Service for initializing and managing Hive database
// Handles flashcard persistence locally on the device
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/flashcard.dart';

class HiveService {
  static const String _boxName = 'flashcards';

  // Initialize Hive and register the Flashcard adapter
  static Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDir.path);
    Hive.registerAdapter(FlashcardAdapter());
    await Hive.openBox<Flashcard>(_boxName);
  }

  // Get the flashcard box instance
  static Box<Flashcard> getFlashcardBox() {
    return Hive.box<Flashcard>(_boxName);
  }
}