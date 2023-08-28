import 'package:fastinvoice/invoices/services/invoice_service.dart';

class InvoiceController {
  static Future<Result<Map<String, dynamic>, String>> fetchInvoices({
    required String token,
    required int page,
    required int limit,
  }) async {
    return await InvoiceService.fetchInvoices(
      token: token,
      page: page,
      limit: limit,
    );
  }
}
