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
  final selectedGender = 'Male'.obs;

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

  // Description optional
  String? validateDescription(String? value) {
    return null;
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
  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  // Date Picker

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      final month = picked.month.toString().padLeft(2, '0');
      final day = picked.day.toString().padLeft(2, '0');
      final year = picked.year.toString();
      selectedDate.value = '$month/$day/$year';
    }
  }

  // Time Picker
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final period = picked.hour >= 12 ? 'PM' : 'AM';
      final hour = picked.hour > 12 ? picked.hour - 12 : picked.hour;
      final minute = picked.minute.toString().padLeft(2, '0');
      selectedTime.value = '$hour:$minute$period';
    }
  }

  // Form Submit Method
  void createPlan() {
    errorMessage.value = '';

    // Validate all required fields
    final planNameValidation = validatePlanName(planNameController.text);
    final locationValidation = validateLocation(locationController.text);
    final planTypeValidation = validatePlanType();

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
