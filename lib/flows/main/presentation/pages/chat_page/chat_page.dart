import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spots/flows/main/domain/entities/message.dart';
import 'package:spots/flows/main/presentation/pages/chat_page/cubit/messages_cubit.dart';
import 'package:spots/flows/main/presentation/pages/chat_page/widgets/message_item.dart';
import 'package:spots/flows/main/presentation/pages/chat_page/widgets/message_text_field.dart';
import 'package:spots/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:spots/services/injectible/injectible_init.dart';
import 'package:spots/widgets/circular_loading.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.chatId,
    super.key,
  });

  static const path = '/chat';

  final String chatId;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return BlocProvider(
      create: (context) => getIt<MessagesCubit>()
        ..initStream(
          chatId,
          user.id,
        ),
      child: BlocListener<MessagesCubit, MessagesState>(
        listener: (context, state) {
          if (state is MessagesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Maksym Shtoler'),
                centerTitle: true,
              ),
              backgroundColor: Theme.of(context).canvasColor,
              body: Stack(
                children: [
                  BlocBuilder<MessagesCubit, MessagesState>(
                    builder: (context, state) {
                      if (state is MessagesInitial) {
                        return StreamBuilder<List<Message>>(
                          stream: state.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              context.read<MessagesCubit>().emitError(
                                    'Error: ${snapshot.error.toString()}',
                                  );
                            } else if (snapshot.hasData) {
                              final messages = snapshot.data!;

                              return SingleChildScrollView(
                                reverse: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  verticalDirection: VerticalDirection.up,
                                  children: [
                                    const SizedBox(height: 55),
                                    ...messages
                                        .map(
                                          (item) => MessageItem(
                                            message: item.messageText,
                                            time: DateFormat.Hm()
                                                .format(item.dateTime),
                                            sentByUser: item.sentByUser,
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              );
                            }
                            return const CircularLoading();
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xffdcddfa),
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: Row(
                        children: [
                          MessageTextField(
                            controller:
                                context.read<MessagesCubit>().messageController,
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () async =>
                                await context.read<MessagesCubit>().sendMessage(
                                      chatId: chatId,
                                      senderId: user.id,
                                      dateTime: DateTime.now(),
                                    ),
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.all(6),
                              minimumSize: const Size(0, 0),
                            ),
                            child: const Text(
                              'Send',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
