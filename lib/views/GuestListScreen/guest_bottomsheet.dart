import 'package:app_screens/utils/string_resources.dart';
import 'package:app_screens/viewmodel/guest_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class GuestBottomSheet extends StatelessWidget {
  GuestBottomSheet({super.key});

  final GuestController controller = Get.find<GuestController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP HANDLE
          Center(
            child: Container(
              width: 60,
              height: 5,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Center(
            child: Text(
              StringResources.guestList,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 20),

          // SEARCH BAR
          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // GUEST LIST
          Expanded(
            child: Obx(() {
              return ListView.separated(
                itemCount: controller.guests.length,
                itemBuilder: (_, i) {
                  final user = controller.guests[i];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(user.image),
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      user.city,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    trailing: Obx(
                      () => GestureDetector(
                        onTap: () => controller.toggleInvite(user),
                        child: Container(
                          width: user.isInvite.value ? 120 : 80,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                user.isInvite.value
                                    ? Colors.grey.shade300
                                    : Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              user.isInvite.value
                                  ? StringResources.cancelInvite
                                  : StringResources.invite,
                              style: TextStyle(
                                color:
                                    user.isInvite.value
                                        ? Colors.grey.shade800
                                        : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder:
                    (_, __) => Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      height: 1,
                    ),
              );
            }),
          ),

          const SizedBox(height: 15),

          // BOTTOM BUTTON ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  StringResources.cancel,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, controller.invitedUsers);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  StringResources.confirm,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
