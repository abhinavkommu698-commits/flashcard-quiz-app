// Edit Flashcard Screen - Screen for editing and deleting flashcards
// Features: pre-filled form, update/delete functionality
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class EditFlashcardScreen extends StatefulWidget {
  final Flashcard flashcard;

  const EditFlashcardScreen({
    super.key,
    required this.flashcard,
  });

  @override
  State<EditFlashcardScreen> createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    // Pre-fill with existing flashcard data
    _questionController = TextEditingController(text: widget.flashcard.question);
    _answerController = TextEditingController(text: widget.flashcard.answer);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  // Update the flashcard in database
  void _updateFlashcard() {
    if (_formKey.currentState!.validate()) {
      final updatedFlashcard = Flashcard(
        id: widget.flashcard.id,
        question: _questionController.text.trim(),
        answer: _answerController.text.trim(),
        createdAt: widget.flashcard.createdAt,
      );
      context.read<FlashcardProvider>().updateFlashcard(updatedFlashcard);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flashcard updated successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Flashcard'),
        actions: [
          // Delete button in app bar
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit your flashcard',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Update the question or answer below',
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
              // Save changes button
              FilledButton(
                onPressed: _updateFlashcard,
                child: const Text('Save Changes'),
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

  // Show confirmation dialog before deleting
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text(
          'Are you sure you want to delete this flashcard?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              context.read<FlashcardProvider>().deleteFlashcard(widget.flashcard.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Flashcard deleted')),
                );
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}