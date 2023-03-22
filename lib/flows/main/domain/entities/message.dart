import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    required this.id,
    required this.senderRef,
    required this.sentByUser,
    required this.messageText,
    required this.dateTime,
  });

  final String id;
  final DocumentReference senderRef;
  final bool sentByUser;
  final String messageText;
  final DateTime dateTime;
}
