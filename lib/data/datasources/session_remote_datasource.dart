// Abstrakt
abstract class SessionRemoteDataSource {
  Future<void> joinSession(String code, String userId, String userName);
  Future<bool> checkSessionExists(String code);

  Stream<Map<String, dynamic>> watchSession(String code);
  Stream<List<Map<String, dynamic>>> watchLobbyUsers(String code);
  Future<void> setActive(String code);

  // Nowe metody: Notes CRUD & Watch
  Stream<List<Map<String, dynamic>>> watchNotes(String sessionCode);
  Future<void> addNote(String sessionCode, String note, String userName);
  Future<void> updateNote(String sessionCode, String noteId, String newText);
  Future<void> deleteNote(String sessionCode, String noteId);

  // Nowa metoda: End Session (usuwanie rekurencyjne)
  Future<void> deleteSessionWithData(String sessionCode);

  Future<void> createSession(String code, String name, String date, String hostId, String hostName);
}