// lib/domain/entities/note.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id; // ID notatki
  final String text; // Treść notatki
  final String userName; // Autor notatki
  final DateTime? createdAt; // Czas utworzenia
  final DateTime? updatedAt; // Czas ostatniej aktualizacji

  Note({
    required this.id,
    required this.text,
    required this.userName,
    this.createdAt,
    this.updatedAt,
  });

  // Factory do konwersji z Map (np. z Firestore)
  factory Note.fromMap(String id, Map<String, dynamic> map) {
    return Note(
      id: id,
      text: map['text'] ?? '',
      userName: map['userName'] ?? '',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userName': userName,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }

  Note copyWith({
    String? text,
    String? userName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id,
      text: text ?? this.text,
      userName: userName ?? this.userName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}