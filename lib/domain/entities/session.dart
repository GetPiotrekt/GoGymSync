// lib/domain/entities/session.dart

import 'user.dart';

class Session {
  final String code;
  final String name;
  final DateTime? date;
  final String hostId;
  final bool isActive;
  final List<User> users;

  Session({
    required this.code,
    required this.name,
    this.date,
    required this.hostId,
    this.isActive = false,
    this.users = const [],
  });

  // Factory do konwersji z Map (np. z Firestore)
  factory Session.fromMap(String code, Map<String, dynamic> map, {List<User>? users}) {
    return Session(
      code: code,
      name: map['name'] ?? 'Session',
      date: map['date'] != null
          ? DateTime.tryParse(map['date'])
          : null,
      hostId: map['hostId'] ?? '',
      isActive: map['isActive'] ?? false,
      users: users ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date?.toIso8601String(),
      'hostId': hostId,
      'isActive': isActive,
    };
  }

  Session copyWith({
    String? name,
    DateTime? date,
    bool? isActive,
    List<User>? users,
  }) {
    return Session(
      code: code,
      name: name ?? this.name,
      date: date ?? this.date,
      hostId: hostId,
      isActive: isActive ?? this.isActive,
      users: users ?? this.users,
    );
  }
}