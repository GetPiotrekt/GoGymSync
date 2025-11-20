import 'package:gogymsync/domain/entities/user.dart';
import 'package:gogymsync/domain/repositories/session_repository.dart';

class WatchLobbyUsersUseCase {
  final SessionRepository repository;

  WatchLobbyUsersUseCase(this.repository);

  Stream<List<User>> call(String sessionCode) {
    return repository.watchLobbyUsers(sessionCode);
  }
}