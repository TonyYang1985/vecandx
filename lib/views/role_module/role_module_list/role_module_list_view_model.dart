import '../../../core/models/paged_query.dart';
import '../../../core/base/list_base_view_model.dart';
import '../../../core/locator.dart';
import '../role_module_assign/role_module_assign_view.dart';
import '../models/role_module.dart';
import '../services/role_module_service.dart';

class RoleModuleListViewModel extends ListBaseViewModel<RoleModule> {
  final roleModuleService = locator<RoleModuleService>();

  @override
  void getList({Function callback}) {
    isLoading = true;
    final pagedQuery = PagedQuery(
      page: page,
      pageSize: pageSize,
      searchTerm: searchController.value.text.trim(),
    );

    roleModuleService.getPagedRoleModuleAssignmentList(pagedQuery).then((result) {
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
  void navigateToAddPage() {}

  @override
  void delete(RoleModule item, int index) {}

  @override
  void navigateToEditPage(RoleModule item) {
    navigatorService.showPageBottomSheet(child: RoleModuleAssignView(roleModule: item));
  }

  @override
  void showActivationConfirmation(RoleModule item, int index) {}

  @override
  void showDeleteConfirmation(RoleModule item, int index) {}

  @override
  void toggleActivation(RoleModule item, int index) {}

  void showAssignRoleModuleDialog() {
    navigatorService.showPageBottomSheet(child: RoleModuleAssignView());
  }
}
