import 'package:spots/flows/main/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.senderRef,
    required super.sentByUser,
    required super.messageText,
    required super.dateTime,
  });
}
