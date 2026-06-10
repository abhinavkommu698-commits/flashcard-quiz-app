// Hive model for Flashcard entity
// Stores question and answer for flashcard learning
import 'package:hive/hive.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 0)
class Flashcard extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String question;

  @HiveField(2)
  String answer;

  @HiveField(3)
  DateTime createdAt;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}