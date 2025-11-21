import 'package:flutter/material.dart';

class GenderChipWidget extends StatelessWidget {
  final String label;
  final List<String> selectedValues;
  final Function(String) onChanged;
  final String buttonValue1;
  final String buttonValue2;
  final String buttonValue3;

  const GenderChipWidget({
    Key? key,
    required this.label,
    required this.selectedValues,
    required this.onChanged,
    required this.buttonValue1,
    required this.buttonValue2,
    required this.buttonValue3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildGenderChip(buttonValue1),
            SizedBox(width: 5),
            _buildGenderChip(buttonValue2),
            SizedBox(width: 5),
            _buildGenderChip(buttonValue3),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderChip(String gender) {
    final isSelected = selectedValues.contains(gender);

    return GestureDetector(
      onTap: () {
        onChanged(gender);
      },
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? const Color.fromARGB(255, 139, 199, 248)
                  : const Color.fromARGB(255, 241, 241, 241)!,
          // Yahan ! lagayein
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              _getGenderIcon(gender),
              color: isSelected ? Colors.black : Colors.black,

              size: 19,
            ),
            SizedBox(width: 1),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.black,
                // Yahan bhi ! lagayein
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getGenderIcon(String gender) {
    switch (gender) {
      case 'Male':
        return Icons.male;
      case 'Female':
        return Icons.female;
      case 'Other':
        return Icons.transgender;
      default:
        return Icons.person;
    }
  }
}
