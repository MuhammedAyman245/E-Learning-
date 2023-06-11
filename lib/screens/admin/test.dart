import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Test extends StatefulWidget {
  static const String id = 'Test';

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  File file;
  pickFile() async {
    FilePickerResult _file = await FilePicker.platform.pickFiles();
    if (_file != null) {
      File tempFile = File(_file.files.single.path);
      setState(() {
        file = tempFile;
      });
      print(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        TextButton(
            onPressed: () {
              pickFile();
            },
            child: Text('Pick A file'))
      ],
    ));
  }
}
