import 'package:flutter/material.dart';

void main() {
  runApp(BillCalculatorApp());
}

class BillCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Calculator (INR)',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BillCalculatorScreen(),
    );
  }
}

class BillCalculatorScreen extends StatefulWidget {
  @override
  _BillCalculatorScreenState createState() => _BillCalculatorScreenState();
}

class _BillCalculatorScreenState extends State<BillCalculatorScreen> {
  final List<Map<String, dynamic>> _items = [];
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final double _gstRate = 18.0; // GST Rate in percentage

  void _addItem() {
    final String itemName = _itemController.text;
    final double? price = double.tryParse(_priceController.text);
    final int? quantity = int.tryParse(_quantityController.text);

    if (itemName.isNotEmpty && price != null && quantity != null) {
      setState(() {
        _items.add({
          'name': itemName,
          'price': price,
          'quantity': quantity,
        });
      });
      _itemController.clear();
      _priceController.clear();
      _quantityController.clear();
    }
  }

  double _calculateSubtotal() {
    return _items.fold(0.0, (total, item) => total + (item['price'] * item['quantity']));
  }

  double _calculateGST() {
    return _calculateSubtotal() * _gstRate / 100;
  }

  double _calculateTotal() {
    return _calculateSubtotal() + _calculateGST();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Calculator (INR)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price (INR)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text('Price: ₹${item['price']} x ${item['quantity']}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Subtotal: ₹${_calculateSubtotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'GST (18%): ₹${_calculateGST().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total: ₹${_calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
