import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvoiceList extends StatefulWidget {
  final String token;

  const InvoiceList({Key? key, required this.token}) : super(key: key);

  @override
  InvoiceListState createState() => InvoiceListState();
}

class InvoiceListState extends State<InvoiceList> {
  final String apiUrl = 'http://10.0.2.2:8000/v1/invoices';
  int page = 1;
  int limit = 10;
  bool isLoading = false;
  List invoices = [];
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchInvoices();
    _controller.addListener(() {
      if (!isLoading &&
          _controller.position.pixels == _controller.position.maxScrollExtent &&
          page <= totalPages) {
        fetchInvoices();
      }
    });
  }

  Future<void> fetchInvoices() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var response = await http.get(
        Uri.parse('$apiUrl?page=$page&limit=$limit'),
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          isLoading = false;
          invoices.addAll(data['invoices']);
          totalPages = data['total_pages'];
          page++;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Invoices'),
        ),
        body: ListView.builder(
  itemCount: invoices.length + (page <= totalPages ? 1 : 0),
  itemBuilder: (context, index) {
    if (index == invoices.length) {
      return _buildProgressIndicator();
    } else {
      final invoice = invoices[index];
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invoice ID: ${invoice['id'].toString()}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Date: ${invoice['fecha']}'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Company Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Name: ${invoice['empresa']['nombre']}'),
              Text('TIN: ${invoice['empresa']['nit']}'),
              const SizedBox(height: 16),
              const Text(
                'Operator Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children:[
                  const Icon(Icons.person),
                  const SizedBox(width :8),
                  Text(invoice['operador']['nombre']),
                ]
              ),
              Text('Document Type: ${invoice['operador']['tipo_documento']}'),
              Text('Document: ${invoice['operador']['documento']}'),
              Text('Document Issuance City: ${invoice['operador']['ciudad_expedicion_documento']}'),
              Row(
                children:[
                  const Icon(Icons.phone),
                  const SizedBox(width :8),
                  Text(invoice['operador']['celular']),
                ]
              ),
              Row(
                children:[
                  const Icon(Icons.account_balance),
                  const SizedBox(width :8),
                  Text(invoice['operador']['banco']),
                ]
              ),
              Text('Bank Account Number: ${invoice['operador']['numero_cuenta_bancaria']}'),
              Text('Bank Account Type: ${invoice['operador']['tipo_cuenta_bancaria']}'),
              const SizedBox(height :16),
              const Text(
                'Services',
                style : TextStyle(fontSize :18, fontWeight :FontWeight.bold)
              ),
              const SizedBox(height :8),
              for (int i = 0; i < invoice['servicios'].length; i++)
                Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children:[
                    Row(
                      children:[
                        const Icon(Icons.description),
                        const SizedBox(width :8),
                        Expanded(child:
                          Text(invoice['servicios'][i]['descripcion']),
                        ),
                      ]
                    ),
                    Row(
                      children:[
                        const Icon(Icons.attach_money),
                        const SizedBox(width :8),
                        Text(invoice['servicios'][i]['valor'].toString()),
                      ]
                    )
                  ]
                ),
            ],
          ),
        ),
      );
    }
  },
  controller:_controller,
)

);
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
