import 'package:fastinvoice/invoices/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fastinvoice/invoices/controllers/invoice_controller.dart';
import 'package:fastinvoice/invoices/widgets/invoice_card.dart';

class InvoiceList extends StatefulWidget {
  final String token;

  const InvoiceList({Key? key, required this.token}) : super(key: key);

  @override
  InvoiceListState createState() => InvoiceListState();
}

class InvoiceListState extends State<InvoiceList> {
  int page = 1;
  int limit = 10;
  bool isLoading = false;
  List invoices = [];
  int totalPages = 1;
  String? errorMessage;

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

      var result = await InvoiceController.fetchInvoices(
        token: widget.token,
        page: page,
        limit: limit,
      );

      if (result.isSuccess) {
        var data = result.value!;
        setState(() {
          isLoading = false;
          invoices.addAll(data['invoices']);
          totalPages = data['total_pages'];
          page++;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = result.error;
        });
      }
    }
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    } else {
      return ListView.builder(
        itemCount: invoices.length + (page <= totalPages ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == invoices.length) {
            return _buildProgressIndicator();
          } else {
            final invoice = invoices[index];
            return InvoiceCard(invoice: invoice);
          }
        },
        controller: _controller,
      );
    }
  }

  Widget _buildProgressIndicator() {
    return LoadingIndicator(isLoading: isLoading);
  }
}
