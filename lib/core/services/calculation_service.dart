import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../views/test/models/biomarker.dart';
import '../constants/core_data_constant.dart';
import '../models/api_response.dart';
import '../base/base_service.dart';
import '../api/api_client.dart';

class CalculationService extends BaseService {
  final ApiClient client;

  CalculationService({@required this.client});

  Future<double> generateScore(Biomarker marker) async {
    try {
      final response = await client.post(
        '/calculation/generate/test-result',
        data: jsonEncode(marker.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<double>.fromJson(response.data);
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Post error: Failed to generate test score');
      return null;
    } catch (error) {
      log.e('Post error: Failed to generate test score', error);
      return null;
    }
  }

  bool areBiomarkersValid(FormGroup form) {
    if (form.control('biomarker.concentrationA').hasErrors) return false;
    if (form.control('biomarker.concentrationC').hasErrors) return false;
    if (form.control('biomarker.concentrationG').hasErrors) return false;
    if (form.control('biomarker.concentrationP').hasErrors) return false;
    if (form.control('biomarker.concentrationS').hasErrors) return false;
    return true;
  }

  void generateTestResult(FormGroup form) {
    final riskScoreControl = form.control('test.riskScore');
    final riskControl = form.control('test.risk');
    if (areBiomarkersValid(form)) {
      final biomarker = Biomarker.fromJson(form.value['biomarker']);
      generateScore(biomarker).then((score) {
        if (score != null) {
          riskScoreControl.patchValue(score);
          riskControl.patchValue(score > CoreData.cutOffValue ? 'high' : 'low');
        }
      });
    } else if (form.invalid && riskScoreControl.value != null) {
      riskScoreControl.patchValue(null);
      riskControl.patchValue(null);
    }
  }
}
