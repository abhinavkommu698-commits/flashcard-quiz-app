// Add Flashcard Screen - Screen for creating new flashcards
// Features: form validation, save/cancel buttons
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class AddFlashcardScreen extends StatefulWidget {
  const AddFlashcardScreen({super.key});

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  // Save the new flashcard to database
  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final flashcard = Flashcard(
        id: const Uuid().v4(),
        question: _questionController.text.trim(),
        answer: _answerController.text.trim(),
      );
      context.read<FlashcardProvider>().addFlashcard(flashcard);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flashcard added successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Flashcard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create a new flashcard',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Fill in both question and answer to save your flashcard',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 24),
              // Question input field with validation
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  hintText: 'Enter your question here',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Question cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Answer input field with validation
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  hintText: 'Enter your answer here',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Answer cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Save button
              FilledButton(
                onPressed: _saveFlashcard,
                child: const Text('Save Flashcard'),
              ),
              const SizedBox(height: 12),
              // Cancel button
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}