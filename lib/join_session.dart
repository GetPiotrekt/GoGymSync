// Join Session Screen
import 'package:flutter/material.dart';

import 'lobby_page.dart';

class JoinSession extends StatefulWidget {
  const JoinSession({super.key});

  @override
  State<JoinSession> createState() => _JoinSessionState();
}

class _JoinSessionState extends State<JoinSession> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _joinSession() {
    final code = _codeController.text.trim();
    final name = _nameController.text.trim();

    if (code.isNotEmpty && name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LobbyPage(sessionCode: code, userName: name),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter session code and your name")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Session"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Session code input
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: "Session Code (6 digits)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // User name input
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Join button
            ElevatedButton(
              onPressed: _joinSession,
              child: const Text("Join"),
            ),
          ],
        ),
      ),
    );
  }
}