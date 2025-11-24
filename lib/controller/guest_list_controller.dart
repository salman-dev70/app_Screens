import 'package:app_screens/model/guest_model.dart';
import 'package:get/get.dart';

class GuestController extends GetxController {
  RxList<GuestModel> guests =
      <GuestModel>[
        GuestModel(
          name: "Michael Brown",
          city: "Los Angeles, CA",
          image: "https://picsum.photos/id/237/200/300",
        ),
        GuestModel(
          name: "David Davis",
          city: "Los Angeles, CA",
          image: "https://picsum.photos/seed/picsum/200/300",
        ),
        GuestModel(
          name: "Richard Miller",
          city: "Los Angeles, CA",
          image: "https://picsum.photos/200/300?grayscale",
        ),
        GuestModel(
          name: "Joseph Anderson",
          city: "Los Angeles, CA",
          image: "https://picsum.photos/200/300/?blur",
        ),
        GuestModel(
          name: "Silas Walker",
          city: "Los Angeles, CA",
          image: "https://picsum.photos/id/237/200/300",
        ),
      ].obs;

  RxList<GuestModel> invitedUsers = <GuestModel>[].obs;

  void toggleInvite(GuestModel user) {
    user.isInvite.value = !user.isInvite.value;

    if (user.isInvite.value) {
      invitedUsers.add(user);
    } else {
      invitedUsers.remove(user);
    }
  }
}
