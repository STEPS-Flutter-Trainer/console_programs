import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadDownloadPage extends StatefulWidget {
  @override
  _FileUploadDownloadPageState createState() => _FileUploadDownloadPageState();
}

class _FileUploadDownloadPageState extends State<FileUploadDownloadPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      try {
        await _storage.ref('uploads/${result.files.single.name}').putFile(file);
        print('File uploaded successfully');
      } catch (e) {
        print('File upload failed: $e');
      }
    }
  }

  Future<void> _downloadFile(String fileName) async {
    try {
      String downloadURL = await _storage.ref('uploads/$fileName').getDownloadURL();
      // Implement the logic to download the file using the download URL
      print('Download URL: $downloadURL');
    } catch (e) {
      print('File download failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase File Upload and Download')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _downloadFile('your_file_name'), // Replace with your file name
              child: Text('Download File'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: FileUploadDownloadPage()));
}
