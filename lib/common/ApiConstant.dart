class ApiConstant {
  static const baseUrl = 'https://shopping-app-backend-t4ay.onrender.com';

  static const userRegisterApi = '$baseUrl/user/registerUser';
  static const verifyOtpOnRegisterApi='$baseUrl/user/verifyOtpOnRegister';
  static const resendOtpApi='$baseUrl/user/resendOtp';
  static const userLoginApi = '$baseUrl/user/login';
  static const forgotPasswordApi='$baseUrl/user/forgotPassword';
  static const verifyOtpOnForgotPasswordApi='$baseUrl/user/verifyOtpOnForgotPassword';
  static const getAllProductApi='$baseUrl/product/getAllProduct';
}