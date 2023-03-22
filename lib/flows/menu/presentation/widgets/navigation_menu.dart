import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spots/flows/menu/presentation/widgets/menu_items_list.dart';
import 'package:spots/flows/menu/presentation/widgets/navigation_menu_header.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email;
    String username = '';
    if (email != null) {
      username = email.split('@')[0];
    }

    return Drawer(
      width: (MediaQuery.of(context).size.width + 100) / 2,
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          children: [
            NavigationMenuHeader(username: username),
            const SizedBox(height: 8),
            const MenuItemsList(),
          ],
        ),
      ),
    );
  }
}
