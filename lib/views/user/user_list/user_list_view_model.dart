import '../../../core/base/list_base_view_model.dart';
import '../../../core/models/paged_query.dart';
import '../../../core/locator.dart';
import '../../../core/models/activation.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../user_role_assign/user_role_assign_view.dart';

class UserListViewModel extends ListBaseViewModel<User> {
  final userService = locator<UserService>();

  void _resetPassword(User item) {
    isLoading = true;
    userService.resetPassword(item.userName).then((updated) {
      if (updated) {
        navigatorService.showSucessMessage(
          message: 'Password resetted successfully for the user: ${item.userName}!',
        );
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  void _unlockUser(User item) {
    isLoading = true;
    userService.unlockUser(item.userName).then((updated) {
      if (updated) {
        navigatorService.showSucessMessage(
          message: 'The user ${item.userName} is unlocked successfully!',
        );
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  @override
  void delete(User item, int index) {
    isLoading = true;
    userService.deleteUser(item.userId).then((updated) {
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

    userService.getPagedUserList(pagedQuery).then((result) {
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
  void navigateToEditPage(User item) {}

  @override
  void toggleActivation(User item, int index) {
    isLoading = true;
    final userActivation = Activation(id: item.userId, isActive: item.isActive);
    userService.toggleActivation(userActivation).then((updated) {
      if (updated) {
        items[index].isActive = item.isActive;
        navigatorService.showSucessMessage(
          message: 'The user is ${item.isActive ? 'activated' : 'deactivated'} successfully!',
        );
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  @override
  void showActivationConfirmation(User item, int index) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want to ${item.isActive ? 'activate' : 'deactivate'} the user?',
      onConfirmed: () => toggleActivation(item, index),
    );
  }

  @override
  void showDeleteConfirmation(User item, int index) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want to remove the user?',
      confirmationMessage: "The user won't be able to access the system",
      onConfirmed: () => delete(item, index),
    );
  }

  void showPasswordResetConfirmation(User item) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want to reset the user password?',
      confirmationMessage: 'The user need to know the default password to login into the system.',
      onConfirmed: () => _resetPassword(item),
    );
  }

  void showUnlockUserConfirmation(User item) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want to unlock the user?',
      confirmationMessage:
          'The user will be able to acess the system again. It is recommended to change the user password.',
      onConfirmed: () => _unlockUser(item),
    );
  }

  void showAssignRoleDialog(User item, int index) {
    navigatorService.showPageBottomSheet(child: UserRoleAssignView(user: item));
  }
}
