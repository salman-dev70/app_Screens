import 'package:app_screens/utils/string_resources.dart';
import 'package:flutter/material.dart';

class InviteGuest extends StatelessWidget {
  const InviteGuest({super.key});

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

        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,

            border: Border.all(color: Colors.grey, width: 1.5),
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
      ],
    );
  }
}
