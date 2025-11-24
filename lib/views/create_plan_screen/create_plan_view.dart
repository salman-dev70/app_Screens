import 'package:app_screens/controller/create_plan_controller.dart';
import 'package:app_screens/controller/guest_list_controller.dart';
import 'package:app_screens/utils/string_resources.dart';
import 'package:app_screens/utils/validator.dart';

import 'package:app_screens/utils/widgets/appbar_back_icon_widget.dart';
import 'package:app_screens/utils/widgets/button_for_genderSelection.dart';
import 'package:app_screens/utils/widgets/button_widget.dart';
import 'package:app_screens/utils/widgets/custom_textfield.dart';
import 'package:app_screens/utils/widgets/image_pickerSection_widget.dart';
import 'package:app_screens/utils/widgets/invite_guest.dart';
import 'package:app_screens/utils/widgets/radioButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class CreatePlanView extends StatefulWidget {
  CreatePlanView({super.key});

  @override
  State<CreatePlanView> createState() => _CreatePlanViewState();
}

class _CreatePlanViewState extends State<CreatePlanView> {
  final CreatePlanController controller = Get.put(CreatePlanController());

  final GuestController guestController = Get.put(GuestController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _scrollController = ScrollController();

  final _firstFieldKey = GlobalKey();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  late FocusNode planNameFocusNode;
  late FocusNode planTypeFocusNode;
  late FocusNode dateFocusNode;
  late FocusNode timeFocusNode;
  late FocusNode locationFocusNode;
  late FocusNode descriptionFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planNameFocusNode = FocusNode();
    planTypeFocusNode = FocusNode();
    dateFocusNode = FocusNode();
    timeFocusNode = FocusNode();
    locationFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    planNameFocusNode.dispose();
    planTypeFocusNode.dispose();
    dateFocusNode.dispose();
    timeFocusNode.dispose();
    locationFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          StringResources.createNewPlan,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: AppbarBackIconWidget(),
        leadingWidth: 60,
        toolbarHeight: 50,

        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // plan name
                KeyedSubtree(
                  key: _firstFieldKey,
                  child: CustomTextfield(
                    focusNode: planNameFocusNode,
                    controller: controller.planNameController,
                    labeltext: StringResources.planName,
                    hintText: StringResources.enterPlanName,
                    isRequired: true,
                    maxLine: 1,
                    valdiator: controller.validatePlanName,
                    // onChanged: (value) => _formKey.currentState!.validate(),
                  ),
                ),

                // Plan type
                IgnorePointer(
                  ignoring: false,
                  child: AbsorbPointer(
                    absorbing: false,
                    child: CustomTextfield(
                      focusNode: planTypeFocusNode,
                      controller:
                          TextEditingController()
                            ..text = controller.selectedPlanType.value,
                      labeltext: StringResources.planType,
                      hintText: StringResources.select,
                      isRequired: true,
                      readOnly: true,
                      //enable: false,
                      onPressed: null,

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
                      onOptionSelected: (value) {
                        controller.selectedPlanType.value = value;

                        _unfocusAllFields();
                      },
                    ),
                  ),
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

                Container(
                  height: 125,
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomTextfield(
                            maxLine: 1,
                            focusNode: dateFocusNode,
                            controller:
                                TextEditingController()
                                  ..text = controller.selectedDate.value,
                            labeltext: 'Date',
                            hintText: 'MM/DD/YYYY',
                            isRequired: true,
                            readOnly: true,
                            enable: false,
                            onPressed: () {
                              controller.pickDate(context);
                            },

                            prefixIcon: Icon(Icons.calendar_today),
                            valdiator: (_) => controller.validateDate(),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Time Field
                      Expanded(
                        child: Obx(
                          () => CustomTextfield(
                            maxLine: 1,
                            focusNode: timeFocusNode,
                            controller:
                                TextEditingController()
                                  ..text = controller.selectedTime.value,
                            labeltext: StringResources.time,
                            hintText: 'HH:MM AM/PM',
                            isRequired: true,
                            readOnly: true,
                            enable: false,
                            onPressed: () {
                              controller.pickTime(context);
                            },
                            prefixIcon: Icon(Icons.access_time),
                            valdiator: (_) => controller.validateTime(),
                            onChanged:
                                (value) =>
                                    controller.selectedTime.value = value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Location Field
                CustomTextfield(
                  focusNode: locationFocusNode,
                  controller: controller.locationController,
                  labeltext: StringResources.location,
                  hintText: StringResources.enterLocation,
                  maxLine: 1,
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
                  focusNode: descriptionFocusNode,
                  controller: controller.descriptionController,
                  labeltext: StringResources.description,
                  hintText: StringResources.descriptionText,
                  maxLine: 4,
                  isRequired: true,
                  valdiator: controller.validateDescription,
                ),

                const SizedBox(height: 20),

                Obx(
                  () => GenderChipWidget(
                    label: StringResources.desiredCompany,
                    selectedValues: controller.selectedGenders.toList(),
                    onChanged: (String value) {
                      controller.toggleGender(value);
                    },
                    buttonValue1: StringResources.male,
                    buttonValue2: StringResources.female,
                    buttonValue3: StringResources.other,
                  ),
                ),
                const SizedBox(height: 20),

                InviteGuest(),

                Obx(
                  () =>
                      guestController.invitedUsers.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height:
                                        60, // Set height for the row of avatars
                                    child: Stack(
                                      children: List.generate(
                                        guestController.invitedUsers.length,
                                        (index) {
                                          final guest =
                                              guestController
                                                  .invitedUsers[index];
                                          return Positioned(
                                            left: index * 39.0,
                                            child: CircleAvatar(
                                              radius: 28,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                radius: 27,
                                                backgroundImage: NetworkImage(
                                                  guest.image,
                                                ),
                                                onBackgroundImageError:
                                                    (_, __) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : const SizedBox(),
                ),

                SizedBox(height: 10),
                ImagePickerSection(),
                SizedBox(height: 40),
                CreatePlanButton(
                  onPressed: () {
                    _unfocusAllFields();

                    if (_formKey.currentState!.validate()) {
                      controller.createPlan();
                    } else {
                      setState(() {
                        _autoValidateMode = AutovalidateMode.always;
                      });
                      _scrollToTop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        _firstFieldKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _unfocusAllFields() {
    planNameFocusNode.unfocus();
    planTypeFocusNode.unfocus();
    dateFocusNode.unfocus();
    timeFocusNode.unfocus();
    locationFocusNode.unfocus();
    descriptionFocusNode.unfocus();
  }
}
