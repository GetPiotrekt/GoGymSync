import '../../core/utils/session_code_generator.dart';
import '../repositories/session_repository.dart';

class CreateSessionUseCase {
  final SessionRepository repository;
  final SessionCodeGenerator codeGenerator;

  CreateSessionUseCase(this.repository, this.codeGenerator);

  Future<String> call({
    required String hostName,
    required DateTime date,
  }) async {
    // 1. Logika biznesowa: generowanie unikalnego kodu
    final sessionCode = codeGenerator.generate();
    // UWAGA: W realnej aplikacji tutaj powinien być loop sprawdzający unikalność kodu w bazie.

    // 2. Logika biznesowa: Tworzenie ID hosta
    const hostId = 'host_01';

    // 3. Wywołanie Repo
    await repository.createSession(
      sessionCode: sessionCode,
      hostName: hostName,
      date: date.toIso8601String(),
      hostId: hostId,
    );

    return sessionCode; // Zwracamy kod potrzebny do nawigacji
  }
}