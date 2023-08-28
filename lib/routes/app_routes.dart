import 'package:fastinvoice/authentication/screens/login_screen.dart';
import 'package:fastinvoice/authentication/screens/register_screen.dart';
//import 'package:fastinvoice/invoices/screens/invoice_list_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String invoiceListScreen = '/invoice_list_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    //invoiceListScreen: (context) => const InvoiceList(),
  };
}
