class ApiConstant {
  static const baseUrl = 'https://shopping-app-backend-t4ay.onrender.com';

  static const userRegisterApi = '$baseUrl/user/registerUser';
  static const verifyOtpOnRegisterApi='$baseUrl/user/verifyOtpOnRegister';
  static const resendOtpApi='$baseUrl/user/resendOtp';
  static const userLoginApi = '$baseUrl/user/login';
  static const forgotPasswordApi='$baseUrl/user/forgotPassword';
  static const verifyOtpOnForgotPasswordApi='$baseUrl/user/verifyOtpOnForgotPassword';
  static const getAllProductApi='$baseUrl/product/getAllProduct';
  static const addToWatchListApi='$baseUrl/watchList/addToWatchList';
  static const removeFromWatchListApi='$baseUrl/watchList/removeFromWatchList';
  static const getWatchListApi='$baseUrl/watchList/getWatchList';
  static const addToCartApi='$baseUrl/cart/addToCart';
  static const increaseProductQuantityApi='$baseUrl/cart/increaseProductQuantity';
  static const decreaseProductQuantityApi='$baseUrl/cart/decreaseProductQuantity';
  static const removeProductFromCartApi='$baseUrl/cart/removeProductFromCart';
  static const getMyCartApi='$baseUrl/cart/getMyCart';
  static const placeOrderApi='$baseUrl/order/placeOrder';
  static const getOrderHistoryApi='$baseUrl/order/getOrderHistory';
}