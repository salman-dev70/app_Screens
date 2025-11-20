import 'package:app_screens/utils/string_resources.dart';
import 'package:app_screens/viewmodel/create_plan_controller.dart';
import 'package:app_screens/views/create_plan_screen/widgets/button_for_genderSelection.dart';
import 'package:app_screens/views/create_plan_screen/widgets/custom_textfield.dart';
import 'package:app_screens/views/create_plan_screen/widgets/invite_guest.dart';
import 'package:app_screens/views/create_plan_screen/widgets/radioButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class CreatePlanView extends StatelessWidget {
  CreatePlanView({super.key});

  final CreatePlanController controller = Get.put(CreatePlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(StringResources.createNewPlan),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // plan name
                CustomTextfield(
                  controller: controller.planNameController,
                  labeltext: StringResources.planName,
                  hintText: StringResources.enterPlanName,
                  isRequired: true,
                  maxLine: 1,
                  valdiator: controller.validatePlanName,
                ),

                // Plan type
                CustomTextfield(
                  controller:
                      TextEditingController()
                        ..text = controller.selectedPlanType.value,
                  labeltext: StringResources.planType,
                  hintText: StringResources.select,
                  isRequired: true,
                  readOnly: true,

                  dropdownOptions: const [
                    'Business Meeting',
                    'Casual Hangout',
                    'Birthday Party',
                    'Conference',
                    'Team Building',
                    'Networking Event',
                    'Other',
                  ],
                  valdiator: (_) => controller.validatePlanType(),
                  onChanged: (value) {
                    controller.selectedPlanType.value = value;
                  },
                ),
                Obx(
                  () => RadioButtonGroup(
                    buttonValue1: StringResources.fixed,
                    buttonValue2: StringResources.flexible,
                    label: StringResources.planFlexibility,
                    selectedValue:
                        controller.selectedFlexibility.value
                            ? StringResources.fixed
                            : StringResources.flexible,
                    onChanged:
                        (value) => controller.toggleFlexibility(
                          (value == StringResources.fixed),
                        ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomTextfield(
                          controller:
                              TextEditingController()
                                ..text = controller.selectedDate.value,
                          labeltext: 'Date',
                          hintText: 'MM/DD/YYYY',
                          isRequired: true,
                          readOnly: true,
                          enable: false,
                          onPressed: () => controller.pickDate(context),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Time Field
                    Expanded(
                      child: Obx(
                        () => CustomTextfield(
                          controller:
                              TextEditingController()
                                ..text = controller.selectedTime.value,
                          labeltext: StringResources.time,
                          hintText: 'HH:MM AM/PM',
                          isRequired: true,
                          readOnly: true,
                          enable: false,
                          onPressed: () => controller.pickTime(context),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),

                // Location Field
                CustomTextfield(
                  controller: controller.locationController,
                  labeltext: StringResources.location,
                  hintText: StringResources.enterLocation,
                  isRequired: true,
                  prefixIcon: Icon(Icons.location_city, color: Colors.grey),
                  valdiator: controller.validateLocation,
                ),

                Obx(
                  () => RadioButtonGroup(
                    buttonValue1: StringResources.public,
                    buttonValue2: StringResources.private,
                    label: StringResources.visibility,
                    selectedValue:
                        controller.isPublic.value
                            ? StringResources.public
                            : StringResources.private,
                    onChanged:
                        (value) => controller.toggleVisibility(
                          value == StringResources.public,
                        ),
                  ),
                ),

                // Description Field
                CustomTextfield(
                  controller: controller.descriptionController,
                  labeltext: StringResources.description,
                  hintText: StringResources.descriptionText,
                  maxLine: 4,
                  isRequired: false,
                  valdiator: controller.validateDescription,
                ),

                const SizedBox(height: 20),

                Obx(
                  () => RadioButtonGender(
                    label: StringResources.desiredCompany,
                    selectedValue: controller.selectedGender.value,
                    onChanged: controller.selectGender,
                    buttonValue1: StringResources.male,
                    buttonValue2: StringResources.female,
                    buttonValue3: StringResources.other,
                  ),
                ),
                const SizedBox(height: 20),

                InviteGuest(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
