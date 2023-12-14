
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:snip_snap/components/title_animation.dart';

import '../realm/app_services.dart';
import '../realm/realm_services.dart';


class SnipAppBar extends StatelessWidget with PreferredSizeWidget {
  SnipAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: AppBar(
        leading : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
        title: TitleAnimation(),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(realmServices.offlineModeOn
                ? Icons.wifi_off_rounded
                : Icons.wifi_rounded),
            tooltip: 'Offline mode',
            onPressed: () async => await realmServices.sessionSwitch(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () async => await logOut(context, realmServices),
          ),
        ],
      ),
    );

  }



  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Future<void> logOut(BuildContext context, RealmServices realmServices) async {
  final appServices = Provider.of<AppServices>(context, listen: false);
  appServices.logOut();
  await realmServices.close();
  Navigator.pushNamed(context, '/login');
}