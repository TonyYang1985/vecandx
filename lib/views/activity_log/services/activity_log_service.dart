import 'package:meta/meta.dart';

import '../../../core/models/paged_query.dart';
import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../models/activity_log.dart';

class ActivityLogService extends BaseService {
  final String basePath = '/activity-logs';

  final ApiClient client;

  ActivityLogService({@required this.client});

  Future<PagedList<ActivityLog>> getPagedActivityLogList(PagedQuery pagedQuery) async {
    final emptyList = PagedList<ActivityLog>(items: [], count: 0);
    try {
      final response = await client.get('$basePath/list', queryParameters: pagedQuery.toJson());

      if (response.statusCode == 200) {
        var apiResponse = ApiPagedResponse<ActivityLog>.fromJson(
          response.data,
          fromJsonModel: ActivityLog.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      return emptyList;
    } catch (error) {
      log.e('Get error: Failed to fetch activity log list', error);
      return emptyList;
    }
  }

  Future<ActivityLog> getActivityLog(int activityId) async {
    try {
      final response = await client.get('$basePath/id/$activityId');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<ActivityLog>.fromJson(
          response.data,
          fromJsonModel: ActivityLog.fromJsonModel,
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
}
