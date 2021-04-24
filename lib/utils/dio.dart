import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(
  baseUrl: 'http://stepin.btwbs.com/api/',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = Dio(options);
