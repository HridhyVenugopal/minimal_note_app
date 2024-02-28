import 'package:flutter/material.dart';
import 'package:isar_app/drawer/drawer_tile.dart';
import 'package:isar_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //Header
          const DrawerHeader(child: Icon(Icons.note)),

          //Note Tile
          DrawerTile(
              title: "Notes", leading: const Icon(Icons.home), onTap: () => Navigator.pop(context)),

          //settings
          DrawerTile(
              title: "Settings",
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingPage()));
              }),
        ],
      ),
    );
  }
}
