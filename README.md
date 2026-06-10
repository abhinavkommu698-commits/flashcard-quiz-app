# Flashcard Quiz App

A modern Flashcard Learning Application built using Flutter and Hive Database. The application helps students create, manage, and review flashcards efficiently with local data persistence and a clean Material 3 user interface.

Developed by KOMMU ABHINAV for the CodeAlpha App Development Internship Program

---

## Features

### Flashcard Management
- Create new flashcards
- View saved flashcards
- Edit existing flashcards
- Delete flashcards
- Automatic local data storage

### Learning Experience
- Show/Hide Answer functionality
- Previous and Next card navigation
- Card position indicator
- Smooth user experience
- Responsive layout

### UI & Design
- Material 3 Design
- Dark Theme Support
- Modern Card Interface
- Rounded Components
- Snackbar Notifications
- Empty State Screen

### Data Persistence
- Hive NoSQL Database
- Offline Storage
- Fast Data Retrieval
- Automatic Save Functionality

---

## Technologies Used

- Flutter
- Dart
- Hive Database
- Provider State Management
- Path Provider
- UUID Generator

---

## Dependencies

| Package | Purpose |
|----------|----------|
| hive | Local NoSQL database |
| hive_flutter | Flutter integration for Hive |
| provider | State management |
| path_provider | File system access |
| uuid | Unique ID generation |
| build_runner | Code generation |
| hive_generator | Hive adapter generation |

---

## Project Structure

text lib/ ├── main.dart ├── models/ │   ├── flashcard.dart │   └── flashcard.g.dart ├── providers/ │   └── flashcard_provider.dart ├── screens/ │   ├── home_screen.dart │   ├── add_flashcard_screen.dart │   └── edit_flashcard_screen.dart ├── services/ │   └── hive_service.dart └── widgets/     └── flashcard_widget.dart 

---

## Installation

### Clone Repository

bash git clone https://github.com/abhinavkommu698/flashcard_quiz_app.git cd flashcard_quiz_app 

### Install Dependencies

bash flutter pub get 

### Generate Hive Adapters

bash dart run build_runner build --delete-conflicting-outputs 

### Run Application

bash flutter run 

### Run on macOS

bash flutter run -d macos 

---

## Application Workflow

1. Open the application.
2. Click the "+" button.
3. Enter a question and answer.
4. Save the flashcard.
5. Navigate between cards using Previous and Next buttons.
6. Click "Show Answer" to reveal the answer.
7. Edit or delete flashcards whenever required.

---

## Screens

### Home Screen
- Displays flashcards
- Navigation controls
- Card counter
- Add Flashcard button

### Add Flashcard Screen
- Question field
- Answer field
- Validation support

### Edit Flashcard Screen
- Update flashcard details
- Delete flashcard option

---

## State Management

The application uses the Provider package for:

- Managing flashcard data
- Updating UI automatically
- Handling navigation state
- Managing CRUD operations

---

## Database

Hive Database is used for:

- Offline storage
- Fast performance
- Lightweight implementation
- Persistent flashcard data

---

## Future Enhancements

- Flashcard Categories
- Search Functionality
- Quiz Mode
- Import/Export Flashcards
- Cloud Synchronization
- Statistics Dashboard
- Flashcard Favorites

---

## Author

### KOMMU ABHINAV

B.Tech – Computer Science and Engineering (AI & ML)

GitHub:
https://github.com/abhinavkommu698

---

## License

This project was developed for educational and internship purposes under the CodeAlpha App Development Internship Program.