import '../repositories/session_repository.dart';

class DeleteNoteUseCase {
  final SessionRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(String sessionCode, String noteId) async {
    await repository.deleteNote(sessionCode, noteId);
  }
}