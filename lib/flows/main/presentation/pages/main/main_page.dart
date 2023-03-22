import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:spots/flows/main/presentation/pages/chat_page/chat_page.dart';
import 'package:spots/flows/main/presentation/pages/main/cubit/chats_cubit.dart';
import 'package:spots/flows/main/presentation/pages/main/widgets/chat_item.dart';
import 'package:spots/flows/menu/presentation/widgets/navigation_menu.dart';
import 'package:spots/gen/assets.gen.dart';
import 'package:spots/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:spots/services/injectible/injectible_init.dart';
import 'package:spots/widgets/circular_loading.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return BlocProvider(
      create: (context) => getIt<ChatsCubit>()..getUsersChats(user.id),
      child: BlocListener<ChatsCubit, ChatsState>(
        listener: (context, state) {
          if (state is ChatsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Chats'),
            centerTitle: true,
          ),
          drawer: const NavigationMenu(),
          body: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SvgPicture.asset(
                  Assets.screenBubbles.path,
                ),
              ),
              Positioned(
                left: -40,
                bottom: 10,
                child: Opacity(
                  opacity: 0.2,
                  child: SvgPicture.asset(
                    Assets.onboarding1.path,
                    width: MediaQuery.of(context).size.width + 100,
                  ),
                ),
              ),
              BlocBuilder<ChatsCubit, ChatsState>(
                builder: (context, state) {
                  if (state is ChatsInitial) {
                    if (state.chats.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.chats.length,
                        itemBuilder: (context, index) {
                          final chat = state.chats[index];

                          return ChatItem(
                            title: chat.title,
                            recentMessage: chat.recentMessage,
                            dateTime: chat.recentMessageDateTime,
                            onPressed: () => Routemaster.of(context).push(
                              ChatPage.path,
                              queryParameters: {
                                'chatId': chat.id,
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('You have no chats :('),
                      );
                    }
                  } else if (state is ChatsLoading) {
                    return const CircularLoading();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
