import '../repositories/session_repository.dart';

class StartSessionUseCase {
  final SessionRepository repository;
  StartSessionUseCase(this.repository);

  Future<void> call(String code) async {
    await repository.startSession(code);
  }
}