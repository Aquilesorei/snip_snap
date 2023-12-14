
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/realm/app_services.dart';

import '../components/linedit.dart';
import '../components/widgets.dart';
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState()  =>  ResetPasswordPageSate();

}
class ResetPasswordPageSate extends State<StatefulWidget> {

  bool _isLoading = false;
  final _passwordController =  TextEditingController();
  final _confirmPasswordController =  TextEditingController();
  static const space = 10.0;
  String _message= "";
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  void _handleLoading(bool value) => setState(() => _isLoading = value);

  void showMessage(String msg) => setState(() => _message = msg);


  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }
  Future<void> _changePassword(AppServices appServices,String  token , String tokenId, BuildContext context) async {

      _handleLoading(true);
     final password = _passwordController.text;
     final confirmPassword = _confirmPasswordController.text;

     if(password == confirmPassword ){

       appServices.resetPassword(
           password,
           token,
           tokenId,
           onSuccess: (){
             _handleLoading(false);
             infoMessageSnackBar(context, "Password changed successfully !");
             Navigator.pop(context);
           },
         onFailure: (err){

             errorMessageSnackBar(context, "Password change","failed to change password please try again");
           _handleLoading(false);
         }
       );
     }

  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments from the route settings
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = arguments['token'];
    final String tokenId = arguments['tokenId'];



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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter the new password:',
                      style: TextStyle(
                     color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                    ),
                    const SizedBox(height: space),
                    LineEdit(
                      focusNode: _focusNode1,
                      controller: _passwordController, hintText: 'Password',obscureText: true,
                      onTextChanged: (text){
                        if (_confirmPasswordController.text != text && _confirmPasswordController.text.isNotEmpty ) {
                          showMessage('passwords mismatch');
                        }
                        else {
                          showMessage('');
                        }
                      },
                      onSubmitted: (String value) {
                        _focusNode1.unfocus(); // Remove focus from the current TextField
                        _focusNode2.requestFocus(); // Set focus to the next TextField
                        print('Entered text 1: $value');
                      },
                    ),
                    const SizedBox(height: space),
                    LineEdit(
                      focusNode: _focusNode2,
                      controller: _confirmPasswordController, hintText: 'Confirm password',obscureText: true,
                      onTextChanged: (text){
                        if(text != _passwordController.text) {
                          showMessage('passwords mismatch');
                        }
                        else {
                          showMessage('');
                        }
                      },
                      onSubmitted: (String value){
                        _focusNode2.unfocus();
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
                    Consumer<AppServices>(builder: (context, appServices, child) {
                      return okButton(context, "OK", onPressed: () => _changePassword(appServices,token,tokenId, context));
                    }),
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
