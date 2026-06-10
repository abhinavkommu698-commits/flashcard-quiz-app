// FlashcardWidget displays a single flashcard with question and answer
// Features smooth fade/slide animations when revealing the answer
import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onToggleAnswer;

  const FlashcardWidget({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onToggleAnswer,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for answer reveal animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void didUpdateWidget(FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when showAnswer changes
    if (widget.showAnswer && !_controller.isAnimating) {
      _controller.forward();
    } else if (!widget.showAnswer && _controller.isAnimating) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Question label
            Text(
              'Question',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 12),
            // Question text
            Text(
              widget.flashcard.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            // Animated answer section
            if (widget.showAnswer) ...[
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(_animation),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      // Answer label
                      Text(
                        'Answer',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(height: 12),
                      // Answer text
                      Text(
                        widget.flashcard.answer,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            // Show/Hide Answer button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: widget.onToggleAnswer,
                child: Text(
                  widget.showAnswer ? 'Hide Answer' : 'Show Answer',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}