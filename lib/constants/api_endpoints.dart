class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8000/v1';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String invoice = '$baseUrl/invoices';
  static const String logout = '$baseUrl/logout'; // nuevo endpoint
  static const String userProfile = '$baseUrl/user/profile'; // nuevo endpoint
  // define other API endpoints here...
}
