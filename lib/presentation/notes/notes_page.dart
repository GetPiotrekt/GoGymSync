import 'package:flutter/material.dart';
import 'package:gogymsync/core/di/injection_container.dart';
import 'package:gogymsync/presentation/notes/notes_controller.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatelessWidget {
  final String sessionCode;
  final String userName;
  final bool isSolo;

  const NotesPage({
    super.key,
    required this.sessionCode,
    required this.userName,
    this.isSolo = false,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Wstrzyknięcie kontrolera przez DI
    return ChangeNotifierProvider<NotesController>(
      create: (_) => sl<NotesController>()
        ..init(sessionCode, userName), // Inicjalizacja strumieni

      child: Consumer<NotesController>( // Używamy Consumer do dostępu do stanu
        builder: (context, controller, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Session: $sessionCode"),
              actions: [
                // 🛑 Wywołujemy metodę kontrolera, która użyje EndSessionUseCase
                IconButton(
                  icon: const Icon(Icons.stop_circle_outlined, color: Colors.redAccent),
                  tooltip: "End session",
                  onPressed: () => _showEndSessionDialog(context, controller),
                ),
                // ... (pozostała część AppBar)
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 👥 Wybór użytkownika - używa stanu i metod z kontrolera
                      _buildUserSelector(context, controller),
                      const SizedBox(height: 20),

                      // ✍️ Dodawanie notatki - używa _noteController i _addNote z kontrolera
                      _buildAddNoteSection(controller),
                      const SizedBox(height: 20),

                      // 🗒️ Lista notatek - używa listy z kontrolera
                      _buildNotesList(context, controller),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Logika dialogu i nawigacji pozostaje w Presentation
  Future<void> _showEndSessionDialog(
      BuildContext context, NotesController controller) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("End session"),
        content: const Text(
            "Are you sure you want to end this session? All data will be permanently deleted."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await controller.endSession(); // Wywołanie logiki biznesowej
        if (context.mounted) {
          Navigator.pop(context); // Powrót po sukcesie
        }
      } catch (e) {
        // Obsługa błędu
      }
    }
  }

  // Analogicznie, implementujemy pozostałe prywatne metody UI,
  // które wywołują metody Controller'a (np. _buildAddNoteSection wywoła controller.addNote()).

  Widget _buildUserSelector(BuildContext context, NotesController controller) {
    // Implementacja DropdownButton, która ustawia controller.setSelectedUser(val)
    return Container();
  }

  Widget _buildAddNoteSection(NotesController controller) {
    // Implementacja pola tekstowego i przycisku, która wywołuje controller.addNote()
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.noteController, // Controller zarządza TextEditingController
            decoration: const InputDecoration( /* ... */ ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: controller.addNote,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildNotesList(BuildContext context, NotesController controller) {
    // Budowanie ListView na podstawie controller.notes, używając controller.deleteNote i _showEditNoteDialog
    if (controller.notes.isEmpty) { /* ... */ }

    return ListView.builder(
      // ...
      itemBuilder: (context, index) {
        final note = controller.notes[index];
        return Card(
          child: ListTile(
            title: Text(note.text),
            subtitle: Text("for ${note.userName}"),
            onTap: () => _showEditNoteDialog(context, controller, note.id, note.text),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => controller.deleteNote(note.id), // Wywołanie logiki usuwania
            ),
          ),
        );
      },
    );
  }

  Future<void> _showEditNoteDialog(
      BuildContext context, NotesController controller, String noteId, String currentText) async {
    // Logika dialogu edycji (UI) pozostaje w Presentation
    final TextEditingController editController = TextEditingController(text: currentText);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // ... (UI dialogu)
          actions: [
            // ... (Cancel)
            ElevatedButton(
              onPressed: () async {
                await controller.updateNote(noteId, editController.text.trim()); // Wywołanie logiki
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}