import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token =
        prefs.getString('jwtToken'); // Retrieve the token from storage
    print(token);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle the error (e.g., token expiration, etc.)
    // You might want to refresh the token here and retry the request
    return super.onError(err, handler);
  }
}
