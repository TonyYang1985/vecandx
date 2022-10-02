import '../../../core/constants/route_constant.dart';
import '../../../core/models/paged_query.dart';
import '../../../core/base/list_base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/models/activation.dart';
import '../services/role_service.dart';
import '../models/role.dart';

class RoleListViewModel extends ListBaseViewModel<Role> {
  final roleService = locator<RoleService>();

  @override
  void delete(Role item, int index) {
    isLoading = true;
    roleService.deleteRole(item.id).then((updated) {
      if (updated) {
        items[index].isActive = false;
        items[index].isDeleted = true;
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  @override
  void getList({Function callback}) {
    isLoading = true;
    final pagedQuery = PagedQuery(
      page: page,
      pageSize: pageSize,
      searchTerm: searchController.value.text.trim(),
    );

    roleService.getPagedRoleList(pagedQuery).then((result) {
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
  void toggleActivation(Role item, int index) {
    isLoading = true;
    final activation = Activation(id: item.id, isActive: item.isActive);
    roleService.toggleActivation(activation).then((updated) {
      if (updated) {
        items[index].isActive = item.isActive;
        navigatorService.showSucessMessage(
          message: 'The role is ${item.isActive ? 'activated' : 'deactivated'} successfully!',
        );
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  @override
  void showActivationConfirmation(Role item, int index) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want to ${item.isActive ? 'activate' : 'deactivate'} the role?',
      onConfirmed: () => toggleActivation(item, index),
    );
  }

  @override
  void showDeleteConfirmation(Role item, int index) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want to remove the role?',
      confirmationMessage: "The role won't be able to assignable.",
      onConfirmed: () => delete(item, index),
    );
  }

  @override
  void navigateToAddPage() {
    navigateToPage(Routes.addRole);
  }

  @override
  void navigateToEditPage(Role item) {
    navigateToPage(Routes.editRole, arguments: item.id);
  }
}
