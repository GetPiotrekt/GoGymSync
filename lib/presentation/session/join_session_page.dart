import 'package:flutter/material.dart';
import 'package:gogymsync/domain/usecases/join_session.dart';
import 'package:gogymsync/presentation/lobby/lobby_page.dart';

class JoinSessionPage extends StatefulWidget {
  final JoinSessionUseCase joinSessionUseCase;

  const JoinSessionPage({super.key, required this.joinSessionUseCase});

  @override
  State<JoinSessionPage> createState() => _JoinSessionPageState();
}

class _JoinSessionPageState extends State<JoinSessionPage> {
  final TextEditingController _sessionCodeController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  bool _isLoading = false; // pole do kontrolowania stanu ładowania

  // Metoda do dołączania do sesji
  Future<void> _joinSession(BuildContext context) async {
    final sessionCode = _sessionCodeController.text.trim();
    final userName = _userNameController.text.trim();

    if (sessionCode.isEmpty || userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter session code and username')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.joinSessionUseCase(sessionCode, userName);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LobbyPage(
              sessionCode: sessionCode,
              userName: userName,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error joining session: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join Session")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _sessionCodeController,
              decoration: const InputDecoration(
                labelText: 'Session Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () => _joinSession(context),
              child: const Text('Join Session'),
            ),
          ],
        ),
      ),
    );
  }
}