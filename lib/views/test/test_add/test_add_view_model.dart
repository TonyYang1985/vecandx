import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:vecandx/core/utils/datetime_util.dart';

import '../../../core/constants/route_constant.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/services/calculation_service.dart';
import '../../../core/services/navigator_service.dart';
import '../models/patient_test.dart';
import '../services/test_service.dart';

class TestAddViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final calculationService = locator<CalculationService>();
  final testService = locator<TestService>();

  bool _isLoading = false;
  double _score;

  void initialise() {
    _score = 0;
    notifyListeners();
  }

  double get score => _score;
  set score(double value) {
    _score = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void generateTestResult(FormGroup form) {
    calculationService.generateTestResult(form);
  }

  void setAge(FormGroup form) {
    final birthDate = form.control('patient.dateOfBirth').value as DateTime;
    final age = DateTimeUtil.getAge(birthDate);
    form.control('patient.age').patchValue(age);
  }

  void addPatientTest(PatientTest patientTest, {@required Function onAddedTest}) {
    isLoading = true;
    testService.addPatientTest(patientTest).then((result) {
      if (onAddedTest != null && result != null) {
        navigatorService.showSucessMessage(message: 'Test is added successfully!');
        onAddedTest(result);
      }
    }).whenComplete(() => isLoading = false);
  }

  void submitPatientTest(PatientTest patientTest, {Function onSubmitted}) {
    addPatientTest(patientTest, onAddedTest: (PatientTest result) {
      isLoading = true;
      testService.submitTest(result.test.id).then((apiResponse) {
        if (apiResponse.success && apiResponse.result) {
          if (onSubmitted != null) onSubmitted();
          navigatorService.showSucessMessage(message: 'Test is submitted successfully!');
        } else {
          navigatorService.showErrorMessage(message: apiResponse.message);
        }
      }).whenComplete(() {
        isLoading = false;
      });
    });
  }

  void navigateToListPage() {
    navigatorService.navigateToPageWithReplacementNamed(Routes.testList);
  }
}
