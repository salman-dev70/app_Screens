import 'package:flutter/material.dart';

class RadioButtonGroup extends StatelessWidget {
  final String label;
  final String buttonValue1;
  final String buttonValue2;
  final String selectedValue;
  final Function(String) onChanged;

  const RadioButtonGroup({
    Key? key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
    required this.buttonValue1,
    required this.buttonValue2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            children: [_buildButton(buttonValue1), _buildButton(buttonValue2)],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildButton(String option) {
    bool isSelected = selectedValue == option;

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        clipBehavior: Clip.none,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.blue : Colors.white,
          border: Border(right: BorderSide(color: Colors.white)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onChanged(option),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Center(
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
