import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class ErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) return _fromDio(error);
    if (error is TimeoutException) {
      return 'Request timed out. Please try again.';
    }
    if (error is SocketException) {
      return 'No internet connection. Please check your network.';
    }
    return 'Something went wrong. Please try again.';
  }

  static String _fromDio(DioException e) {
    // 1. Try to extract message from server response
    final serverMessage = _extractServerMessage(e.response?.data);
    if (serverMessage != null) return serverMessage;

    // 2. Map by status code if response exists
    if (e.response != null) return _fromStatusCode(e.response!.statusCode);

    // 3. Map by Dio error type
    return _fromDioErrorType(e.type);
  }

  static String? _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      for (final key in const ['message', 'error', 'msg', 'code']) {
        final value = data[key];
        if (value != null && value.toString().trim().isNotEmpty) {
          // If it's a code, we might want to map it, but usually 'message' is better
          if (key == 'code') return _mapStatusCodeToMessage(int.tryParse(value.toString()));
          return value.toString();
        }
      }
    }
    if (data is String && data.trim().isNotEmpty) return data;
    return null;
  }

  static String _fromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your inputs.';
      case 401:
        return 'Unauthorized. Please sign in again.';
      case 403:
        return 'You are not allowed to perform this action.';
      case 404:
        return 'Resource not found.';
      case 409:
        return 'Conflict with existing data.';
      case 422:
        return 'Submitted data does not meet requirements.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'Unexpected error ($statusCode). Please try again.';
    }
  }

  static String _mapStatusCodeToMessage(int? statusCode) {
    return _fromStatusCode(statusCode);
  }

  static String _fromDioErrorType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please connect and try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        return 'Secure connection failed.';
      case DioExceptionType.badResponse:
        return 'Received an invalid response from the server.';
      case DioExceptionType.unknown:
        return 'Network error. Please try again.';
    }
  }
}
