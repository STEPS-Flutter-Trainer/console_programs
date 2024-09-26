import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DataTablePage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'Name': 'Alice', 'Age': 30, 'City': 'New York'},
    {'Name': 'Bob', 'Age': 25, 'City': 'Los Angeles'},
    {'Name': 'Charlie', 'Age': 35, 'City': 'Chicago'},
  ];

  void _createPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(children: [
                pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('Age', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('City', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ]),
              ...data.map((row) {
                return pw.TableRow(children: [
                  pw.Text(row['Name']),
                  pw.Text(row['Age'].toString()),
                  pw.Text(row['City']),
                ]);
              }).toList(),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
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
              onPressed: () => _createPdf(context),
              child: Text('Convert to PDF'),
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
