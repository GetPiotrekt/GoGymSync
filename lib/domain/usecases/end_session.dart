import '../repositories/session_repository.dart';

class EndSessionUseCase {
  final SessionRepository repository;
  EndSessionUseCase(this.repository);

  // Use Case opakowuje logikę biznesową (usuwanie, czyszczenie)
  Future<void> call(String sessionCode) async {
    // Jeśli potrzebna jest weryfikacja uprawnień, dzieje się to tutaj.
    await repository.endSession(sessionCode);
  }
}