
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/booking_manager.dart';
import 'package:snip_snap/pages/home_page.dart';
import 'package:snip_snap/preferences.dart';
import 'package:snip_snap/realm/realm_services.dart';

import 'components/app_bar.dart';
import 'components/offers_list.dart';


 
class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    final url  = (realmServices.profile.picture.isNotEmpty) ?  realmServices.profile.picture: "https://firebasestorage.googleapis.com/v0/b/snipsnap-be0f8.appspot.com/o/images%2Fplaceholder.png?alt=media&token=01ee11c9-3a11-440a-86cb-f27055efbf0c";
    return Drawer(
        child: Column(
      children: <Widget>[
         UserAccountsDrawerHeader(
          currentAccountPicture:  CircleAvatar(foregroundImage: NetworkImage(url),),
            accountName: Text(realmServices.profile.name),
            accountEmail: Text(realmServices.profile.email),
        ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage())),
            ),

            ListTile(
              leading: const Icon(Icons.event_note),
              title: const Text('Booking'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BookingManager()),
            )
            ),

        ListTile(
          leading: const Icon(Icons.local_offer),
          title: const Text('Special offers'),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OfferList())),
        ),

            const Spacer(),



        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap:  () async => await logOut(context, realmServices),
            )
      ],
    ));
  }
}