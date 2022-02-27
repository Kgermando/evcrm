import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageItemWidget extends StatefulWidget {
  const ImageItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  _ImageItemWidgetState createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async{
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              File file = File(result.files.single.path!);
            } else {
              // User canceled the picker
            }
          } , 
          child: const Text('Image upload')
        ),
      ],
    );
  }
}