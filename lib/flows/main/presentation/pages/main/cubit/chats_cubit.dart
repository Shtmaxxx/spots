import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/flows/main/domain/entities/chat.dart';
import 'package:spots/flows/main/domain/usecases/get_users_chats.dart';

part 'chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.getUsersChatsUseCase) : super(ChatsLoading());

  final GetUsersChatsUseCase getUsersChatsUseCase;

  void getUsersChats(String userId) {
    final result = getUsersChatsUseCase(userId);
    result.fold(
      (failure) {
        emit(
          ChatsError(failure: failure),
        );
      },
      (chatsStream) {
        chatsStream.listen((chats) {
          emit(
            ChatsInitial(chats: chats),
          );
        });
      },
    );
  }
}
