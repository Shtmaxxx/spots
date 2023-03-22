import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:spots/flows/main/domain/entities/chat.dart';
import 'package:spots/flows/main/domain/repositories/chats_repository.dart';

@injectable
class GetUsersChatsUseCase {
  final ChatsRepositoryI repository;

  GetUsersChatsUseCase(this.repository);

  Either<Failure, Stream<List<Chat>>> call(String userId) {
    return repository.getUsersChats(userId);
  }
}