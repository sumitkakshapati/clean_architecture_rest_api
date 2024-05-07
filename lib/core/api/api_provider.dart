// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture_template/core/model/failure.dart';
import 'package:http_parser/http_parser.dart' as parse;
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

class ApiProvider {
  final Dio dio;

  ApiProvider({required this.dio});

  Future<Map<String, dynamic>> post(
    String url,
    dynamic body, {
    Map<String, dynamic>? queryParam,
    bool isRefreshRequest = false,
  }) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };

      final dynamic response = await dio.post(
        url,
        data: body,
        queryParameters: queryParam,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic body,
      {bool isRefreshRequest = false}) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.patchUri(Uri.parse(url),
          data: body, options: Options(headers: header));
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {bool isRefreshRequest = false}) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.putUri(Uri.parse(url),
          data: body, options: Options(headers: header));
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> get(String url,
      {bool isRefreshRequest = false,
      Map<String, dynamic>? queryParams}) async {
    dynamic responseJson;

    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.get(url,
          options: Options(
            headers: header,
          ),
          queryParameters: queryParams);

      responseJson = _response(response, url, cacheResult: true);
    } on DioException catch (e, s) {
      responseJson = await _handleErrorResponse(e);
      Logger().e(e);
      Logger().d(s);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {dynamic body}) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.deleteUri(Uri.parse(url),
          data: body, options: Options(headers: header));
      responseJson = await _response(response, url);
      responseJson['status'] = response.statusCode;
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  upload(String url, File file) async {
    try {
      final Map<String, String> header = {
        'accept': 'application/json',
        'origin': '*',
      };
      final String fileName = file.path.split('/').last;
      // final String _extention = file.path.split('.').last;
      final String type = lookupMimeType(file.path)!.split('/').first;
      if (kDebugMode) {
        print(type);
      }

      final FormData formData = FormData.fromMap(<String, dynamic>{
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: parse.MediaType('image', file.path.split('.').last),
        ),
      });
      final Response<dynamic> response = await dio.post<dynamic>(url,
          data: formData, options: Options(headers: header));

      if (kDebugMode) {
        print(response.data.toString());
      }
      return _response(response, url);
    } on DioException catch (e) {
      Logger().e(e);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _handleErrorResponse(DioException e) async {
    if (e.toString().toLowerCase().contains("socketexception")) {
      throw ServerFailure(message: 'No Internet connection');
    } else {
      if (e.response != null) {
        return await _response(e.response!, "");
      } else {
        throw ServerFailure(message: 'An error occurred while fetching data.');
      }
    }
  }

  Future<Map<String, dynamic>> _response(Response response, String url,
      {bool cacheResult = false}) async {
    final Map<String, dynamic> res = response.data is Map ? response.data : {};
    final responseJson = <String, dynamic>{};
    responseJson['data'] = res;

    responseJson['statusCode'] = response.statusCode;
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return responseJson;
      case 400:
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      case 401:
      case 402:
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      case 403:
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      case 404:
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      case 409:
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      case 422:
        responseJson['error'] = getErrorMessage(res);
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      case 500:
        throw ServerFailure(
          message: getErrorMessage(res),
          statusCode: response.statusCode,
        );
      default:
        throw ServerFailure(
          message: 'Error occured while Communication with Server',
          statusCode: response.statusCode,
        );
    }
  }

  String getErrorMessage(dynamic res) {
    String message = "";
    try {
      debugPrint("-------------------GET ERROR ------------------");
      message = switch (res) {
        {"message": List message} when message.isNotEmpty =>
          message.length == 1 ? message.first.toString() : message.join("\n "),
        {"message": String message} => message,
        {"error": {"message": String message}} => message,
        _ => "Error Occured!!",
      };
    } catch (e) {
      return message;
    }
    return message;
  }
}
