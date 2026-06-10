// Home Screen - Main screen displaying flashcards
// Features: card navigation, empty state, add/edit functionality
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';
import 'add_flashcard_screen.dart';
import 'edit_flashcard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz'),
      ),
      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child) {
          // Show empty state when no flashcards exist
          if (provider.totalCards == 0) {
            return _buildEmptyState();
          }

          final currentFlashcard = provider.currentFlashcard!;
          return Column(
            children: [
              // Flashcard display area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: InkWell(
                    // Tap card to edit
                    onTap: () => _navigateToEditFlashcard(currentFlashcard),
                    borderRadius: BorderRadius.circular(20),
                    child: FlashcardWidget(
                      flashcard: currentFlashcard,
                      showAnswer: _showAnswer,
                      onToggleAnswer: () {
                        setState(() {
                          _showAnswer = !_showAnswer;
                        });
                      },
                    ),
                  ),
                ),
              ),
              // Navigation controls at bottom (padded to avoid FAB overlap)
              SafeArea(
                top: false,
                child: _buildNavigationControls(provider),
              ),
            ],
          );
        },
      ),
      // Floating action button to add new flashcard
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFlashcard(),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Empty state UI showing onboarding message
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Flashcard Quiz!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Tap the + button to add your first flashcard. Your cards will be saved automatically.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _navigateToAddFlashcard,
              icon: const Icon(Icons.add),
              label: const Text('Add Your First Flashcard'),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation controls with centered buttons and card counter between them
  Widget _buildNavigationControls(FlashcardProvider provider) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          IconButton(
            onPressed: provider.canGoPrevious
                ? () {
                    setState(() => _showAnswer = false);
                    provider.goToPrevious();
                  }
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          // Card counter in the center
          const SizedBox(width: 16),
          Text(
            'Card ${provider.currentIndex + 1} of ${provider.totalCards}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(width: 16),
          // Next button
          IconButton(
            onPressed: provider.canGoNext
                ? () {
                    setState(() => _showAnswer = false);
                    provider.goToNext();
                  }
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  // Navigate to add flashcard screen
  void _navigateToAddFlashcard() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFlashcardScreen()),
    );
    setState(() => _showAnswer = false);
  }

  // Navigate to edit flashcard screen
  void _navigateToEditFlashcard(Flashcard flashcard) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFlashcardScreen(flashcard: flashcard),
      ),
    );
    setState(() => _showAnswer = false);
  }
}