import 'dart:io';
import 'dart:ui';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/choose_file.dart';
import 'package:snip_snap/preferences.dart';
import 'package:snip_snap/utils.dart';

import '../pages/login.dart';
import 'package:flutter/material.dart';
import '../components/linedit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../realm/app_services.dart';
import '../realm/realm_services.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  // text editing controllers

   File? _file;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  String _message= "";
  String _filename = "";
  bool _isVisible = false;
  bool _isLoading = false;

  bool isAdmin= false;

  static const _items = ["Male","Female"];
  var _dropdownvalue = _items.first;
   static const space = 10.0;
  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }



  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SizedBox(
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


        SingleChildScrollView(
          child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                  const Text("Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                       // height: MediaQuery.of(context).size.height * 0.49,
                        child:  Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                LineEdit(controller: _nameController, hintText: 'First name'),
                                const SizedBox(height: space),
                                LineEdit(controller: _emailController, hintText: 'Email'),
                                const SizedBox(height: space),

                              DropdownButton(
                                // Initial Value
                                value: _dropdownvalue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: _items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }).toList(),

                                // After selecting the desired option, it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _dropdownvalue = newValue!;
                                  });
                                },

                                // New addition to change the text color when the dropdown is expanded
                                style: const TextStyle(color: Colors.white),
                                dropdownColor: Colors.black, // Change the dropdown color to make the text more visible
                                iconEnabledColor: Colors.white, // Change the color of the dropdown icon
                                focusColor: Colors.black, // Change the color when the dropdown is focused
                              ),

                              const SizedBox(height: space),
                                LineEdit(
                                  controller: _passwordController, hintText: 'Password',obscureText: true,
                                  onTextChanged: (text){
                                    if (_confirmPasswordController.text != text && _confirmPasswordController.text.isNotEmpty ) {
                                      setState(() {
                                        _message ="passwords mismatch";
                                      });

                                    }
                                    else {
                                      setState(() {
                                        _message ="";
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(height: space),
                                LineEdit(
                                  controller: _confirmPasswordController, hintText: 'Confirm password',obscureText: true,
                                  onTextChanged: (text){
                                    if(text != _passwordController.text) {
                                      setState(() {
                                        _message ="passwords mismatch";
                                      });

                                    }
                                    else {
                                      setState(() {
                                        _message ="";
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(height: space),

                                Text(
                                    _message,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: space),
                                Visibility(
                                  visible: _isVisible,
                               child : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children :[
                                Text(
                                    _filename,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.start
                                ),
                                  IconButton(
                                      onPressed: (){

                                    setState(() {
                                      _filename = "";
                                      _isVisible=  _filename.isNotEmpty;
                                    });
                                  },
                                  icon: const Icon(Icons.close,color: Colors.grey,)
                                  )
                                  ]
                                ),),

                                Row(
                                children :
                                    [

                                      const Text(
                                        "Is Admin : ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(value: isAdmin, onChanged: (value) {
                                     setState(() {
                                      isAdmin = value;
                                     });

                                    }),

                                    ],),
                                ChooseFile(

                                    onFileChoosen: (file) {
                                      setState(() {
                                        _file = file;
                                        _filename = file.uri.pathSegments.last;
                                         _isVisible=  _filename.isNotEmpty;
                                      });

                                    }
                                ),
                                const SizedBox(height: space),
                                FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: ElevatedButton(
                                    onPressed: () {


                                      final email  = _emailController.text;
                                      final name = _nameController.text;
                                      final password = _passwordController.text;
                                      final confirmPassword = _confirmPasswordController.text;
                                      if(password == confirmPassword) {
                                        signUpUser(context, email, password,name);

                                      }
                                      else{
                                        setState(() {
                                          _message = "Passwords mismatch";
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      minimumSize: const Size.fromHeight(40),
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                    child: const Text(
                                        'Sign up',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)
                                    ),

                                  ),
                                )
                                ,

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
           ),
              Center(
                child: Visibility(
                  visible: _isLoading,
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: const Color(0xFF1A1A3F),
                    rightDotColor: const Color.fromARGB(255, 12, 110, 42),
                    size: 50,
                  ),
                ),
              )
            ],
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

  void signUpUser(BuildContext context, String email, String password,String name) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    clearError();
    try {
          setState(() {
            _isLoading = true;
          });

        await appServices.registerUserEmailPassword(email, password);

        final realmServices =  RealmServices(appServices.app);

        String url ="" ;
        if(_file != null) {
        if (_file!.path.isNotEmpty) {
          url = await CloudManager.uploadFile(_file!.path);
        } else {
          url = "";
        }
      }

      realmServices.createProfile(name, email, isAdmin, _dropdownvalue, url);

      Navigator.pushNamed(context, '/');
    } catch (err) {

      setState(() {
        _isLoading = false;
        _message = err.toString();
      });
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }
}



