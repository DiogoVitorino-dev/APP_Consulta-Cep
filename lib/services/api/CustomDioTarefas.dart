import 'package:bootcamp_flutter/services/api/InterceptorDioTarefas.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDioTarefas {
  final Dio _dio = Dio();

  CustomDioTarefas() {
    var baseUrl = dotenv.get("BASEURL");

    if (baseUrl.isEmpty) {
      throw "MISSING BASEURL VALUE AT ENVIRONMENT VARIABLES";
    }
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(InterceptorDioTarefas());
  }

  Dio get getInstance => _dio;
}
