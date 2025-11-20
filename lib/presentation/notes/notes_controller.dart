import 'package:flutter/material.dart';
import 'package:gogymsync/domain/entities/note.dart';
import 'package:gogymsync/domain/usecases/add_note.dart';
import 'package:gogymsync/domain/usecases/delete_note.dart';
import 'package:gogymsync/domain/usecases/end_session.dart';
import 'package:gogymsync/domain/usecases/get_notes.dart';
import 'package:gogymsync/domain/usecases/update_note.dart';

class NotesController extends ChangeNotifier {
  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final EndSessionUseCase endSessionUseCase;

  NotesController({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.endSessionUseCase,
  });

  // 🔹 Stan
  List<Note> notes = [];
  String sessionCode = '';
  String currentUser = '';
  List<String> users = [];
  final TextEditingController noteController = TextEditingController();

  // 🔹 Inicjalizacja kontrolera
  void init(String session, String user) async {
    sessionCode = session;
    currentUser = user;
    await _loadNotes();
    // Możesz też załadować listę użytkowników, jeśli jest dostępna
    users = [user]; // tymczasowo tylko aktualny użytkownik
  }

  // 🔹 Ładowanie notatek
  Future<void> _loadNotes() async {
    notes = await getNotesUseCase(sessionCode);
    notifyListeners();
  }

  // 🔹 Dodawanie notatki
  Future<void> addNote() async {
    final text = noteController.text.trim();
    if (text.isEmpty) return;

    final newNote = await addNoteUseCase(sessionCode, currentUser, text);
    notes.add(newNote);
    noteController.clear();
    notifyListeners();
  }

  // 🔹 Aktualizacja notatki
  Future<void> updateNote(String noteId, String newText) async {
    if (newText.isEmpty) return;
    await updateNoteUseCase(sessionCode, noteId, newText);
    final index = notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      notes[index] = notes[index].copyWith(text: newText);
      notifyListeners();
    }
  }

  // 🔹 Usuwanie notatki
  Future<void> deleteNote(String noteId) async {
    await deleteNoteUseCase(noteId, sessionCode);
    notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }

  // 🔹 Zakończenie sesji
  Future<void> endSession() async {
    await endSessionUseCase(sessionCode);
    notes.clear();
    notifyListeners();
  }

  // 🔹 Zmiana aktualnego użytkownika
  void setSelectedUser(String user) {
    currentUser = user;
    notifyListeners();
  }
}