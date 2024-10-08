import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;

class DataTablePage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'Name': 'Alice', 'Age': 30, 'City': 'New York'},
    {'Name': 'Bob', 'Age': 25, 'City': 'Los Angeles'},
    {'Name': 'Charlie', 'Age': 35, 'City': 'Chicago'},
  ];

  Future<void> _createExcel() async {
    // Create a new Excel document
    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];

    // Adding headers
    sheet.getRangeByName('A1').setValue('Name');
    sheet.getRangeByName('B1').setValue('Age');
    sheet.getRangeByName('C1').setValue('City');

    // Adding data
    for (int i = 0; i < data.length; i++) {
      sheet.getRangeByName('A${i + 2}').setValue(data[i]['Name']);
      sheet.getRangeByName('B${i + 2}').setValue(data[i]['Age']);
      sheet.getRangeByName('C${i + 2}').setValue(data[i]['City']);
    }

    // Save the Excel file
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Get the directory to save the file
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/data.xlsx';
    final File file = File(path);

    // Write the bytes to the file
    await file.writeAsBytes(bytes, flush: true);

    // Show a message or perform any action after saving
    print('Excel file created: ${file.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Age')),
                DataColumn(label: Text('City')),
              ],
              rows: data.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row['Name'])),
                  DataCell(Text(row['Age'].toString())),
                  DataCell(Text(row['City'])),
                ]);
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createExcel,
              child: Text('Convert to Excel'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: DataTablePage()));
}
