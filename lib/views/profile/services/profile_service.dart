import 'dart:convert';
import 'package:meta/meta.dart';

import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../models/profile.dart';
import '../models/password_change.dart';

class ProfileService extends BaseService {
  final ApiClient client;

  ProfileService({@required this.client});

  Future<Profile> getProfile(String userName) async {
    try {
      final response = await client.get('/profiles/me/$userName');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<Profile>.fromJson(
          response.data,
          fromJsonModel: Profile.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
        return null;
      }
      log.e('Get error: Failed to get profile');
      return null;
    } catch (error) {
      log.e('Get error: Failed to get profile: ', error);
      return null;
    }
  }

  Future<ApiResponse<bool>> changePassword(PasswordChange passwordChange) async {
    try {
      final response = await client.patch(
        '/profiles/change-password/${passwordChange.userName}',
        data: jsonEncode(passwordChange.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Profile: Password has been changed');
        }
        return apiResponse;
      }
      log.e('Profile: Failed to change password');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Profile: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Profile: Failed to change password: ', error);
      return null;
    }
  }

  Future<ApiResponse<bool>> updateProfile(Profile profile) async {
    try {
      final response = await client.put(
        '/profiles/update/${profile.userName}',
        data: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Profile: Profile has been updated');
        }
        return apiResponse;
      }
      log.e('Profile: Failed to update profile');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Profile: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Profile: Failed to update profile: ', error);
      return null;
    }
  }
}
