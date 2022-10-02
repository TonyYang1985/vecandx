import '../../../core/models/paged_query.dart';
import '../../../core/base/list_base_view_model.dart';
import '../../../core/locator.dart';
import '../services/activity_log_service.dart';
import '../models/activity_log.dart';

class ActivityLogListViewModel extends ListBaseViewModel<ActivityLog> {
  final activityLogService = locator<ActivityLogService>();

  @override
  void getList({Function callback}) {
    isLoading = true;
    final pagedQuery = PagedQuery(
      page: page,
      pageSize: pageSize,
      searchTerm: searchController.value.text.trim(),
    );

    activityLogService.getPagedActivityLogList(pagedQuery).then((result) {
      items = result.items;
      count = result.count;

      if (callback != null) {
        callback();
      } else {
        previousItems = [];
      }
      notifyListeners();
    }).whenComplete(() => isLoading = false);
  }

  @override
  void delete(ActivityLog item, int index) {
    // TODO: implement delete
  }

  @override
  void toggleActivation(ActivityLog item, int index) {
    // TODO: implement toggleActivation
  }

  @override
  void showActivationConfirmation(ActivityLog item, int index) {
    // TODO: implement showActivationConfirmation
  }

  @override
  void showDeleteConfirmation(ActivityLog item, int index) {
    // TODO: implement showDeleteConfirmation
  }

  @override
  void navigateToAddPage() {
    // TODO: implement navigateToAddPage
  }

  @override
  void navigateToEditPage(ActivityLog item) {
    // TODO: implement navigateToEditPage
  }
}
