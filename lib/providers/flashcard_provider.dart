// Provider for managing flashcard state
// Uses ChangeNotifier for reactive state updates
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/flashcard.dart';

class FlashcardProvider extends ChangeNotifier {
  final Box<Flashcard> _flashcardBox;
  int _currentIndex = 0;
  List<Flashcard> _cachedFlashcards = [];

  FlashcardProvider(this._flashcardBox) {
    _loadFlashcards();
  }

  // Load flashcards from database and sort by creation date
  void _loadFlashcards() {
    _cachedFlashcards = _flashcardBox.values.toList();
    _cachedFlashcards.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  // Get all flashcards from the database (ordered by creation date)
  List<Flashcard> get flashcards {
    if (_cachedFlashcards.isEmpty) {
      _loadFlashcards();
    }
    return _cachedFlashcards;
  }

  // Current flashcard index
  int get currentIndex => _currentIndex;

  // Get the currently displayed flashcard
  Flashcard? get currentFlashcard {
    if (flashcards.isEmpty) return null;
    if (_currentIndex >= flashcards.length) {
      _currentIndex = flashcards.length - 1;
    }
    return flashcards[_currentIndex];
  }

  // Total number of flashcards
  int get totalCards => flashcards.length;

  // Can navigate to previous card
  bool get canGoPrevious => _currentIndex > 0;

  // Can navigate to next card
  bool get canGoNext => _currentIndex < totalCards - 1;

  // Navigate to next flashcard
  void goToNext() {
    if (canGoNext) {
      _currentIndex++;
      notifyListeners();
    }
  }

  // Navigate to previous flashcard
  void goToPrevious() {
    if (canGoPrevious) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Navigate to specific index
  void goToIndex(int index) {
    if (index >= 0 && index < totalCards) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  // Add a new flashcard to the database and navigate to it
  void addFlashcard(Flashcard flashcard) {
    _flashcardBox.put(flashcard.id, flashcard);
    _loadFlashcards();
    // Navigate to the newly added flashcard (last in sorted list)
    _currentIndex = flashcards.length - 1;
    notifyListeners();
  }

  // Update an existing flashcard
  void updateFlashcard(Flashcard flashcard) {
    flashcard.save();
    _loadFlashcards();
    notifyListeners();
  }

  // Delete a flashcard by ID
  void deleteFlashcard(String id) {
    _flashcardBox.delete(id);
    _loadFlashcards();
    if (_currentIndex >= totalCards && totalCards > 0) {
      _currentIndex = totalCards - 1;
    }
    if (totalCards == 0) {
      _currentIndex = 0;
    }
    notifyListeners();
  }

  // Refresh flashcards from database
  void refresh() {
    _loadFlashcards();
    notifyListeners();
  }
}