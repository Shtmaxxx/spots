import 'package:spots/flows/main/domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.id,
    required super.participantsRefs,
    required super.title,
    required super.recentMessage,
    required super.recentMessageDateTime,
  });
}
