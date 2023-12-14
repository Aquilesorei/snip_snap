

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/app_bar.dart';
import 'package:snip_snap/components/create_booking.dart';
import 'package:snip_snap/drawer_navigation.dart';

import '../components/home_body.dart';
import '../realm/realm_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : Scaffold(
      appBar: SnipAppBar(),
      drawer: const DrawerNavigation(),
      body: HomeBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const CreateBookingAction(),
    );
  }
}
