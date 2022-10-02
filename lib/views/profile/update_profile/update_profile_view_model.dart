import 'package:flutter/material.dart';
import 'package:vecandx/core/constants/route_constant.dart';

import '../../../core/locator.dart';
import '../../../core/services/navigator_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/constants/core_data_constant.dart';
import '../models/profile.dart';
import '../services/profile_service.dart';

class UpdateProfileViewModel extends BaseViewModel {
  final navigatorService = locator<NavigatorService>();
  final profileService = locator<ProfileService>();
  final storageService = locator<StorageService>();
  final List<DropdownMenuItem<int>> _securityQuestions = CoreData.securityQuestions;

  List<DropdownMenuItem<int>> _filteredSecurityQuestions = [];
  bool _profileUpdated = false;
  bool _formSubmitted = false;

  void initialise() {
    notifyListeners();
  }

  List<DropdownMenuItem<int>> get securityQuestions => _securityQuestions;

  bool get profileUpdated => _profileUpdated;
  set profileUpdated(bool value) {
    _profileUpdated = value;
    notifyListeners();
  }

  List<DropdownMenuItem<int>> get filteredSecurityQuestions => _filteredSecurityQuestions;
  set filteredSecurityQuestions(List<DropdownMenuItem<int>> value) {
    _filteredSecurityQuestions = value;
    notifyListeners();
  }

  bool get formSubmitted => _formSubmitted;
  set formSubmitted(bool value) {
    _formSubmitted = value;
    notifyListeners();
  }

  void filterSecurityQuestions(int questionNo) {
    filteredSecurityQuestions = _securityQuestions.where((item) => item.value != questionNo).toList();
  }

  Future<Profile> getProfile() {
    return profileService.getProfile(storageService?.authUser?.userName);
  }

  void updateProfile(Profile profile) {
    formSubmitted = true;
    isLoading = true;

    profileService.updateProfile(profile).then((response) {
      if (response != null) {
        if (response.success) {
          // TODO: update authuser
          profileUpdated = true;
          navigatorService.showSucessMessage(
            message: 'Profile has been updated.',
            callback: () => Future.delayed(
              Duration(seconds: 3),
              () => navigatorService.navigateToPageWithReplacementNamed(Routes.dashboard),
            ),
          );
        } else {
          navigatorService.showErrorMessage(message: response.message);
        }
      } else {
        navigatorService.showErrorMessage(message: 'Failed to update profile, try again.');
      }
    }).whenComplete(() {
      isLoading = false;
    });
  }
}
