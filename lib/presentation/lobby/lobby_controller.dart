import 'package:flutter/foundation.dart';
import 'package:gogymsync/domain/entities/user.dart';
import 'package:gogymsync/domain/usecases/start_session.dart';
import 'package:gogymsync/domain/usecases/watch_lobby.dart';
import 'package:gogymsync/domain/usecases/watch_session_status.dart';

class LobbyController extends ChangeNotifier {
  final WatchSessionStatusUseCase watchStatus;
  final WatchLobbyUsersUseCase watchUsers;
  final StartSessionUseCase startSessionUseCase;

  // -------------------------
  // Stan kontrolera
  // -------------------------
  bool _isLoading = false;
  bool _isSessionActive = false;
  List<User> _users = [];
  late final String _sessionCode;

  // Gettery
  bool get isLoading => _isLoading;
  bool get isSessionActive => _isSessionActive;
  List<User> get users => _users;
  String get sessionCode => _sessionCode;

  LobbyController({
    required this.watchStatus,
    required this.watchUsers,
    required this.startSessionUseCase,
  });

  // -------------------------
  // Inicjalizacja kontrolera
  // -------------------------
  void init(String sessionCode) {
    _sessionCode = sessionCode;

    // Subskrybuj status sesji
    watchStatus(sessionCode).listen((sessionEntity) {
      _isSessionActive = sessionEntity.isActive;
      notifyListeners();
    });

    // Subskrybuj listę użytkowników
    watchUsers(sessionCode).listen((userList) {
      _users = userList;
      notifyListeners();
    });
  }

  Future<void> startSession() async {
    _isLoading = true;
    notifyListeners();
    try {
      await startSessionUseCase(_sessionCode); // używasz _sessionCode
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}