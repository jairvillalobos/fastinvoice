import 'package:fastinvoice/invoices/widgets/service_card.dart';
import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const InvoiceCard({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children:[
                Text('Invoice ID:${invoice['id'].toString()}',
                  style : const TextStyle(fontSize :18, fontWeight :FontWeight.bold)
                ),
                Text('Date:${invoice['fecha']}'),
              ]
            ),
            const SizedBox(height :16),
            const Text('Company Information',
              style : TextStyle(fontSize :18, fontWeight :FontWeight.bold)
            ),
            const SizedBox(height :8),
            Text('Name:${invoice['empresa']['nombre']}'),
            Text('TIN:${invoice['empresa']['nit']}'),
            const SizedBox(height :16),
            const Text('Operator Information',
              style : TextStyle(fontSize :18, fontWeight :FontWeight.bold)
            ),
            const SizedBox(height :8),
            Row(children:[
              const Icon(Icons.person),
              const SizedBox(width :8),
              Text(invoice['operador']['nombre']),
            ]),
            Text('Document Type:${invoice['operador']['tipo_documento']}'),
            Text('Document:${invoice['operador']['documento']}'),
            Text('Document Issuance City:${invoice['operador']['ciudad_expedicion_documento']}'),
            Row(children:[
              const Icon(Icons.phone),
              const SizedBox(width :8),
              Text(invoice['operador']['celular']),
            ]),
            Row(children:[
              const Icon(Icons.account_balance),
              const SizedBox(width :8),
              Text(invoice['operador']['banco']),
            ]),
            Text('Bank Account Number:${invoice['operador']['numero_cuenta_bancaria']}'),
            Text('Bank Account Type:${invoice['operador']['tipo_cuenta_bancaria']}'),
            const SizedBox(height :16),
            const Text('Services',
              style : TextStyle(fontSize :18, fontWeight :FontWeight.bold)
            ),
            const SizedBox(height :8),
            for (int i =0; i < invoice['servicios'].length; i++)
              ServiceCard(service: invoice['servicios'][i]),
          ]
        ),
      ),
    );
  }
}
