import 'package:app_screens/utils/string_resources.dart';
import 'package:app_screens/viewmodel/guest_list_controller.dart';
import 'package:app_screens/views/GuestListScreen/guest_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';

class InviteGuest extends StatelessWidget {
  InviteGuest({super.key});

  final GuestController controller = Get.find<GuestController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            StringResources.inviteGuest,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),

        GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => GuestBottomSheet(),
            );
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringResources.clickToInviteGuest),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
