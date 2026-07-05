import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  ApiService({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  //CRUD METHODS

  //get
  Future<dynamic> Get(String endPoint,{dynamic params}) async {
    try {
      final response = await _dioClient.dio.get(endPoint,queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  //post
  Future<dynamic> post(String endPoint, dynamic body, [Map<String, dynamic>? headers]) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  //put
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  //delete
  Future<dynamic> delete(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}
