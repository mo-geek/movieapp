import 'dart:async';
import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'package:dio/dio.dart';
import 'package:movieapp/core/constant/const.dart';
import 'package:movieapp/core/utility/shared_pref.dart';
import '../../ui/shared/toast/show_toast.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

enum MethodType { post, get, put, delete }

const Duration timeoutDuration = Duration(seconds: 15);

class DioRepository {
  Dio dio = Dio();

  // GET method
  Future<Either<dynamic, APIError>> get({
    required String url,
    String? token,
    Map<String, dynamic>? requestBody,
    Map<String, String> additionalHeaders = const <String, String>{},
  }) async {
    return await _hitApi(
      url: url,
      tokenVal: token,
      methodType: MethodType.get,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
    );
  }

  // Generic HTTP method
  Future<Either<dynamic, APIError>> _hitApi({
    required MethodType methodType,
    required String url,
    String? tokenVal,
    Map<String, dynamic>? requestBody,
    Map<String, String> additionalHeaders = const <String, String>{},
  }) async {
    final String? token =
        tokenVal ?? Preferences.getString(Constant.authTokenKey);
    try {
      final Map<String, String> headers = <String, String>{
        'Authorization': 'Bearer $token',
      };

      Response<dynamic> response;

      switch (methodType) {
        case MethodType.post:
          response = await dio
              .post<dynamic>(
                url,
                options: Options(
                  headers: headers,
                ),
                data: requestBody,
              )
              .timeout(timeoutDuration);

          break;
        case MethodType.get:
          response = await dio
              .get<dynamic>(url,
                  options: Options(
                    headers: headers,
                  ),
                  queryParameters: requestBody)
              .timeout(timeoutDuration);
          break;
        case MethodType.put:
          response = await dio
              .put<dynamic>(
                url,
                data: json.encode(requestBody),
                options: Options(
                  headers: headers,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case MethodType.delete:
          response = await dio
              .delete<dynamic>(
                url,
                options: Options(
                  headers: headers,
                ),
              )
              .timeout(timeoutDuration);
          break;
      }

      devtools.log("url: $url");
      devtools.log("api handler request body: $requestBody");
      // devtools.log("api handler response body: ${json.encode(response.info)}");
      devtools.log("api handler response code: ${response.statusCode}");

      return Left<dynamic, APIError>(response.data);
    } on DioError catch (e) {
      devtools.log("dio cath ${e.message}");
      devtools.log("error ${e.response?.statusCode}");
      devtools.log("message ${e.response?.data}");
      devtools.log("message ${e.response}");
      APIError error;
      if (e.response?.statusCode == 403) {
        error = APIError(
          error: parseError(e.response),
          status: 403,
          message: e.response?.data['status_message'],
        );
      } else if (e.response?.statusCode == 400) {
        error = APIError(
          error: (e.response?.data['message'] as Map<String, String>)
              .values
              .first[0]
              .toString(),
          message: e.response?.data['status_message'],
          status: e.response?.statusCode ?? 0,
        );
      } else if (e.response?.statusCode == 401) {
        devtools.log("Unauthenticated log out now");
        // todo logout && navigate to the login screen
        error = APIError(
          error: parseError(e.response),
          message: e.response?.data['status_message'],
          status: e.response?.statusCode ?? 0,
        );
      } else {
        error = APIError(
          error: 'check for connection !',
          message: e.response?.data['status_message'],
          status: e.response?.statusCode ?? 0,
        );
      }

      return Right<dynamic, APIError>(error);
    } on TimeoutException catch (e) {
      devtools.log("error ${e.toString()}");
      final APIError apiError =
          APIError(error: Messages.noInternetError, status: 500, message: null);
      showToast(message: 'check for internet connection');
      return Right<dynamic, APIError>(apiError);
    } catch (e) {
      devtools.log("error ${e.toString()}");
      final APIError apiError =
          APIError(error: Messages.genericError, status: 500, message: null);
      return Right<dynamic, APIError>(apiError);
    }
  }

  static String parseError(Response<dynamic>? response) {
    try {
      return "message: ${response?.data['status_message']} status:${response?.data['status_code']}";
    } catch (e) {
      return Messages.genericError;
    }
  }

  static String parseErrorMessage(dynamic response) {
    try {
      return response["message"].toString();
    } catch (e) {
      return Messages.genericError;
    }
  }
}

class APIError {
  APIError({
    required this.error,
    required this.status,
    required this.message,
  });

  APIError.fromJson(Map<String, dynamic> json)
      : error = 'error --',
        message = 'message --',
        status = 0 {
    error = json['error'].toString();
    message = json['message'];
  }
  String error;
  dynamic message;
  int status;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

class Messages {
  Messages._();
  static const String severNotFoundError = "Couldn't connect to the server.";
  static const String noInternetError =
      "Oops! Your internet is gone. Please check your internet connection";
  static const String timeoutError = "Request timeout";
  static const String genericError = "Something went wrong, please try again";
  static const String badFormatError = "Internal server error";
  static const String unAuthorizedError = "Unauthorized";

  // Success messages
  static const String profileUpdateSuccess = "Profile updated successfully";

  // Question messages
  static const String foundQuoteFormDataQuestion =
      "Previous details have not yet been completed, do you want to continue or create a new request?";
}
