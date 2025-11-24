import 'package:app_screens/viewmodel/create_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePlanButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CreatePlanButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final CreatePlanController controller = Get.find<CreatePlanController>();

    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child:
              controller.isLoading.value
                  ? Row(
                    //
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Creating Plan...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                  : Text(
                    'Create Plan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }
}
