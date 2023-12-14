

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EmailConfirmationScreen extends StatefulWidget {
  @override
  _EmailConfirmationScreenState createState() => _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  String token = '';
  bool _isLoading = false;
  final _tokenController =  TextEditingController();
  void _confirmEmail() {

     final token  = _tokenController.text;

  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter the confirmation token sent to your email:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _tokenController,
                      obscureText: false,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _confirmEmail();
                      },
                      child: const Text('Confirm Email'),
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
      ),
    );
  }
}



