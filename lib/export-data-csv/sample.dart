import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class DataTablePage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'Name': 'Alice', 'Age': 30, 'City': 'New York'},
    {'Name': 'Bob', 'Age': 25, 'City': 'Los Angeles'},
    {'Name': 'Charlie', 'Age': 35, 'City': 'Chicago'},
  ];

  Future<void> _createCsv() async {
    List<List<dynamic>> rows = [];
    rows.add(['Name', 'Age', 'City']); // Header row

    // Add data rows
    for (var row in data) {
      rows.add([row['Name'], row['Age'], row['City']]);
    }

    String csv = const ListToCsvConverter().convert(rows);

    // Save the CSV file
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/data.csv';
    final File file = File(path);

    await file.writeAsString(csv);

    // Show a message or perform any action after saving
    print('CSV file created: ${file.path}');
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
              onPressed: _createCsv,
              child: Text('Convert to CSV'),
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
