import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InterceptorDioTarefas extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var appId = dotenv.get("APPLICATIONID");
    var apiKey = dotenv.get("APIKEY");

    if (options.method == "GET" || options.method == "POST") {
      options.headers = {
        "X-Parse-Application-Id": appId,
        "X-Parse-REST-API-Key": apiKey,
        "Content-Type": "application/json"
      };
    } else {
      options.headers = {
        "X-Parse-Application-Id": appId,
        "X-Parse-REST-API-Key": apiKey,        
      };
    }

    super.onRequest(options, handler);
  }
}
