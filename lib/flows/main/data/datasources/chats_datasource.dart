import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/flows/main/data/models/chat_model.dart';
import 'package:spots/flows/main/data/models/message_model.dart';
import 'package:spots/services/firestore/firestore_chats.dart';
import 'package:spots/services/firestore/firestore_messages.dart';

abstract class ChatsDatasourceI {
  Stream<List<ChatModel>> getUsersChats(String userId);
  Stream<List<MessageModel>> getChatMessages(String chatId, String userId);
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required DateTime dateTime,
    required String text,
  });
}

@Injectable(as: ChatsDatasourceI)
class ChatsDatasourceImpl implements ChatsDatasourceI {
  ChatsDatasourceImpl({
    required this.firestoreChats,
    required this.firestoreMessages,
  });

  final FirestoreChats firestoreChats;
  final FirestoreMessages firestoreMessages;

  @override
  Stream<List<ChatModel>> getUsersChats(String userId) {
    try {
      final result = firestoreChats.getUsersChats(userId);
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Stream<List<MessageModel>> getChatMessages(String chatId, String userId) {
    try {
      final result = firestoreMessages.getChatMessages(chatId, userId);
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required DateTime dateTime,
    required String text,
  }) async {
    try {
      final result = await firestoreMessages.addMessage(
        chatId: chatId,
        senderId: senderId,
        dateTime: dateTime,
        text: text,
      );
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }
}
