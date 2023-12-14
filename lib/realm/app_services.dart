import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class AppServices with ChangeNotifier {
  String id;
  Uri baseUrl;
  App app;
  User? currentUser;
  AppServices(this.id, this.baseUrl)
      : app = App(AppConfiguration(id, baseUrl: baseUrl));

  Future<User> logInUserEmailPassword(String email, String password) async {
    User loggedInUser =
    await app.logIn(Credentials.emailPassword(email, password));

    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser =
    await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }



  Future<void> sendPasswordResetEmail(String email, { void Function()? onSuccess, Function(dynamic)? onFailure}) async {
    final emailPasswordProvider = EmailPasswordAuthProvider(app);

    try {
      await emailPasswordProvider.resetPassword(email);
      print('Password reset email sent successfully.');
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      print('Error sending password reset email: $e');
      if (onFailure != null) {
        onFailure(e);
      }
    }
  }


  void resetPassword(
      String newPassword,
    String token,
    String tokenId,
      {
    void Function()? onSuccess,
    void Function(dynamic error)? onFailure,
  }) {
    final emailPasswordAuthProvider = EmailPasswordAuthProvider(app); // Replace `app` with your `App` instance
    emailPasswordAuthProvider.completeResetPassword(newPassword, token, tokenId)
        .then((_) {
      // Password reset completed successfully
      print('Password reset completed successfully.');
      if (onSuccess != null) {
        onSuccess();
      }
    })
        .catchError((error) {
      // Handle any errors that occurred during the password reset process
      print('Error resetting password: $error');
      if (onFailure != null) {
        onFailure(error);
      }
    });
  }






  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }

  String generateTokenId() { return "00000";}
  String generateToken() {return "00000";}

}



