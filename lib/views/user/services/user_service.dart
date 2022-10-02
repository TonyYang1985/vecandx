import 'dart:convert';
import 'package:meta/meta.dart';

import '../../../core/models/paged_query.dart';
import '../../../core/models/activation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../models/user_role_assign.dart';
import '../models/user.dart';

class UserService extends BaseService {
  final String basePath = '/users';

  final ApiClient client;

  UserService({@required this.client});

  Future<PagedList<User>> getPagedUserList(PagedQuery pagedQuery) async {
    final emptyList = PagedList<User>(items: [], count: 0);
    try {
      final response = await client.get('$basePath/list', queryParameters: pagedQuery.toJson());

      if (response.statusCode == 200) {
        var apiResponse = ApiPagedResponse<User>.fromJson(
          response.data,
          fromJsonModel: User.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      return emptyList;
    } catch (error) {
      log.e('Get error: Failed to fetch user list', error);
      return emptyList;
    }
  }

  Future<bool> assignRole(UserRoleAssign userRoleAssign) async {
    try {
      final response = await client.patch(
        '$basePath/assign-role/${userRoleAssign.userId}',
        data: jsonEncode(userRoleAssign.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Patch error: Failed to assign user role');
      return null;
    } catch (error) {
      log.e('Patch error: Failed to assign user role', error);
      return null;
    }
  }

  Future<bool> toggleActivation(Activation activation) async {
    try {
      final response = await client.patch(
        '$basePath/activate/${activation.id}',
        data: jsonEncode(activation.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Patch error: Failed to ${activation.isActive ? 'activate' : 'deactivate'} user');
      return null;
    } catch (error) {
      log.e('Patch error: Failed to ${activation.isActive ? 'activate' : 'deactivate'} user', error);
      return null;
    }
  }

  Future<bool> resetPassword(String userName) async {
    try {
      final response = await client.patch('$basePath/reset-password/$userName');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Patch error: Failed to reset user password');
      return null;
    } catch (error) {
      log.e('Patch error: Failed to reset user password', error);
      return null;
    }
  }

  Future<bool> unlockUser(String userName) async {
    try {
      final response = await client.patch('$basePath/unlock/$userName');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Patch error: Failed to unlock user');
      return null;
    } catch (error) {
      log.e('Patch error: Failed to unlock user', error);
      return null;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      final response = await client.delete('$basePath/delete/$userId');
      if (response.statusCode == 200) {
        var apiResponse = ApiResponse.fromJson(response.data);
        return apiResponse.success;
      }
      log.e('Delete error: Failed to delete user');
      return false;
    } catch (error) {
      log.e('Delete error: Failed to delete user', error);
      return false;
    }
  }
}
