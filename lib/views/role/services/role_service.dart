import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:vecandx/core/models/dropdown_item.dart';

import '../../../core/models/activation.dart';
import '../../../core/models/paged_query.dart';
import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../models/role_edit.dart';
import '../models/role_add.dart';
import '../models/role.dart';

class RoleService extends BaseService {
  final String basePath = '/roles';

  final ApiClient client;

  RoleService({@required this.client});

  Future<PagedList<Role>> getPagedRoleList(PagedQuery pagedQuery) async {
    final emptyList = PagedList<Role>(items: [], count: 0);
    try {
      final response = await client.get('$basePath/list', queryParameters: pagedQuery.toJson());

      if (response.statusCode == 200) {
        var apiResponse = ApiPagedResponse<Role>.fromJson(
          response.data,
          fromJsonModel: Role.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      return emptyList;
    } catch (error) {
      log.e('Get error: Failed to fetch role list', error);
      return emptyList;
    }
  }

  Future<List<DropdownItem<dynamic>>> getRoleDropdownList() async {
    final roles = <DropdownItem<dynamic>>[];
    try {
      final response = await client.get('$basePath/dropdown-list');

      if (response.statusCode == 200) {
        var apiResponse = ApiListResponse<DropdownItem<dynamic>>.fromJson(
          response.data,
          fromJsonModel: DropdownItem.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch role drodpown list');
      return roles;
    } catch (error) {
      log.e('Get error: Failed to fetch role drodpown list', error);
      return roles;
    }
  }

  Future<Role> getRole(String roleId) async {
    try {
      final response = await client.get('$basePath/id/$roleId');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<Role>.fromJson(
          response.data,
          fromJsonModel: Role.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch role');
      return null;
    } catch (error) {
      log.e('Get error: Failed to fetch role', error);
      return null;
    }
  }

  Future<Role> getRoleByUserId(String userId) async {
    try {
      final response = await client.get('$basePath/user/$userId');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<Role>.fromJson(
          response.data,
          fromJsonModel: Role.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch role');
      return null;
    } catch (error) {
      log.e('Get error: Failed to fetch role', error);
      return null;
    }
  }

  Future<bool> addRole(RoleAdd role) async {
    try {
      final response = await client.post(
        '$basePath/add/',
        data: jsonEncode(role.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Post error: Failed to add role');
      return null;
    } catch (error) {
      log.e('Post error: Failed to add role', error);
      return null;
    }
  }

  Future<bool> editRole(RoleEdit role) async {
    try {
      final response = await client.put(
        '$basePath/update/${role.id}',
        data: jsonEncode(role.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Put error: Failed to update role');
      return null;
    } catch (error) {
      log.e('Put error: Failed to update role', error);
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
      log.e('Patch error: Failed to ${activation.isActive ? 'activate' : 'deactivate'} role');
      return null;
    } catch (error) {
      log.e('Patch error: Failed to ${activation.isActive ? 'activate' : 'deactivate'} role', error);
      return null;
    }
  }

  Future<bool> deleteRole(String roleId) async {
    try {
      final response = await client.delete('$basePath/delete/$roleId');
      if (response.statusCode == 200) {
        var apiResponse = ApiResponse.fromJson(response.data);
        return apiResponse.success;
      }
      log.e('Delete error: Failed to delete role');
      return false;
    } catch (error) {
      log.e('Delete error: Failed to delete role', error);
      return false;
    }
  }
}
