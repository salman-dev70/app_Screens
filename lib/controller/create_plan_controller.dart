import 'dart:developer';

import 'package:app_screens/utils/validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/string_resources.dart';

class CreatePlanController extends GetxController {
  // TextEditing Controllers
  final planNameController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  // Reactive Variables
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // Form Fields Reactive Variables
  final selectedPlanType = ''.obs;
  final selectedFlexibility = true.obs;
  final selectedDate = ''.obs;
  final selectedTime = ''.obs;
  final isPublic = true.obs;
  final selectedGenders = <String>[].obs;

  // Dispose Controllers
  @override
  void onClose() {
    planNameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }

  // Validation Methods
  String? validatePlanName(String? value) {
    return Validators.validatePlanName(planNameController.text.trim());
  }

  String? validateLocation(String? value) {
    return Validators.validateLocation(locationController.text.trim());
  }

  String? validatePlanType() {
    return Validators.validatePlanType(selectedPlanType.value);
  }

  String? validateDate() {
    return Validators.validateDate(selectedDate.value);
  }

  String? validateTime() {
    return Validators.validateTime(selectedTime.value);
  }

  // Description optional
  String? validateDescription(String? value) {
    return Validators.validateDescription(descriptionController.text.trim());
  }

  // Plan Type Selection
  void selectPlanType(String type) {
    selectedPlanType.value = type;
  }

  // Flexibility Toggle
  void toggleFlexibility(bool isselectedFlexibility) {
    selectedFlexibility.value = isselectedFlexibility;
  }

  // Visibility Toggle
  void toggleVisibility(bool isPublicValue) {
    isPublic.value = isPublicValue;
  }

  // Gender Selection
  void toggleGender(String gender) {
    if (selectedGenders.contains(gender)) {
      selectedGenders.remove(gender);
    } else {
      selectedGenders.add(gender);
    }
    update();
  }

  bool isGenderSelected(String gender) {
    return selectedGenders.contains(gender);
  }

  // Date Picker
  // Date Picker
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      // Convert picked date to UTC
      final utcDate = DateTime.utc(picked.year, picked.month, picked.day);
      final month = utcDate.month.toString().padLeft(2, '0');
      final day = utcDate.day.toString().padLeft(2, '0');
      final year = utcDate.year.toString();
      selectedDate.value = '$month/$day/$year';
    }
  }

  // Time Picker with Proper UTC Conversion
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();

      final localDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      final utcDateTime = localDateTime.toUtc();

      final utcHour = utcDateTime.hour;
      final period = utcHour >= 12 ? 'PM' : 'AM';
      final hour = utcHour > 12 ? utcHour - 12 : (utcHour == 0 ? 12 : utcHour);
      final minute = utcDateTime.minute.toString().padLeft(2, '0');

      selectedTime.value = '$hour:$minute$period';
    }
  }

  // Form Submit Method
  void createPlan() {
    errorMessage.value = '';
    log("button pressed");

    // Validate all required fields
    final planNameValidation = validatePlanName(planNameController.text);
    final locationValidation = validateLocation(locationController.text);
    final planTypeValidation = validatePlanType();
    log("validations done");

    // Check if any validation failed
    if (planNameValidation != null) {
      errorMessage.value = planNameValidation;
      return;
    }

    if (locationValidation != null) {
      errorMessage.value = locationValidation;
      return;
    }

    if (planTypeValidation != null) {
      errorMessage.value = planTypeValidation;
      return;
    }
    log("all validations passed");

    _submitPlanData();
  }

  // Data Submission
  void _submitPlanData() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      // Show success message
      Get.snackbar(
        StringResources.success,
        StringResources.planCreatedSuccess,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  // Check if form is valid
  bool get isFormValid {
    return planNameController.text.trim().isNotEmpty &&
        locationController.text.trim().isNotEmpty &&
        selectedPlanType.value.isNotEmpty;
  }
}
