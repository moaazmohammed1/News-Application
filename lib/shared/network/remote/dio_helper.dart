import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<dynamic> getData({
    required String url,
    required dynamic query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=85aff49ad9d34837834d937bd20ce637

// 'country':'eg',
// 'category':'business',
// 'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
