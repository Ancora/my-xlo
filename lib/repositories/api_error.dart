import 'package:flutter/foundation.dart';

class ApiError {
  @required
  final int code;
  @required
  final String message;

  ApiError({this.code, this.message});
}
