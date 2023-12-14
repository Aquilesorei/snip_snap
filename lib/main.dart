import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:provider/provider.dart';
import 'package:snip_snap/pages/home_page.dart';
import 'package:snip_snap/pages/login.dart';
import 'package:snip_snap/pages/reset_password_page.dart';


import 'package:snip_snap/realm/app_services.dart';
import 'package:snip_snap/realm/realm_services.dart';
import 'package:snip_snap/theme.dart';

import 'data_manager.dart';
import 'models/booking.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final realmConfig = json.decode(await rootBundle.loadString('assets/config/atlasConfig.json'));
  String appId = realmConfig['appId'];
  Uri baseUrl = Uri.parse(realmConfig['baseUrl']);


  return runApp(MultiProvider(providers: [
  ChangeNotifierProvider<AppServices>(create: (_) => AppServices(appId, baseUrl)),
  ChangeNotifierProxyProvider<AppServices, RealmServices?>(
  // RealmServices can only be initialized only if the user is logged in.
  create: (context) => null,
  update: (BuildContext context, AppServices appServices, RealmServices? realmServices) {


  return appServices.app.currentUser != null ? RealmServices(appServices.app) : null;
  }),
  ], child: const App()));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  RealmServices? _realmServices;
 StreamSubscription? _sub;

  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _realmServices = Provider.of<RealmServices?>(context);
    if (_realmServices != null) {
      final result = _realmServices!.realm.query<Booking>("TRUEPREDICATE SORT(_id ASC)");
      for (var element in result) {
        DataManager.instance.subscribeForDeletion(element, element.dateTime);
      }
      DataManager.instance.run(_realmServices!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RealmServices?>(context, listen: false)?.currentUser;

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'SnipSnap',
        debugShowCheckedModeBanner: false,
        theme: appThemeData(),
        initialRoute: currentUser != null ? '/' : '/login',
        routes: {
          '/': (context) => const HomePage(),
          '/login': (context) => LoginPage(),
          '/reset-password': (context) => const ResetPasswordPage(),
        },
      ),
    );
  }





}
