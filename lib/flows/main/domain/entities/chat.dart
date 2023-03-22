import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  Chat({
    required this.id,
    required this.participantsRefs,
    required this.title,
    required this.recentMessage,
    required this.recentMessageDateTime,
  });

  final String id;
  final List<DocumentReference> participantsRefs;
  final String title;
  final String recentMessage;
  final DateTime recentMessageDateTime;
}
