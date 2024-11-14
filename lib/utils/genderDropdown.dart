import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;
  final Size size;

  const GenderDropdown({
    super.key,
    required this.size,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns label to the left
      children: [
        Text(
          "gender".tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: size.width / 2 - size.width / 8 - 23,
          child: SizedBox(
            height: 40,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffE0EAFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
              ),
              value: selectedGender,
              items: [
                DropdownMenuItem(
                  value: "Male",
                  child: Text(
                    "male".tr(),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                DropdownMenuItem(
                  value: "Female",
                  child: Text(
                    "female".tr(),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
              onChanged: onGenderChanged,
            ),
          ),
        ),
      ],
    );
  }
}
