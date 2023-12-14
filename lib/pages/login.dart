// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/pages/password_forgotten.dart';
import 'package:snip_snap/pages/signup.dart';
import 'package:uni_links/uni_links.dart';

import '../components/my_button.dart';
import '../components/linedit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../realm/app_services.dart';
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  // text editing controllers
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final bool _isLoading = false;
  String _message = "";
  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;
  final _formKey = GlobalKey<FormState>();

  BuildContext? _context;
  StreamSubscription? _streamSubscription;
  bool _initialURILinkHandled = false;
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;



  Future<void> _initURIHandler() async {
    // 1
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      // 2
      try {
        // 3
        final initialURI = await getInitialUri();
        // 4
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }


          setState(() {
            _initialURI = initialURI;
          });

          if(_context != null) {
            handleDeepLink(_context!,initialURI);
          }
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException { // 5
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) { // 6
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }


  void _incomingLinkHandler(BuildContext context) {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        if(_context != null) {
          handleDeepLink(context, uri);
        } // Pass the context as a parameter
        debugPrint('Received URI: $uri');
        setState(() {
          _currentURI = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        debugPrint('Error occurred: $err');
        setState(() {
          _currentURI = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  void handleDeepLink(BuildContext bcontext, Uri? uri) {
    if (uri != null &&
        uri.scheme == 'http' &&
        uri.host == 'm.myriad.com' &&
        uri.path.startsWith('/resetpassword')) {
      String token = uri.queryParameters['token'] ?? '';
      String tokenId = uri.queryParameters['tokenId'] ?? '';

      Navigator.pushNamed(
        bcontext,
        '/reset-password',
        arguments: {'token': token, 'tokenId': tokenId},
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initURIHandler();
    if(_context != null) {
      _incomingLinkHandler(_context!);
    }
    /* final appServices = Provider.of<AppServices>(context, listen: false);
    appServices.resetPassword("zongoachille06@gmail.com");*/
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/woman.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  const Text("Log in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(

                 child : ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: emailController,
                                  obscureText: false,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.greenAccent, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'enter your email',
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),

                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.03
                                ),
                                TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.greenAccent, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'enter your password',
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.03
                                ),
                                Text(
                                  _message,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final email  = emailController.text;
                                      final password = passwordController.text;
                                      _logInUser(context, email, password);

                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      minimumSize: Size.fromHeight(40),
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                    child: Text(
                                      'Login',
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)
                                    ),

                                  ),
                                )
                                ,
                                const SizedBox(height: 30),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PasswordForgottenPage()),
                                    );
                                  },
                                child : Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 233, 133),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                    textAlign: TextAlign.start
                                ),
                                ),

                              ],
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),),
                  const SizedBox(height: 30),
                  Center(
                  child :Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup()),
                          );
                        },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 233, 133),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    ],
                  ),),

                ],
              ),
              Center(
                child: Visibility(
                  visible: _isLoading,
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: const Color(0xFF1A1A3F),
                    rightDotColor: Color.fromARGB(255, 12, 110, 42),
                    size: 50,
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }



  void clearError() {
    if (_message.isNotEmpty) {
      setState(() {
        // Reset error message when user starts typing
        _message = "";
      });
    }
  }

  void _logInUser(BuildContext context, String email, String password) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    clearError();
    try {
        await appServices.logInUserEmailPassword(email, password);
      Navigator.pushNamed(context, '/');
    } catch (err) {
      setState(() {
        _message = err.toString();
      });
    }
  }
}
