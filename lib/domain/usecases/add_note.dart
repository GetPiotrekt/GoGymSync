import 'package:gogymsync/domain/entities/note.dart';
import 'package:gogymsync/domain/repositories/session_repository.dart';

class AddNoteUseCase {
  final SessionRepository repository;

  AddNoteUseCase(this.repository);

  Future<Note> call(String sessionCode, String userName, String text) async {
    return repository.addNote(sessionCode, userName, text);
  }
}