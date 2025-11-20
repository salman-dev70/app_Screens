import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? labeltext;
  final String hintText;
  final bool isRequired;
  final String? Function(String?)? valdiator;
  final Widget? suffixicon;
  final Widget? prefixIcon;
  final int? maxLine;
  final bool readOnly;
  final bool enable;
  final void Function(String)? onChanged;
  final VoidCallback? onPressed;
  final List<String>? dropdownOptions;
  final Function(String)? onOptionSelected;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labeltext,
    required this.hintText,
    required this.isRequired,
    this.valdiator,
    this.suffixicon,
    this.maxLine,
    this.readOnly = false,
    this.enable = true,
    this.onChanged,
    this.prefixIcon,
    this.onPressed,
    this.dropdownOptions,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            labeltext!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: onPressed,
            child: TextFormField(
              enabled: enable,

              validator: valdiator,
              controller: controller,
              maxLines: maxLine,
              onChanged: onChanged,
              style: TextStyle(color: Colors.black),

              decoration: InputDecoration(
                hint: Text(hintText, style: TextStyle(color: Colors.grey)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 226, 226, 226),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon:
                    dropdownOptions != null ? _buildDropdownMenu() : suffixicon,
                prefixIcon: prefixIcon,
                // contentPadding: const EdgeInsets.symmetric(
                //   horizontal: 16,
                //   vertical: 12,
                // ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownMenu() {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
      onSelected: (String value) {
        controller.text = value;
        onOptionSelected?.call(value);
      },
      itemBuilder: (BuildContext context) {
        return dropdownOptions!.map<PopupMenuEntry<String>>((String value) {
          return PopupMenuItem<String>(value: value, child: Text(value));
        }).toList();
      },
    );
  }
}
