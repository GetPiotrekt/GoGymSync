// Start Session Screen
import 'dart:math';
import 'package:flutter/material.dart';

import 'lobby_page.dart';

class StartSession extends StatefulWidget {
  const StartSession({super.key});

  @override
  State<StartSession> createState() => _StartSessionState();
}

class _StartSessionState extends State<StartSession> {
  late String sessionCode;
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Show loading for 1 second before showing the code
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        sessionCode = _generateSessionCode();
        isLoading = false;
      });
    });
  }

  String _generateSessionCode() {
    final random = Random();
    final code = random.nextInt(900000) + 100000; // always 6 digits
    return code.toString();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _createSession() {
    final name = _nameController.text.trim();
    final date = _selectedDate != null
        ? _selectedDate.toString().split(" ")[0]
        : "no date";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LobbyPage(
          sessionCode: sessionCode,
          userName: name.isNotEmpty ? name : "Host",
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Session"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                "Session Code: $sessionCode",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),

            // Session name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Session Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Date picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? "Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}"
                        : "No date selected",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _pickDate(context),
                  child: const Text("Pick Date"),
                ),
              ],
            ),
            const Spacer(),

            // Create session button
            Center(
              child: ElevatedButton(
                onPressed: isLoading ? null : _createSession,
                child: const Text("Create Session"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
