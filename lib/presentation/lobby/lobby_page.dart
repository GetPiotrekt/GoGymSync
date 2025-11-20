import 'package:flutter/material.dart';
import 'package:gogymsync/core/di/injection_container.dart';
import 'package:gogymsync/presentation/notes/notes_page.dart';
import 'package:provider/provider.dart';

import 'lobby_controller.dart'; // DI

// --- WIDEGET WIDOKU ---

class LobbyPage extends StatelessWidget {
  final String sessionCode;
  final String userName;

  const LobbyPage({
    super.key,
    required this.sessionCode,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LobbyController>(
      create: (_) => sl<LobbyController>() // Wstrzykujemy controller przez DI
        ..init(sessionCode), // Inicjalizacja controller'a z kodem sesji
      builder: (context, child) {
        // Kontroler jest używany do obsługi logiki widoku
        final controller = context.watch<LobbyController>();

        // Logika nawigacji (reagowanie na stan z controllera)
        _handleSessionStartNavigation(context, controller);

        return Scaffold(
          appBar: AppBar(title: Text("Lobby (${userName})")),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Session code: $sessionCode",
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                const Text(
                  "Users in session:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // 👥 Live users list - uzywa danych z controllera
                Expanded(
                  child: _buildUsersList(controller),
                ),

                const SizedBox(height: 20),

                // 🟢 Start session button - używa stanu z controllera i wywołuje metodę
                if (!controller.isSessionActive)
                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : controller.startSession,
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Start Session"),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- ODDZIELNE METODY BUDOWANIA/OBSŁUGI ---

  Widget _buildUsersList(LobbyController controller) {
    // Tutaj używamy listy użytkowników przechowywanej w kontrolerze (po stronie Presentation)
    if (controller.users.isEmpty) {
      return const Center(child: Text("No users connected yet."));
    }
    return ListView.builder(
      itemCount: controller.users.length,
      itemBuilder: (context, index) {
        final user = controller.users[index];
        return ListTile(
          title: Text(user.username),
          subtitle: Text(user.roleId),
        );
      },
    );
  }

  // Logika nawigacji pozostaje w warstwie Presentation, ale jest wyzwalana stanem
  void _handleSessionStartNavigation(
      BuildContext context, LobbyController controller) {
    if (controller.isSessionActive && ModalRoute.of(context)?.isCurrent == true) {
      // Używamy Future.delayed, aby nawigacja nie kolidowała z build()
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NotesPage(
              sessionCode: sessionCode,
              userName: userName,
            ),
          ),
        );
      });
    }
  }
}