class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  static const String baseUrl = "http://192.168.1.124:5500/";
  // static const String baseUrl = "http://192.168.1.103:5500/api/";
  // ====================== Auth Routes ======================
  static const String login = "api/user/login";
  static const String register = "api/user/create";
  static const String getProducts = "api/products/get_all_products";
  static const limitPage = 5;

  static const String getSingleProduct = "api/products/get_single_product/";
  static const String getCategories = "api/categories";
  static const String getReviews = "api/reviews/";
  static const String createReview = "api/reviews/create";
  static const String createOrder = "api/orders/create";
  static const String getOrders = "api/orders";
  static const String getSingleOrder = "api/orders/";
  static const String getCart = "api/carts";
  static const String createCart = "api/carts/create";
  static const String updateUserProfile = "api/user/update-profile/";

  static const String imageUrl = "http://10.1.16.134:5500/uploads/";
  static const String uploadImage = "auth/uploadImage";

  static const String userId = "66847f3cb51bc68060b9ff86";
}
