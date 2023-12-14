import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

class ChooseFile extends StatefulWidget {
  final void Function(File) onFileChoosen;

   Color color;
  ChooseFile({super.key, required this.onFileChoosen, this.color = Colors.white});

  @override
  State<ChooseFile> createState() => _ChooseFileState();
}

class _ChooseFileState extends State<ChooseFile> {
  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  void _checkPermissionStatus() async {
    _permissionStatus = await Permission.storage.status;
    setState(() {});
  }

  void _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {});
    }
  }

  void _launchFilePicker() async {
    if (_permissionStatus.isGranted) {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        final File file = File(result.files.single.path!);

        widget.onFileChoosen(file);
      }
      else{
        if (kDebugMode) {
          print("null");
        }
      }
    } else {
      _requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.greenAccent,
                  width: 2.0,
                ),
              ),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                margin:  const EdgeInsets.all(0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: _launchFilePicker,
                  child:Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Choose a picture',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                          color: widget.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );




  }
}


