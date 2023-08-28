import 'package:fastinvoice/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FastInvoice());

class FastInvoice extends StatelessWidget {
  const FastInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastInvoice',
      initialRoute: AppRoutes.loginScreen,
      routes: AppRoutes.routes,
    );
  }
}
