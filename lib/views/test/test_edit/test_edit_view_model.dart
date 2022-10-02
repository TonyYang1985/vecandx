import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/utils/datetime_util.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/services/calculation_service.dart';
import '../../../core/services/navigator_service.dart';
import '../models/patient_test.dart';
import '../services/test_service.dart';

class TestEditViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final calculationService = locator<CalculationService>();
  final testService = locator<TestService>();

  int _testId;
  bool _isLoading = false;
  double _score;

  void initialise(int testId) {
    _score = 0;
    _testId = testId;
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

  void getPatientTest({Function onLoadPatientTest}) {
    testService.getPatientTest(_testId).then((value) {
      if (onLoadPatientTest != null) {
        onLoadPatientTest(value);
      }
    });
  }

  void updatePatientTest(PatientTest patientTest, BuildContext context) {
    isLoading = true;
    testService.updatePatientTest(patientTest).then((result) {
      if (result != null) {
        showSucessMessage(
          context: context,
          message: 'Test is updated successfully!',
        );
        navigateToListPage();
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }

  void submitPatientTest() {
    isLoading = true;
    testService.submitTest(_testId).then((apiResponse) {
      if (apiResponse.success && apiResponse.result) {
        navigatorService.showSucessMessage(message: 'Test is submitted successfully!');
        navigateToListPage();
      } else {
        navigatorService.showErrorMessage(message: apiResponse.message);
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }

  void navigateToListPage() {
    navigatorService.navigateToPageWithReplacementNamed(Routes.testList);
  }
}
