import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/realm/app_services.dart';

import '../components/linedit.dart';
import '../components/widgets.dart';
import '../utils.dart';




class PasswordForgottenPage extends StatefulWidget {
  const PasswordForgottenPage({super.key});

  @override
  State<StatefulWidget> createState()  =>  PasswordForgottenPageSate();

}
class PasswordForgottenPageSate extends State<StatefulWidget> {

  bool _isLoading = false;
  final _emailController =  TextEditingController();
  static const space = 10.0;
  String _message= "";


  void _handleLoading(bool value) => setState(() => _isLoading = value);

  void showMessage(String msg) => setState(() => _message = msg);



  Future<void> _requestPasswordChange(AppServices appServices, BuildContext context) async {

    _handleLoading(true);
    final email = _emailController.text;
    if(isValidEmail(email)) {
     await appServices.sendPasswordResetEmail(
          email,
        onSuccess: (){
          _handleLoading(false);
          setState(() => _message = "reset mail sent successfully please open your mail inbox ");
          infoMessageSnackBar(context,_message);
          Navigator.pop(context);
        },
        onFailure: (e){
          setState(() => _message = "failed to sent email  , please try again");
          _handleLoading(false);
        }
      );
    }
    else{
      setState(() => _message = "Invalid email address");
    }


  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
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
              Center(

                  child : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter your email',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: space),
                    LineEdit(
                      controller:  _emailController, hintText: 'Email',obscureText: false,
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
                    Consumer<AppServices>(builder: (context, appServices, child) {
                      return okButton(context, "OK", onPressed: () => _requestPasswordChange(appServices, context));
                    }),
                  ],
                ),
              )),
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
