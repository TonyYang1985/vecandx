import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/base/list_base_view_model.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/locator.dart';
import '../models/test_list_paged_query.dart';
import '../test_detail/test_detail_view.dart';
import '../services/test_service.dart';
import '../models/patient_test.dart';

class TestListViewModel extends ListBaseViewModel<PatientTest> {
  final testService = locator<TestService>();

  FormGroup searchFilterForm = fb.group({
    'searchTerm': FormControl<String>(),
    'collectionDateFrom': FormControl<DateTime>(value: null),
    'collectionDateTo': FormControl<DateTime>(value: null),
    'testDateFrom': FormControl<DateTime>(value: null),
    'testDateTo': FormControl<DateTime>(value: null),
  });

  @override
  void getList({Function callback}) {
    isLoading = true;
    final form = searchFilterForm.value;
    final pagedQuery = TestListPagedQuery(
      page: page,
      pageSize: pageSize,
      searchTerm: form['searchTerm'],
      collectionDateFrom: form['collectionDateFrom'],
      collectionDateTo: form['collectionDateTo'],
      testDateFrom: form['testDateFrom'],
      testDateTo: form['testDateTo'],
    );

    testService.getPagedTestList(pagedQuery).then((result) {
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
  void delete(PatientTest item, int index) {
    isLoading = true;
    testService.deleteTest(item).then((isDeleted) {
      if (isDeleted) {
        items.removeAt(index);
        count -= 1;
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  void markTestAsInvalid(PatientTest item, int index) {
    isLoading = true;
    testService.markTestAsInvalid(item.test.id).then((apiResponse) {
      if (apiResponse.success && apiResponse.result) {
        navigatorService.showSucessMessage(message: apiResponse.message);
      } else {
        navigatorService.showErrorMessage(message: apiResponse.message);
        items[index].test.isInvalid = false;
      }
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
      navigatorService.pop();
    });
  }

  @override
  void showDeleteConfirmation(PatientTest item, int index) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want delete the test result?',
      confirmationMessage: "The test result won't be able to accessible.",
      onConfirmed: () => delete(item, index),
    );
  }

  void showMarkAsInvalidConfirmation(PatientTest item, int index) {
    navigatorService.showConfirmationDialog(
      subTitle: 'Do you want mark the test as Invalid?',
      confirmationMessage: "The test result won't be able to accessible.",
      onConfirmed: () => markTestAsInvalid(item, index),
    );
  }

  @override
  void navigateToAddPage() {
    navigateToPage(Routes.addTest);
  }

  @override
  void navigateToEditPage(PatientTest item) {
    navigateToPage(Routes.editTest, arguments: item.test.id);
  }

  void navigateToDetailPage(PatientTest item) {
    navigatorService.showPageBottomSheet(child: TestDetailView(patientTest: item));
  }

  @override
  void showActivationConfirmation(PatientTest item, int index) {}

  @override
  void toggleActivation(PatientTest item, int index) {}
}
