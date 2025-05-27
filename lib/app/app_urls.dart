class AppUrls{
  static const String _baseUrl='https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl='$_baseUrl/auth/signup';
  static const String verifyOtpUrl='$_baseUrl/auth/verify-otp';
  static const String signInUrl='$_baseUrl/auth/login';
  static const String sliderUrl='$_baseUrl/slides';
  static const String categoryListUrl='$_baseUrl/categories';
  static const String productListUrl='$_baseUrl/products';
  static String productDetailsUrl(String productId)=>'$_baseUrl/products/id/$productId';
  static const String addToCartUrl='$_baseUrl/cart';
  static const String cartListUrl='$_baseUrl/cart';
  static String deleteFromCartListUrl(String id) => '$_baseUrl/cart/$id';
  static const String addToWishUrl='$_baseUrl/wishlist';
  static const String wishListUrl='$_baseUrl/wishlist';
  static const String reviewListUrl='$_baseUrl/reviews';
  static const String newProductListUrl='$_baseUrl/products';
  static const String createReviewUrl='$_baseUrl/review';
}