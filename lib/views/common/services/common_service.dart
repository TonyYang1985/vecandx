import 'dart:convert';
import 'package:meta/meta.dart';

import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';

class CommonService extends BaseService {
  final ApiClient client;

  CommonService({@required this.client});

  Future<ApiResponse<bool>> verifyPassword(String password) async {
    try {
      final response = await client.post(
        '/auth/verify/password',
        data: jsonEncode({'password': password}),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Authentication: Password has been verified');
        }
        return apiResponse;
      }
      log.e('Authentication: Failed to verify password');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Authentication: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Authentication: Failed to verify password: ', error);
      return null;
    }
  }
}
