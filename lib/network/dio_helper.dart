import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  // ........................   init Method ....................................

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );

  }


// .................... static Future<Response> getData .......................

  // Function Get Dat
  static Future<Response> getData (
      {
        required String url,
        required Map<String,dynamic> query,
      })async
  {
    /*
    url is a Method such as   v2/top-headlines
    query write a Map such as
            country=eg&category=business&apiKey=1e2e3ea56c7743d39065949c6d8e18da
     */
    return await dio.get(url,queryParameters: query);
  }
// ....................... static Future<Response> postData  ...................

  static Future<Response> postData(
      {
        required String url,
        Map<String, dynamic>? query,
        Map<String, dynamic>? data,
        String lang = 'en',
        String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


// .....................   static Future<Response> putData ....................

  static Future<Response> putData(
      {required String url,
        Map<String, dynamic>? query,
        Map<String, dynamic>? data,
        String lang = 'en',
        String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }


// ..................     static Future<Response> deleteData   ..................

  static Future<Response> deleteData(
      {
        required String url, String lang = 'en', String? token
      }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.delete(url);
  }


}
