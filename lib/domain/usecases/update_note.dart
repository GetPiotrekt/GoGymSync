import 'package:gogymsync/domain/repositories/session_repository.dart';

class UpdateNoteUseCase {
  final SessionRepository repository;

  UpdateNoteUseCase(this.repository);
  Future<void> call(String sessionCode, String noteId, String newText) async {
    await repository.updateNote(sessionCode, noteId, newText);
  }
}