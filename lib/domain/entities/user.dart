// lib/domain/entities/user.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String roleId; // np. 'host' lub 'participant'
  final DateTime? joinedAt;

  User({
    required this.id,
    required this.username,
    required this.roleId,
    this.joinedAt,
  });

  // Factory do konwersji z Map (np. z Firestore)
  factory User.fromMap(String id, Map<String, dynamic> map) {
    return User(
      id: id,
      username: map['username'] ?? '',
      roleId: map['roleID'] ?? 'participant',
      joinedAt: map['joinedAt'] != null
          ? (map['joinedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'roleID': roleId,
      if (joinedAt != null) 'joinedAt': joinedAt,
    };
  }
}