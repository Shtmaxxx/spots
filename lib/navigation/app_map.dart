import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:spots/flows/main/presentation/pages/chat_page/chat_page.dart';
import '../flows/main/presentation/pages/main/main_page.dart';
import 'helpers/route_map_initial_page.dart';

class AppRouteMap extends RouteMap {
  AppRouteMap()
      : super(
          onUnknownRoute: _onUnknownRoute,
          routes: _routes(),
        );

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');

  static Map<String, PageBuilder> _routes() {
    return {
      MainPage.path: (_) => _createMaterialPage(
            const RouteMapInitialPage(
              child: MainPage(),
            ),
          ),
      ChatPage.path: (routeData) => _createMaterialPage(
            ChatPage(
              chatId: routeData.queryParameters['chatId']!,
              chatName: routeData.queryParameters['chatName']!,
              isGroup: routeData.queryParameters['isGroup'] == 'true',
            ),
          ),
    };
  }

  static MaterialPage<dynamic> _createMaterialPage(Widget page) {
    return MaterialPage(
      child: page,
      name: page.toString(),
    );
  }
}
