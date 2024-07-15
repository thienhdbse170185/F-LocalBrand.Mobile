import 'package:dio/dio.dart';
import 'package:f_localbrand/config/interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio(BaseOptions(baseUrl: '${dotenv.env['API_URL']}'))
  ..interceptors.add(DioInterceptor());
