import 'package:dio/dio.dart';
import 'package:hungry/core/utiles/pref_helpers.dart';

class DioClient {
  factory DioClient() => _instance;

  DioClient._internal() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelpers.getToken();
          if (token != null && token.isNotEmpty && token != "guest") {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  static final DioClient _instance = DioClient._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Dio get dio => _dio;
}
