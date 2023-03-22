import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/flows/main/domain/entities/message.dart';
import 'package:spots/flows/main/domain/repositories/chats_repository.dart';

@injectable
class GetChatMessagesUseCase {
  final ChatsRepositoryI repository;

  GetChatMessagesUseCase(this.repository); 

  Either<Failure, Stream<List<Message>>> call(String chatId, String userId) {
    return repository.getChatMessages(chatId, userId);
  }
}