import 'dart:convert';
import 'package:fastinvoice/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

class Result<T, E> {
  final T? value;
  final E? error;

  Result({this.value, this.error});

  bool get isSuccess => value != null;
  bool get isError => error != null;
}

class InvoiceService {
  

  static Future<Result<Map<String, dynamic>, String>> fetchInvoices({
    required String token,
    required int page,
    required int limit,
  }) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiEndpoints.invoice}?page=$page&limit=$limit'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return Result(value: json.decode(response.body));
      } else if (response.statusCode == 404) {
        return Result(error: 'No invoices found');
      } else {
        var error = json.decode(response.body);
        return Result(error: 'Failed to fetch invoices: ${error['message']}');
      }
    } catch (e) {
      return Result(error: 'An unexpected error occurred');
    }
  }
}
