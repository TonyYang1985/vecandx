import 'package:meta/meta.dart';

import '../models/module.dart';
import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';

class ModuleService extends BaseService {
  final String basePath = '/modules';

  final ApiClient client;

  ModuleService({@required this.client});

  Future<List<Module>> getModules() async {
    try {
      final response = await client.get('$basePath/list');

      if (response.statusCode == 200) {
        var apiResponse = ApiListResponse<Module>.fromJson(
          response.data,
          fromJsonModel: Module.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch modules');
      return [];
    } catch (error) {
      log.e('Get error: Failed to fetch modules', error);
      return [];
    }
  }
}
