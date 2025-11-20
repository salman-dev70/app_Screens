import 'package:flutter/material.dart';

class RadioButtonGender extends StatelessWidget {
  final String label;
  final String buttonValue1;
  final String buttonValue2;
  final String buttonValue3;
  final String selectedValue;
  final Function(String) onChanged;

  const RadioButtonGender({
    Key? key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
    required this.buttonValue1,
    required this.buttonValue2,
    required this.buttonValue3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              spacing: 13,
              children: [
                _buildButton(buttonValue1, Icon(Icons.male, size: 15)),
                _buildButton(buttonValue2, Icon(Icons.female, size: 15)),
                _buildButton(
                  buttonValue3,
                  Icon(Icons.accessible_rounded, size: 15),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildButton(String option, Widget icon) {
    bool isSelected = selectedValue == option;

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        clipBehavior: Clip.none,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color:
              isSelected
                  ? const Color.fromARGB(255, 135, 178, 252)
                  : const Color.fromARGB(255, 230, 229, 229),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(
                    option,
                    style: TextStyle(
                      color:
                          isSelected
                              ? const Color.fromARGB(255, 48, 47, 47)
                              : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
