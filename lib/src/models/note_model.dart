import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String title;
  final String content;
  final DateTime date;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> data, String documentId) {
    return NoteModel(
      id: documentId,
      title: data['title'],
      content: data['content'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
