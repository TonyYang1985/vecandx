import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../models/test_list_paged_query.dart';
import '../models/patient_test.dart';

class TestService extends BaseService {
  final ApiClient client;

  TestService({@required this.client});

  Future<PatientTest> getPatientTest(int testId) async {
    try {
      final response = await client.get('/tests/id/$testId');
      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<PatientTest>.fromJson(
          response.data,
          fromJsonModel: PatientTest.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Get error: Failed to fetch test');
      return null;
    } catch (error) {
      log.e('Get error: Failed to fetch test', error);
      return null;
    }
  }

  Future<PatientTest> addPatientTest(PatientTest patientTest) async {
    try {
      final response = await client.post(
        '/tests/add',
        data: jsonEncode(patientTest.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<PatientTest>.fromJson(
          response.data,
          fromJsonModel: PatientTest.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Post error: Failed to add test');
      return null;
    } catch (error) {
      log.e('Post error: Failed to add test', error);
      return null;
    }
  }

  Future<PatientTest> updatePatientTest(PatientTest patientTest) async {
    try {
      final response = await client.put(
        '/tests/update/${patientTest.test.id}',
        data: jsonEncode(patientTest.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<PatientTest>.fromJson(
          response.data,
          fromJsonModel: PatientTest.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      log.e('Put error: Failed to update test');
      return null;
    } catch (error) {
      log.e('Put error: Failed to update test', error);
      return null;
    }
  }

  Future<ApiResponse<bool>> submitTest(int testId) async {
    try {
      final response = await client.patch('/tests/submit/$testId');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Patch: Test is submitted successfully.');
        }
        return apiResponse;
      }
      log.e('Patch error: Failed to submit test.');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Patch error: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Patch error: Failed to submit test: ', error);
      return null;
    }
  }

  Future<ApiResponse<bool>> markTestAsInvalid(int testId) async {
    try {
      final response = await client.patch('/tests/mark-invalid/$testId');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Patch: Test is marked invalid successfully.');
        }
        return apiResponse;
      }
      log.e('Patch error: Failed to mark test as invalid.');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Patch error: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Patch error: Failed to mark test as invalid: ', error);
      return null;
    }
  }

  Future<PagedList<PatientTest>> getPagedTestList(TestListPagedQuery pagedQuery) async {
    final emptyList = PagedList<PatientTest>(items: [], count: 0);
    try {
      final response = await client.get('/tests/list', queryParameters: pagedQuery.toJson());

      if (response.statusCode == 200) {
        var apiResponse = ApiPagedResponse<PatientTest>.fromJson(
          response.data,
          fromJsonModel: PatientTest.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse.result;
      }
      return emptyList;
    } catch (error) {
      log.e('Get error: Failed to fetch test list', error);
      return emptyList;
    }
  }

  Future<bool> deleteTest(PatientTest patientTest) async {
    try {
      final response = await client.delete('/tests/delete/${patientTest.test.id}');
      if (response.statusCode == 200) {
        var apiResponse = ApiResponse.fromJson(response.data);
        return apiResponse.success;
      }
      log.e('Delete error: Failed to delete test');
      return false;
    } catch (error) {
      log.e('Delete error: Failed to delete test', error);
      return false;
    }
  }

  Future<dynamic> getPatientTestReport(int testId) async {
    try {
      final response = await client.get(
        '/tests/test-report/$testId',
        options: Options(responseType: ResponseType.bytes, followRedirects: false),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      log.e('Get error: Failed to fetch test');
      return null;
    } catch (error) {
      log.e('Get error: Failed to fetch test', error);
      return null;
    }
  }

  Future<bool> downloadPatientTestReport(int testId, String downloadPath) async {
    try {
      final response = await client.downloadFile('/tests/test-report/$testId', downloadPath);
      if (response.statusCode == 200) return true;
      log.e('Download Rport error: Failed to download report');
      return false;
    } catch (error) {
      log.e('Download Rport error: Failed to download report', error);
      return false;
    }
  }
}
