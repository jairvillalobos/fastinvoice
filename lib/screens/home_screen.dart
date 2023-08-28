import 'package:fastinvoice/invoices/screens/invoice_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fastinvoice/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final String userToken;

  const HomeScreen({Key? key, required this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: const Center(
        child: Text('Pantalla de inicio'),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        onItemTapped: (int index) {
          if (index == 1) {
            // Navega a la pantalla de facturas y pasa el token de usuario
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InvoiceListScreen(token: userToken),
              ),
            );
          }
        },
      ),
    );
  }
}
