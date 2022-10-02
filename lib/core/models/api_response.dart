import 'package:meta/meta.dart';

class ApiResponse<T> {
  final bool success;
  final T result;
  final String message;

  ApiResponse({
    @required this.success,
    this.result,
    this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, {Function fromJsonModel}) {
    return ApiResponse(
      success: json['success'],
      result: json['result'] != null
          ? fromJsonModel != null
              ? fromJsonModel(json['result'])
              : json['result']
          : null,
      message: json['message'],
    );
  }
}

class ApiListResponse<T> {
  final bool success;
  final List<T> result;
  final String message;

  ApiListResponse({
    @required this.success,
    this.result,
    this.message,
  });

  factory ApiListResponse.fromJson(Map<String, dynamic> json, {Function fromJsonModel}) {
    return ApiListResponse(
      success: json['success'],
      result: json['result'] != null
          ? fromJsonModel != null
              ? List<T>.from((json['result'] as List).map((itemsJson) => fromJsonModel(itemsJson)))
              : json['result']
          : [],
      message: json['message'],
    );
  }
}

class PagedList<T> {
  final List<T> items;
  final int count;

  PagedList({@required this.items, @required this.count});

  factory PagedList.fromJson(Map<String, dynamic> json, {Function fromJsonModel}) {
    return PagedList(
      items: List<T>.from((json['items'] as List).map((itemsJson) => fromJsonModel(itemsJson))),
      count: json['count'],
    );
  }
}

class ApiPagedResponse<T> {
  final bool success;
  final PagedList<T> result;
  final String message;

  ApiPagedResponse({
    @required this.success,
    this.result,
    this.message,
  });

  factory ApiPagedResponse.fromJson(Map<String, dynamic> json, {Function fromJsonModel}) {
    return ApiPagedResponse(
      success: json['success'],
      result: json['result'] != null && fromJsonModel != null
          ? PagedList.fromJson(json['result'], fromJsonModel: fromJsonModel)
          : null,
      message: json['message'],
    );
  }
}
