import 'package:app_screens/utils/string_resources.dart';

class Validators {
  static String? validatePlanName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringResources.planNameRequired;
    } else {
      return null;
    }
  }

  static String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringResources.locationRequired;
    }
    return null;
  }

  static String? validatePlanType(String? value) {
    if (value == null || value.isEmpty) {
      return StringResources.planTypeRequired;
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringResources.dateRequired;
    } else {}
  }

  static String? validateTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringResources.timeRequired;
    } else {}
  }

  static String? validateOptional(String? value) {
    return null;
  }
}
