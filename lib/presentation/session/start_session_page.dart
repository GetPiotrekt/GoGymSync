import 'package:flutter/material.dart';
import 'package:gogymsync/core/di/injection_container.dart';
import 'package:gogymsync/presentation/lobby/lobby_page.dart';
import 'package:gogymsync/presentation/session/start_session_controller.dart';
import 'package:provider/provider.dart';

class StartSessionPage extends StatelessWidget {
  const StartSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StartSessionController>(
      create: (_) => sl<StartSessionController>()..init(),
      child: Consumer<StartSessionController>(
        builder: (context, controller, child) {
          _handleNavigation(context, controller);

          return Scaffold(
            appBar: AppBar(title: const Text("Start Session")),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildCreateSessionCard(context, controller),
                  const SizedBox(height: 20),
                  _buildExpandablePanel(context, controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleNavigation(BuildContext context, StartSessionController controller) {
    if (controller.isCreated) {
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          final hostName = controller.nameController.text.trim().isNotEmpty
              ? controller.nameController.text.trim()
              : 'Host';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LobbyPage(
                sessionCode: controller.sessionCode,
                userName: hostName,
              ),
            ),
          );
          controller.resetCreationStatus();
        }
      });
    }
  }

  Widget _buildCreateSessionCard(BuildContext context, StartSessionController controller) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: controller.toggleExpanded,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "Create a new training session",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandablePanel(BuildContext context, StartSessionController controller) {
    final todayFormatted = controller.selectedDate.toLocal().toString().split(' ')[0];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: controller.startExpanded
          ? Column(
        key: const ValueKey(1),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: controller.isLoadingCode
                ? const CircularProgressIndicator()
                : Text(
              "Session Code: ${controller.sessionCode}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: "Name:",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Date: $todayFormatted",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.pickDate(context),
                child: const Text("Change"),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: controller.isLoadingCode || controller.isCreating
                  ? null
                  : controller.createSession,
              child: controller.isCreating
                  ? const CircularProgressIndicator()
                  : const Text("Create Session"),
            ),
          ),
        ],
      )
          : const SizedBox.shrink(key: ValueKey(0)),
    );
  }
}