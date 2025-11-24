import 'package:get/get.dart';

class GuestModel {
  final String name;
  final String city;
  final String image;
  RxBool isInvite = false.obs;

  GuestModel({
    required this.name,
    required this.city,
    required this.image,
    bool isInvited = false,
  });
}
