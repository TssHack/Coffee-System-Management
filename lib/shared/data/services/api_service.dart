import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';

class ApiService {
  static String? _token;

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // تنظیم توکن برای درخواست‌های ادمین
  static void setToken(String? token) {
    _token = token;
    _dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : null;
  }

  static Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static String _handleError(DioException e) {
    switch (e.type) {
      case DioException.connectionTimeout:
      case DioException.sendTimeout:
      case DioException.receiveTimeout:
        return 'ارتباط با سرور قطع شد';
      case DioException.connectionError:
        return 'امکان اتصال به سرور وجود ندارد';
      case DioException.badResponse:
        final msg = e.response?.data?['message'];
        if (msg != null) return msg.toString();
        return 'خطای سرور (کد ${e.response?.statusCode})';
      default:
        return 'خطای پیش‌بینی نشده';
    }
  }
}