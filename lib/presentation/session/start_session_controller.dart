import 'package:flutter/material.dart';

import '../../domain/usecases/create_session.dart';

class StartSessionController extends ChangeNotifier {
  final CreateSessionUseCase createSessionUseCase;

  // Stan UI
  final TextEditingController nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _sessionCode = '';
  bool _isLoadingCode = true;
  bool _isCreating = false;
  bool _startExpanded = false;
  bool _isCreated = false; // Nowy status do obsługi nawigacji

  // --- Gettery ---
  DateTime get selectedDate => _selectedDate;
  String get sessionCode => _sessionCode;
  bool get isLoadingCode => _isLoadingCode;
  bool get isCreating => _isCreating;
  bool get startExpanded => _startExpanded;
  bool get isCreated => _isCreated;

  StartSessionController({required this.createSessionUseCase});

  // --- Metody Inicjalizacyjne ---

  void init() {
    // Generowanie kodu sesji odbywa się poprzez Use Case/Repozytorium
    // Na potrzeby demonstracji, po prostu symulujemy ładowanie
    Future.delayed(const Duration(seconds: 1), () async {
      // Wywołanie Use Case/Repozytorium do wygenerowania kodu sesji
      // W idealnym świecie, Use Case zwróciłby kod lub błąd.
      // Tutaj symulujemy, że Use Case generuje kod.
      _sessionCode = createSessionUseCase.codeGenerator.generate(); // Użycie generatora z use case
      _isLoadingCode = false;
      notifyListeners();
    });
  }

  // --- Logika Widoku ---

  void toggleExpanded() {
    _startExpanded = !_startExpanded;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      _selectedDate = picked;
      notifyListeners();
    }
  }

  void resetCreationStatus() {
    _isCreated = false;
  }

  // --- Logika Biznesowa (Wywołanie Use Case) ---

  Future<void> createSession() async {
    if (_isLoadingCode || _isCreating) return;

    _isCreating = true;
    notifyListeners();

    final name = nameController.text.trim();
    final hostName = name.isNotEmpty ? name : 'Host';

    try {
      // Wywołanie Use Case
      final newCode = await createSessionUseCase(
        hostName: hostName,
        date: _selectedDate,
      );

      _sessionCode = newCode;
      _isCreated = true; // Ustawienie flagi dla nawigacji
      // W tym miejscu Controller jest gotowy do nawigacji,
      // ale nawigacja MUSI odbyć się w Widoku (Page).

    } catch (e) {
      // Obsługa błędów, np. wyświetlenie SnackBar
      print('Error creating session: $e');
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }
}