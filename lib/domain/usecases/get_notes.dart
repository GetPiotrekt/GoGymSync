import 'package:gogymsync/domain/entities/note.dart';

import '../repositories/session_repository.dart';

class GetNotesUseCase {
  final SessionRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call(String sessionCode) async {
    return repository.getNotes(sessionCode);
  }
}