import 'dart:io';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Export to Excel Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExcelExportPage(),
    );
  }
}

class ExcelExportPage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {"Name": "John Doe", "Age": 28, "Email": "john@example.com"},
    {"Name": "Jane Smith", "Age": 34, "Email": "jane@example.com"},
    {"Name": "Mike Johnson", "Age": 45, "Email": "mike@example.com"},
  ];

  void _exportToExcel(BuildContext context) async {
    var excel = Excel.createExcel(); // Create a new Excel file
    Sheet sheet = excel['Sheet1'];

    // Add headers
    sheet.appendRow([
      CellValueString('Name'),
      CellValueNumber(0),  // Dummy value for type consistency
      CellValueString('Email')
    ]);

    // Add data
    for (var item in data) {
      sheet.appendRow([
        CellValueString(item['Name']),  // Correctly using CellValueString
        CellValueNumber(item['Age']),    // Correctly using CellValueNumber
        CellValueString(item['Email']),  // Correctly using CellValueString
      ]);
    }

    // Get the directory to save the file
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/exported_data.xlsx";

    // Save the file
    var bytes = excel.save();
    if (bytes != null) {
      File(path).writeAsBytesSync(bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Excel file saved at: $path")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to save the Excel file.")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Export to Excel Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _exportToExcel(context),
          child: Text('Export to Excel'),
        ),
      ),
    );
  }
}
