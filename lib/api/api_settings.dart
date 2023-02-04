class ApiSettings {
  static const String _baseUrl = 'http://tcbike.bulbul-app.com/api/v1';
  // AUTH
  static const String _auth = '$_baseUrl/user';
  static const String register = '$_auth/register';
  static const String login = '$_auth/login';
  static const String verify = '$_auth/verify';
  static const String resendCode = '$_auth/resendCode';
  static const String resetPassword = '$_auth/passwordReset';
  static const String googleLogin = '$_auth/authByGoogle';

  // HOME
  static const String home = '$_baseUrl/home';

  // Categories
  static const String categories = '$_baseUrl/getCategories';
  static const String subCategories = '$_baseUrl/getSubCategories';

  // Products
  static const String _products = '$_baseUrl/products';
  static const String productDetails = '$_products/getProductsById';
  static const String categoryProducts = '$_products/getProductsByCategory';
  static const String toggleFavorite = '$_products/addProductToFavorite';
  static const String readFavorites = '$_products/getProductsFavorite';

  // Orders
  static const String orders = '$_baseUrl/orders';
  static const String createOrders = '$_baseUrl/orders/store';
  static const String orderDetails = '$_baseUrl/orders/getOrderById';

  // Profile
  static const String updateProfile = '$_baseUrl/profile/updateProfile';
  static const String changePassword = '$_baseUrl/profile/changePassword';
  static const String getNotifications = '$_baseUrl/profile/getNotifications';

  // About
  static const String about = '$_baseUrl/about';
  static const String contactUs = '$_baseUrl/contactUs';
  static const String faqs = '$_baseUrl/getFaqs';
}
