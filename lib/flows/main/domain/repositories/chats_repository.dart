import 'package:dartz/dartz.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/flows/main/domain/entities/message.dart';

import '../entities/chat.dart';

abstract class ChatsRepositoryI {
  Either<Failure, Stream<List<Chat>>> getUsersChats(String userId);
  Either<Failure, Stream<List<Message>>> getChatMessages(
      String chatId, String userId);
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String senderId,
    required DateTime dateTime,
    required String text,
  });
  Future<Either<Failure, void>> addUserToGroupChat({
    required String userId,
    required String chatId,
  });
}
