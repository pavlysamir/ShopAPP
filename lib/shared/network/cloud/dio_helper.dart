import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          // followRedirects: false,
          validateStatus: (status) => true,
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
          receiveTimeout: 180 * 1000,
          connectTimeout: 180 * 1000,
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
        }
      ),
    );
  }

  // static Future<Response>getData({
  //   required url,
  //   Map<String, dynamic>? Query,
  //   String? token,
  //   String lang = 'en',
  // }) async {
  //   return await dio!.get(url, queryParameters: Query);
  // }
  static Future<Response> getData({
    required String url,
    String lang = 'en',
    required String token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> PostData({
    required String url,
    Map<String, dynamic>? Query,
    required Map<String, dynamic> data,
    String? token,
    String lang = 'en',
  }) async {
    dio!.options.headers = {
      'Authorization': token,
      'lang': lang,
      'Content-Type': 'application/json'
    };
    return await dio!.post(url, queryParameters: Query, data: data);
  }

  static Future<Response> PutData({
    required String url,
    Map<String, dynamic>? Query,
    required Map<String, dynamic> data,
    String? token,
    String lang = 'en',
  }) async {
    dio!.options.headers = {
      'Authorization': token,
      'lang': lang,
      'Content-Type': 'application/json'
    };
    return await dio!.put(url, queryParameters: Query, data: data);
  }
}
