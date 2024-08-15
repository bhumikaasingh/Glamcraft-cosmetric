class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/v1/"; emuletor
  static const String baseUrl = "http://192.168.1.124:5500/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String getProducts = "products/get_all_products";
  static const limitPage = 5;

  static const String imageUrl = "http://10.1.16.134:5500/uploads/";
  static const String uploadImage = "auth/uploadImage";
}
