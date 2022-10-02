import 'dart:convert';
import 'package:meta/meta.dart';

import '../../../core/models/paged_query.dart';
import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../models/role_module_add.dart';
import '../models/role_module.dart';

class RoleModuleService extends BaseService {
  final String basePath = '/role-modules';

  final ApiClient client;

  RoleModuleService({@required this.client});

  Future<PagedList<RoleModule>> getPagedRoleModuleAssignmentList(PagedQuery pagedQuery) async {
    final emptyList = PagedList<RoleModule>(items: [], count: 0);
    try {
      final response = await client.get('$basePath/list', queryParameters: pagedQuery.toJson());

      if (response.statusCode == 200) {
        var apiResponse = ApiPagedResponse<RoleModule>.fromJson(
          response.data,
          fromJsonModel: RoleModule.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch role module assignment list');
      return emptyList;
    } catch (error) {
      log.e('Get error: Failed to fetch role module assignment list', error);
      return emptyList;
    }
  }

  Future<RoleModule> getRoleModuleAssignments(String roleId) async {
    try {
      final response = await client.get('$basePath/id/$roleId');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<RoleModule>.fromJson(
          response.data,
          fromJsonModel: RoleModule.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch role module assignments');
      return null;
    } catch (error) {
      log.e('Get error: Failed to fetch role module assignments', error);
      return null;
    }
  }

  Future<bool> assignRoleModule(RoleModuleAdd roleModule) async {
    try {
      final response = await client.post(
        '$basePath/assign/',
        data: jsonEncode(roleModule.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Post error: Failed to assign role module');
      return null;
    } catch (error) {
      log.e('Post error: Failed to assign role module', error);
      return null;
    }
  }

  // Future<bool> editRole(RoleEdit role) async {
  //   try {
  //     final response = await client.put(
  //       '$basePath/update/${role.id}',
  //       data: jsonEncode(role.toJson()),
  //     );

  //     if (response.statusCode == 200) {
  //       var apiResponse = ApiResponse<bool>.fromJson(response.data);
  //       if (apiResponse.success) return apiResponse.result;
  //     }
  //     log.e('Put error: Failed to update role');
  //     return null;
  //   } catch (error) {
  //     log.e('Put error: Failed to update role', error);
  //     return null;
  //   }
  // }
}
