import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:spots/flows/main/presentation/pages/chat_page/chat_page.dart';
import 'package:spots/flows/menu/presentation/pages/spots_map/spots_map_page.dart';
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
      ..._spotsMapRoute(),
    };
  }

  static Map<String, PageBuilder> _spotsMapRoute([String path = '']) {
    return {
      SpotsMapPage.path: (routeData) => _createMaterialPage(
            SpotsMapPage(
              focusedPlaceId: routeData.queryParameters['markerId'],
            ),
          ),
      // MapPage.path + CreateMarkerPage.path: (_) => _createMaterialPage(
      //       const CreateMarkerPage(),
      //     ),
      // MapPage.path + CreateMarkerPage.path + PickMarkerLocationPage.path:
      //     (routeData) => _createMaterialPage(
      //           PickMarkerLocationPage(
      //             name: routeData.queryParameters['name']!,
      //             description: routeData.queryParameters['description']!,
      //             typeId: routeData.queryParameters['typeId']!,
      //             typeIndex: int.parse(routeData.queryParameters['typeIndex']!),
      //           ),
      //         ),
    };
  }

  static MaterialPage<dynamic> _createMaterialPage(Widget page) {
    return MaterialPage(
      child: page,
      name: page.toString(),
    );
  }
}
