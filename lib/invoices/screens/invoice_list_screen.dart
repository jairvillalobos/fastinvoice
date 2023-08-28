import 'package:flutter/material.dart';
import 'package:fastinvoice/invoices/widgets/invoice_list.dart';

class InvoiceListScreen extends StatelessWidget {
  final String token;

  const InvoiceListScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: InvoiceList(token: token),
    );
  }
}
