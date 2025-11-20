import 'package:flutter/material.dart';
import 'package:gogymsync/core/di/injection_container.dart';
import 'package:gogymsync/domain/usecases/join_session.dart';

// Importujemy widoki z Presentation
import 'package:gogymsync/presentation/session/join_session_page.dart';
import 'package:gogymsync/presentation/session/start_session_page.dart';

// Zmieniamy nazwę na HomeView/HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('GoGymSync',
            style: TextStyle(
              fontFamily: 'BarlowSemiCondensed',
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // 🟦 Kontener z opisem (bez zmian)
              Container( /* ... */ ),
              const SizedBox(height: 16),

              // 🔘 Start session (nawigacja używa nowych nazw widoków)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StartSessionPage()), // Używamy nowej nazwy
                  );
                },
                child: const SizedBox(
                  width: 140,
                  height: 50,
                  child: Center(child: Text("Start session")),
                ),
              ),

              const SizedBox(height: 16),

              // 🔘 Join session
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinSessionPage(
                        joinSessionUseCase: sl<JoinSessionUseCase>(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                ),
                child: const SizedBox(
                  width: 140,
                  height: 50,
                  child: Center(child: Text("Join session")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}