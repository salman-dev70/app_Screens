import 'package:flutter/material.dart';

class AppbarBackIconWidget extends StatelessWidget {
  const AppbarBackIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Center(
        child: Container(
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: const Offset(0, 0.5),
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              padding: EdgeInsets.only(left: 6.5),
            ),
          ),
        ),
      ),
    );
  }
}
