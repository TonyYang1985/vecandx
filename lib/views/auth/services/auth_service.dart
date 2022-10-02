import 'dart:convert';
import 'package:meta/meta.dart';

import '../../../core/api/api_client.dart';
import '../../../core/base/base_service.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/storage_service.dart';
import '../models/password_reset.dart';
import '../models/password_reset_token.dart';
import '../models/security_answer.dart';
import '../models/security_question.dart';
import '../models/auth_user.dart';
import '../models/login.dart';
import '../models/account.dart';

class AuthService extends BaseService {
  final ApiClient client;
  final StorageService storageService;

  AuthService({
    @required this.client,
    @required this.storageService,
  });

  bool get isLoggedIn => storageService?.authUser != null;

  Future<ApiResponse<SecurityQuestion>> getSecurityQuestion(String userName) async {
    try {
      final response = await client.get('/auth/user/$userName/security-question');

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<SecurityQuestion>.fromJson(
          response.data,
          fromJsonModel: SecurityQuestion.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse;
      }
      log.e('Authentication: Failed to fetch security question');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<SecurityQuestion>.fromJson(error.response.data);
        log.e('Authentication: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Authentication: Failed to fetch security question: ', error);
      return null;
    }
  }

  Future<ApiResponse<PasswordResetToken>> verifySecurityAnswer(SecurityAnswer securityAnswer) async {
    try {
      final response = await client.post(
        '/auth/verify/security-answer',
        data: jsonEncode(securityAnswer.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<PasswordResetToken>.fromJson(
          response.data,
          fromJsonModel: PasswordResetToken.fromJsonModel,
        );
        if (apiResponse.success) return apiResponse;
      }

      log.e('Authentication: Failed to verify security answer');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<PasswordResetToken>.fromJson(error.response.data);
        log.e('Authentication: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Authentication: Failed to verify security answer: ', error);
      return null;
    }
  }

  Future<ApiResponse<AuthUser>> authenticate(Login login) async {
    try {
      final response = await client.post(
        '/auth/login',
        data: jsonEncode(login.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<AuthUser>.fromJson(
          response.data,
          fromJsonModel: AuthUser.fromJsonModel,
        );
        if (apiResponse.success) {
          storageService.saveAuthUser(apiResponse.result);
          log.i('Authentication: Successfully authenticated');
          return apiResponse;
        }
      }
      log.e('Authentication: Failed to authenticate');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<AuthUser>.fromJson(error.response.data);
        log.e('Authentication: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Authentication: Error: ', error);
      return null;
    }
  }

  Future<ApiResponse<bool>> resetPassword(PasswordReset passwordReset) async {
    try {
      final response = await client.post(
        '/auth/reset-password',
        data: jsonEncode(passwordReset.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Authentication: Password has been resetted');
        }
        return apiResponse;
      }
      log.e('Authentication: Failed to reset password');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Authentication: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Authentication: Failed to reset password: ', error);
      return null;
    }
  }

  Future<ApiResponse<bool>> createAccount(Account account) async {
    try {
      final response = await client.post(
        '/auth/create-account',
        data: jsonEncode(account.toJson()),
      );

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse<bool>.fromJson(response.data);
        if (apiResponse.success && apiResponse.result) {
          log.i('Account: Account created successfully');
        }
        return apiResponse;
      }
      log.e('Account: Failed to create account');
      return null;
    } catch (error) {
      if (error.response != null && error.response.data != null) {
        var apiResponse = ApiResponse<bool>.fromJson(error.response.data);
        log.e('Account: ${apiResponse.message}');
        return apiResponse;
      }
      log.e('Account: Failed to create account: ', error);
      return null;
    }
  }
}
