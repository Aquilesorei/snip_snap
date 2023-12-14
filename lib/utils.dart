import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;


class CloudManager{
 static FirebaseStorage storage = FirebaseStorage.instance;


  static Future<String> uploadFile(String path,{Function(double)? onProgress,Function ? onFinished}) async {
// Upload a file to Firebase Storage

    final file = File(path);
    final filename = file.uri.pathSegments.last;
    Reference ref = storage.ref().child('images/$filename');
    UploadTask uploadTask = ref.putFile(file);

// Listen for upload progress
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      final progress =snapshot.bytesTransferred/snapshot.totalBytes;
      onProgress?.call(progress);
      if (kDebugMode) {
        print('Upload progress:$progress');
      }
      if(progress ==1.0 ){
        onFinished?.call;
      }
    });

// Get the download URL
    String downloadURL = await ref.getDownloadURL();
    if (kDebugMode) {
      print('Download URL: $downloadURL');
    }

    return downloadURL;
  }


}
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]+$');
  return emailRegex.hasMatch(email);
}