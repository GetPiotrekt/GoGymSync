// Implementacja
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gogymsync/data/datasources/session_remote_datasource.dart';

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final FirebaseFirestore firestore;

  SessionRemoteDataSourceImpl(this.firestore);

  @override
  Future<bool> checkSessionExists(String code) async {
    final sessionRef = firestore.collection('session').doc(code);
    final snapshot = await sessionRef.get();
    return snapshot.exists;
  }

  @override
  Future<void> joinSession(String code, String userId, String userName) async {
    final sessionRef = firestore.collection('session').doc(code);

    await sessionRef.collection('users').doc(userId).set({
      'username': userName,
      'roleID': 'participant',
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Stream<Map<String, dynamic>> watchSession(String code) {
    return firestore.collection('session').doc(code).snapshots().map(
          (snapshot) => snapshot.data() ?? {},
    );
  }

  @override
  Stream<List<Map<String, dynamic>>> watchLobbyUsers(String code) {
    return firestore
        .collection('session')
        .doc(code)
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<void> setActive(String code) async {
    final sessionRef = firestore.collection('session').doc(code);
    await sessionRef.set({'isActive': true}, SetOptions(merge: true));
  }

  @override
  Future<void> createSession(String code, String name, String date,
      String hostId, String hostName) async {
    final sessionRef = firestore.collection('session').doc(code);

    await sessionRef.set({
      'name': name.isNotEmpty ? name : 'Host Session',
      'date': date,
      'createdAt': FieldValue.serverTimestamp(),
      'hostId': hostId,
    });

    await sessionRef.collection('users').doc(hostId).set({
      'username': hostName.isNotEmpty ? hostName : 'Host',
      'roleID': 'host',
    });
  }

  // ===================== Nowe metody =====================

  @override
  Stream<List<Map<String, dynamic>>> watchNotes(String sessionCode) {
    return firestore
        .collection('session')
        .doc(sessionCode)
        .collection('notes')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id; // dodajemy id notatki
          return data;
        }).toList());
  }

  @override
  Future<void> addNote(String sessionCode, String note, String userName) async {
    final notesRef = firestore
        .collection('session')
        .doc(sessionCode)
        .collection('notes');
    await notesRef.add({
      'text': note,
      'userName': userName,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateNote(String sessionCode, String noteId,
      String newText) async {
    final noteRef = firestore.collection('session').doc(sessionCode).collection(
        'notes').doc(noteId);
    await noteRef.update({
      'text': newText,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteNote(String sessionCode, String noteId) async {
    final noteRef = firestore.collection('session').doc(sessionCode).collection(
        'notes').doc(noteId);
    await noteRef.delete();
  }

  @override
  Future<void> deleteSessionWithData(String sessionCode) async {
    final sessionRef = firestore.collection('session').doc(sessionCode);

    // Pobranie wszystkich podkolekcji i usuwanie dokumentów
    final usersSnapshot = await sessionRef.collection('users').get();
    for (var doc in usersSnapshot.docs) {
      await doc.reference.delete();
    }

    final notesSnapshot = await sessionRef.collection('notes').get();
    for (var doc in notesSnapshot.docs) {
      await doc.reference.delete();
    }

    // Na końcu usuń dokument sesji
    await sessionRef.delete();
  }
}