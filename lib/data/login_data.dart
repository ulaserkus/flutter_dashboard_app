import 'package:dio/dio.dart';

class LoginData {
  static  postDataWithDio(String username, String password)async {
   final Dio _dio = new Dio();
    _dio.options.contentType = Headers.acceptHeader;
    _dio.options.contentType = Headers.jsonContentType;

    var data = {"username": username, "password": password};

    Response responseData = await _dio.post<Map<String, dynamic>>('/api/auth/login',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            baseUrl: 'https://10.0.2.2:5001'),
        data: data);

    return responseData;
  }
}
